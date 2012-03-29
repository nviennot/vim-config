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
set undolevels=10000            " number of forgivable mistakes
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

let xml_use_xhtml = 1

set directory=~/.vim/swap
set undodir=~/.vim/undo
set undofile

map <F1> :set guifont=Monospace\ 9<CR>:set lines=45<CR>:set columns=150<CR>
map <F2> :set guifont=Monospace\ 14<CR>

nnoremap <F5> :GundoToggle<CR>

let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
			   \ 'active_filetypes': [],
			   \ 'passive_filetypes': ['c', 'scss'] }
 
let g:quickfixsigns_classes=['qfl', 'vcsdiff', 'breakpoints']

let g:Powerline_symbols = 'unicode'

set laststatus=2

set mouse=a
