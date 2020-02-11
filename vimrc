"""""""""""""""""""""""""
" Basic features
"""""""""""""""""""""""""
let pathogen_disabled = []
if !has('gui_running')
  call add(g:pathogen_disabled, 'css-color')
endif
call pathogen#infect()

" Display options
syntax on
set cursorline
set number
set list!                       " Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
if $TERM =~ '256color'
  set t_Co=256
elseif $TERM =~ '^xterm$'
  set t_Co=256
endif
colorscheme molokai

" Misc
filetype plugin indent on       " Do filetype detection and load custom file plugins and indent files
set hidden                      " Don't abandon buffers moved to the background
set wildmenu                    " Enhanced completion hints in command line
set wildmode=list:longest,full  " Complete longest common match and show possible matches and wildmenu
set backspace=eol,start,indent  " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d    " Do lots of scanning on tab completion
set updatecount=100             " Write swap file to disk every 100 chars
set directory=~/.vim/swap       " Directory to use for the swap file
set diffopt=filler,iwhite       " In diff mode, ignore whitespace changes and align unchanged lines
set history=1000                " Remember 1000 commands
set scrolloff=3                 " Start scrolling 3 lines before the horizontal window border
set visualbell t_vb=            " Disable error bells
set shortmess+=A                " Always edit file, even when swap file is found
set foldlevelstart=99

" up/down on displayed lines, not real lines. More useful than painful.
noremap k gk
noremap j gj

" Formatting, indentation and tabbing
set autoindent smartindent
set smarttab                    " Make <tab> and <backspace> smarter
set expandtab
set tabstop=2
set shiftwidth=2
set textwidth=80
set formatoptions-=t formatoptions+=croql

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :1000 : up to 1000 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:1000,n~/.vim/viminfo

" ctags: recurse up to home to find tags. See
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" for an explanation and other ctags tips/tricks
set tags+=tags;$HOME

" Undo
set undolevels=10000
if has("persistent_undo")
  set undodir=~/.vim/undo       " Allow undoes to persist even after a file is closed
  set undofile
endif

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" to_html settings
let html_number_lines = 1
let html_ignore_folding = 1
let html_use_css = 1
let xml_use_xhtml = 1

" When opening a file, always jump to the last cursor position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \     exe "normal g'\"zz" |
    \ endif |


" After 4s of inactivity, check for external file modifications on next keyrpress
au CursorHold * checktime

"""""""""""""""""""""""""
" Keybindings
"""""""""""""""""""""""""
let mapleader=","
let localmapleader=","

nmap <Leader>s :%S/
vmap <Leader>s :S/

vnoremap . :normal .<CR>
vnoremap @ :normal! @

" Toggles
set pastetoggle=<F1>
" the nmap is just for quicker powerline feedback
nmap <silent> <F1>      :set invpaste<CR>
nmap          <F2>      :setlocal spell!<CR>
imap          <F2> <C-o>:setlocal spell!<CR>
nmap <silent> <F3>      :set invwrap<CR>
" TODO toggle numbers

map <Leader>/ :nohlsearch<cr>
map <Home> :tprev<CR>
map <End>  :tnext<CR>

" TODO Do also cnext and cprev as a fallback
map <PageDown> :lnext<CR>
map <PageUp>   :lprev<CR>

" Make Y consistent with D and C
function! YRRunAfterMaps()
  nnoremap <silent> Y :<C-U>YRYankCount 'y$'<CR>
endfunction

" Disable K for manpages - not used often and easy to accidentally hit
noremap K k

" Resize window splits
" TODO Fix mousewheel
nnoremap <Up>    3<C-w>-
nnoremap <Down>  3<C-w>+
nnoremap <Left>  3<C-w><
nnoremap <Right> 3<C-w>>

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

vmap s :!sort<CR>
vmap u :!sort -u<CR>

" shift+k -> like shift+j, but no extra space
noremap <S-k> gJ

" Write file when you forget to use sudo
cmap w!! w !sudo tee % >/dev/null

