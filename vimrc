set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
"Plugin 'powerline/powerline', {'rtp': 'powerline/powerline/bindings/vim/'}
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'moll/vim-node.git'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'kchmck/vim-coffee-script'
Plugin 'garbas/vim-snipmate'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'honza/vim-snippets'
Plugin 'lrvick/Conque-Shell'
Plugin 'tpope/vim-surround'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mbbill/undotree'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"set nowrap        " don't wrap lines
"
set encoding=utf-8
set termencoding=utf-8
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set scrolloff=8   " 8 lines at least

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
"set visualbell           " don't beep
set noerrorbells         " don't beep
set wildmenu			" Better command line completion
set wildmode=list:longest,full
set cul

if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif

"open tag in vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Ctrl+b lists open buffers. Ctrlp thing
map <C-b> :CtrlPBuffer<CR>

set pastetoggle=<F2>
nnoremap <silent> <F6> :TagbarToggle<CR> 	" For tag bar

nnoremap ; :
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Remove highlight on ,/
nmap <silent> ,/ :nohlsearch<CR>

cmap w!! w !sudo tee % >/dev/null

compiler gcc


" Correct typos
:command WQ wq
:command Wq wq
:command W w
:command Q q

"For powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " always display the statusline in all windows
"set showtabline=2 " always display the tabline, even if there is only one tab
let g:powerline_symbols = 'fancy'
set noshowmode " hide the default mode text (e.g. -- insert -- below the statusline)


noremap <silent> <F3>  :NERDTreeToggle <CR>

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1

"set grepprg=git\ grep\ -n\ -i "use git grep for search
set grepprg=ack

command Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw "List all todos and fixmes


" Python ================
au FileType python set omnifunc=jedi#completions
" au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

"for pyflakes
let g:pyflakes_use_quickfix = 0 "pyflakes no quickfix window

let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 1

" for jedi
autocmd FileType python setlocal completeopt-=preview
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"
let g:jedi#popup_select_first = 1
"=========================
"


" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
" set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'


" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv


au InsertLeave * set nopaste

" autocmd VimEnter * NERDTree
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

autocmd BufNewFile,BufRead *.json set ft=javascript " highlight json
au BufNewFile,BufRead *.god setlocal ft=rb

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

noremap Q !!$SHELL<CR>


"let g:solarized_termcolors=256
set background=dark
colorscheme Solarized

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
autocmd BufNewFile,BufReadPost *.hs setl shiftwidth=4 expandtab

"if (exists('+colorcolumn'))
"	    set colorcolumn=101
"	        highlight ColorColumn ctermbg=9
"		endif
