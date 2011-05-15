filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype plugin indent on

if $TERM =~ '256color'
  set t_Co=256
elseif $TERM =~ '^xterm$'
  set t_Co=256
endif

set cursorline
colorscheme molokai
set number

set autoindent smartindent      " turn on auto/smart indenting
set smarttab                    " make <tab> and <backspace> smarter
set tabstop=8                   " tabstops of 8
set shiftwidth=8                " indents of 8
set backspace=eol,start,indent  " allow backspacing over indent, eol, & start
set undolevels=1000             " number of forgivable mistakes
set updatecount=100             " write swap file to disk every 100 chars
set complete=.,w,b,u,U,t,i,d    " do lots of scanning on tab completion
set viminfo=%100,'100,/100,h,\"500,:100,n~/.vim/viminfo

set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

set diffopt=filler,iwhite       " ignore all whitespace and sync

nnoremap <C-g> :NERDTreeToggle<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$' ]
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1

let g:yankring_history_dir = '$HOME/.vim'

let html_number_lines = 0
let html_ignore_folding = 1
let html_use_css = 1
"let html_no_pre = 0
"let use_xhtml = 1

set ls=2 " Always show status line
if has('statusline')
   function SetStatusLineStyle()
       let &stl="%f %y%([%R%M]%) %#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%* %{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=%#Search# %{fugitive#statusline()} %#StatusLine# #%n %4.l/%L %3v %3.p%%"
   endfunc
   " Switch between the normal and vim-debug modes in the status line
   nmap _ds :call SetStatusLineStyle()<CR>
   call SetStatusLineStyle()
   " Window title
   if has('title')
      set titlestring=%t%(\ [%R%M]%)
   endif
endif 


command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplorerMoreThanOne = 10000
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplSplitBelow=1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplVSplit = 20


map <M-j> :bn<cr>
map <M-k> :bp<cr>
map <C-PageDown> :cnext<cr>
map <C-PageUp> :cprev<cr>

set wildmenu
"set autochdir
set hidden

:command -bar -nargs=1 OpenURL :!firefox <args>

" CleanClose
nmap fc :call CleanClose(1)<cr>
nmap fq :call CleanClose(0)<cr>
function! CleanClose(tosave)
if (a:tosave == 1)
    w!
endif
let todelbufNr = bufnr("%")
let newbufNr = bufnr("#")
if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
    exe "b".newbufNr
else
    bnext
endif

if (bufnr("%") == todelbufNr)
    new
endif
exe "bd!".todelbufNr
endfunction
""""""""""""""""""""""""""""""""""""""""

let mapleader=","
let localmapleader=","
map <Leader>ss :setlocal spell!<cr>
map <Leader>/ :nohlsearch<cr>
map <Leader>l :MiniBufExplorer<cr>

map <M-[> :tprev<CR>
map <M-]> :tnext<CR>

set list!
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«

vnoremap . :normal .<CR>
vnoremap @ :normal! @
map <silent> <C-u> :YRShow<CR>

set undolevels=10000
let xml_use_xhtml = 1

" FuzzyFinder
let g:fuf_modesDisable = []
let g:fuf_abbrevMap = { }
let g:fuf_mrufile_maxItem = 300
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> <C-d><C-p> :FufFileWithFullCwd<CR>
nnoremap <silent> <C-d><C-f> :FufFile<CR>
nnoremap <silent> <C-d><C-d> :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <C-d>d     :FufDirWithFullCwd<CR>
nnoremap <silent> <C-d>D     :FufDir<CR>
nnoremap <silent> <C-d><C-j> :FufMruFile<CR>
nnoremap <silent> <C-d><C-k> :FufMruCmd<CR>
nnoremap <silent> <C-d><C-b> :FufBookmark<CR>
nnoremap <silent> <C-d><C-t> :FufTag<CR>
nnoremap <silent> <C-d>t     :FufTag!<CR>
noremap  <silent> g]         :FufTagWithCursorWord!<CR>
nnoremap <silent> <C-d>f     :FufTaggedFile<CR>
nnoremap <silent> <C-d><C-j> :FufJumpList<CR>
nnoremap <silent> <C-d><C-g> :FufChangeList<CR>
nnoremap <silent> <C-d><C-q> :FufQuickfix<CR>
nnoremap <silent> <C-d><C-l> :FufLine<CR>
nnoremap <silent> <C-d><C-h> :FufHelp<CR>
nnoremap <silent> <C-d><C-b> :FufAddBookmark<CR>
vnoremap <silent> <C-d><C-b> :FufAddBookmarkAsSelectedText<CR>
nnoremap <silent> <C-d><C-r> :FufRenewCache<CR>

set directory=~/.vim/swap

map <F1> :set lines=75<CR>:set columns=135<CR>
map <F2> :set lines=75<CR>:set columns=210<CR>

nnoremap <F5> :GundoToggle<CR>

let g:syntastic_enable_signs=1
let g:syntastic_disabled_filetypes=['c']

let g:quickfixsigns_classes=['qfl', 'vcsdiff', 'breakpoints']
