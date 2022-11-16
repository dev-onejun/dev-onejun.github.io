set nocompatible              " required
filetype off                  " required

" Split Configuration
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

" UTF-8 Support
set encoding=utf-8

" Line Numbering
set nu

" enable backspace on mac
set backspace=indent,eol,start

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
"" Code Folding
Plugin 'tmhedberg/SimpylFold'

"" Auto-Indentation
Plugin 'vim-scripts/indentpython.vim'

"" Syntax Checking/Highlighting (1)
Plugin 'vim-syntastic/syntastic'
""" PEP 8 Syntax Checking
Plugin 'nvie/vim-flake8'

"" Color Schemes (1)
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

"" File Browsing (1)
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

"" Super Searching
Plugin 'kien/ctrlp.vim'

"" Git Integration
Plugin 'tpope/vim-fugitive'

"" Powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" PEP 8
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" for another filetype
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" Flagging Unnecessary Whitespace
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Auto-Complete
"" YouCompleteMe
Bundle 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"" sql-completion
Bundle 'vim-scripts/dbext.vim'

" Python Virtual Environment Support
python3 << EOF
import os
import subprocess

if "VIRTUAL_ENV" in os.environ:
    project_base_dir = os.environ["VIRTUAL_ENV"]
    script = os.path.join(project_base_dir, "bin/activate")
    pipe = subprocess.Popen(". %s; env" % script, stdout=subprocess.PIPE, shell=True)
    output = pipe.communicate()[0].decode('utf8').splitlines()
    env = dict((line.split("=", 1) for line in output))
    os.environ.update(env)

EOF

" Syntax checking/Highlighting (2)
let python_highlight_all=1
syntax on

" Color Schemes (2)
if has('gui_running')
  set background=light
  colorscheme solarized
else
  set background=dark
  set t_Co=256
  syntax enable
  colorscheme zenburn
endif
call togglebg#map("<F5>")

" File Browsing (2)
"" cf. <Leader> is \, so below command is \ + n
map <Leader>n <plug>NERDTreeTabsToggle<CR>
"" to hide .pyc files in NERDTree
""let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