"""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""
nnoremap <Leader>b :BufSurfBack<cr>
nnoremap <Leader>f :BufSurfForward<cr>

nnoremap <S-u> :GundoToggle<CR>
let g:gundo_close_on_revert=1


" TODO Merge the NERDTreeFind with Toggle inteilligently.
nnoremap <C-g> :NERDTreeToggle<cr>

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                   \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1

nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>

nnoremap <Leader>a :Ack 

" Put a space around comment markers
let g:NERDSpaceDelims = 1

nnoremap <C-y> :YRShow<cr>
let g:yankring_history_dir = '$HOME/.vim'
let g:yankring_manual_clipboard_check = 0

" let g:syntastic_enable_signs=1
" let g:syntastic_auto_loc_list=1
" let g:syntastic_mode_map = { 'mode': 'active',
                           " \ 'active_filetypes': [],
                           " \ 'passive_filetypes': ['tex', 'c', 'scss', 'html', 'scala'] }
" let g:syntastic_javascript_checkers = ['jsxhint']
" let g:syntastic_quiet_messages = {"regex": 'assigned but unused variable'}

let g:quickfixsigns_classes = ['qfl', 'vcsdiff', 'breakpoints']
let g:quickfixsign_use_dummy = 0
" Added BufEnter event to refresh when we come back to a file
let g:quickfixsigns_class_vcsdiff = { 'sign': '*quickfixsigns#vcsdiff#Signs',
                                    \ 'get': 'quickfixsigns#vcsdiff#GetList(%s)',
                                    \ 'event': ['BufEnter', 'BufRead', 'BufWritePost'],
                                    \ 'level': 6}

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.linenr = ''
let g:airline_section_b = '%-0.15{getcwd()}'
  let g:airline_theme_patch_func = 'AirlineThemePatch'
  function! AirlineThemePatch(palette)
    if g:airline_theme == 'dark'
      let a:palette.normal_paste = copy(a:palette.normal)
      let a:palette.normal_paste['airline_a'] = copy(a:palette.normal_paste['airline_a'])
      let a:palette.normal_paste['airline_a'][3] = 124
      let a:palette.normal_paste['airline_a'][2] = 255
    endif
  endfunction

set laststatus=2

let g:ctrlp_map = '<Leader>.'
let g:ctrlp_custom_ignore = '/\.\|\.o\|\.so'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_regexp = 1
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
map <Leader>, :CtrlPMRU<CR>

noremap \= :Tabularize /=<CR>
noremap \: :Tabularize /^[^:]*:\zs/l0l1<CR>
noremap \> :Tabularize /=><CR>
noremap \, :Tabularize /,\zs/l0l1<CR>
noremap \{ :Tabularize /{<CR>
noremap \\| :Tabularize /\|<CR>
noremap \& :Tabularize /\(&\\|\\\\\)<CR>

nnoremap <Leader>t :TagbarOpen fjc<CR>

" Screen settings
let g:ScreenImpl = 'Tmux'
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellInitialFocus = 'shell'
let g:ScreenShellQuitOnVimExit = 0

map <C-\> :ScreenShellVertical<CR>

"""""""""""""""""""""""""
" Ruby Stuff
"""""""""""""""""""""""""
command -nargs=? -complete=shellcmd W  :w | :call ScreenShellSend("load '".@%."';")
map <Leader>r :w<CR> :call ScreenShellSend("rspec ".@% . ':' . line('.'))<CR>
map <Leader>e :w<CR> :call ScreenShellSend("cucumber --format=pretty ".@% . ':' . line('.'))<CR>
map <Leader>w :w<CR> :call ScreenShellSend("break ".@% . ':' . line('.'))<CR>
map <Leader>m :w<CR> :call ScreenShellSend("\e[A")<CR>

"""""""""""""""""""""""""
" Cscope
"""""""""""""""""""""""""
if has("cscope")
  " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  set cscopetag

  " Check cscope for definition of a symbol before checking ctags. Set to 1 if
  " you want the reverse search order.
  set csto=0

  " Add any cscope database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  endif

  " Show msg when any other cscope db is added
  set cscopeverbose
end

"""""""""""""""""""""""""
" Local config
"""""""""""""""""""""""""
so ~/.vim/vimrc.mine

" TODO raise contrast for comments

" autocmd FileType markdown setlocal syntax=off

let g:vim_json_syntax_conceal = 0


"" Rainbow config
let g:rainbow_conf = { 'ctermfgs': ['red', 'yellow', 'green', 'cyan', 'magenta', 'red', 'yellow', 'green', 'cyan', 'magenta'] }
let g:rainbow_matching_filetypes = ['lisp', 'scheme', 'clojure', 'javascript', 'html']

let g:rainbow_active = 0

"function s:load()
"  if count(g:rainbow_matching_filetypes, &ft) > 0
"    call rainbow#hook()
"  endif
"endfunction
"
"augroup rainbow
"  autocmd!
"  autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * nested call s:load()
"augroup END

" fix for vim-javascript + rainbow incompatibility
" autocmd FileType javascript syntax clear jsFuncBlock

set nocursorline

"au FileType rust nmap <C-]> <Plug>(rust-def)
"au FileType rust nmap <C-[> <Plug>(rust-doc)

"set ts=8 sw=8
"nmap <C-J> gJi <ESC>diW
