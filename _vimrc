set modelines=0 " disable security holes
set nocompatible " not compatiable with vi
set encoding=utf-8

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'w0ng/vim-hybrid'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'
Bundle "tommcdo/vim-exchange"
Bundle "klen/python-mode"

filetype plugin indent on " enable loading indent file for filetype

set history=700
set undolevels=700
""" appearance
set title " show title in console title bar

""" completions
set wildmode=longest,list " <Tab> cycles between all matching choices.
set wildignore+=*.o,*.obj,.git,*.pyc,.svn,.bzr
set tildeop
set completeopt=longest

""" don't bell or blink
set noerrorbells
set vb t_vb=

""" Moving Around/Editing
"set cursorline " have a line indicate the cursor location
set nostartofline " Avoid moving cursor to BOL when jumping around
set virtualedit=block " Let cursor move past the last char in <C-v> mode
set scrolloff=5 " Keep context lines above and below the cursor
set backspace=2 " Allow backspacing over autoindent, EOL, and BOL

""" line endings/length
set textwidth=79
set formatoptions=tcroqn1
set colorcolumn=+1 "one beyond textwidth
"#highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
set nowrap " don't wrap text
set linebreak " don't wrap textin the middle of a word
set ffs=unix,dos,mac " Try recognizing dos, unix, and mac line endings.

""" indentation
set tabstop=4 " <tab> inserts 4 spaces
set shiftwidth=4 " but an indent level is 2 spaces wide.
set softtabstop=4 " <BS> over an autoindent deletes both spaces.
set expandtab " Use spaces, not tabs, for autoindent/tab key.
set shiftround " rounds indent to a multiple of shiftwidth

""" brackets matching
set showmatch " Briefly jump to a paren once it's balanced
set matchpairs+=<:> " show matching <> (html mainly) as well

""" saving
set nobackup
set nowritebackup
set noswapfile
set noautowrite " Never write a file unless I request it.
set noautowriteall " NEVER.
set noautoread " Don't automatically re-read changed files.

"""" Messages, Info, Status
set ls=2 " allways show status line
set vb t_vb= " Disable all bells. I hate ringing/flashing.
set confirm " Y-N-C prompt if closing with unsaved changes.
set showcmd " Show incomplete normal mode commands as I type.
set report=0 " : commands always print changed line count.
set shortmess+=a " Use [+]/[RO]/[w] for modified/readonly/written.
set laststatus=2 " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:->,trail:-,precedes:<,extends:>
autocmd Filetype go setlocal nolist
set list
set rtp+=$GOROOT/misc/vim
autocmd BufWritePre *.go :silent Fmt

""" Searching and Patterns
" sane regex
set ignorecase " Default to using case insensitive searches,
set smartcase " unless uppercase letters are used in the regex.
set gdefault " global by default
set smarttab " Handle tabs more intelligently
set hlsearch " Highlight searches by default.
set incsearch " Incrementally search while typing a /regex

" copying and pasting
set clipboard=unnamed
set pastetoggle=<F2>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" sudo write this
cnoremap W! w !sudo tee % >/dev/null
cnoremap w!! w !sudo tee % >/dev/null

" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
inoremap <C-W> <C-O><C-W>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" don't lose selection after reindenting
vnoremap < <gv
vnoremap > >gv

set splitbelow

" ===========================================================
" auto/FileType specific changes
" ============================================================

"Javascript
augroup js
    autocmd!
    au BufRead *.js set makeprg=jslint\ %
augroup END

" Python
" au BufRead *.py compiler nose
" au FileType python set omnifunc=pythoncomplete#Complete
augroup py
    autocmd!
    au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
    " \ nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<tab>"
    else
        return "\<C-P>"
    endif
endfunction
inoremap <Tab> <C-R>=SuperCleverTab()<cr>

" syntax enable
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_enable_signs=1
" let g:syntastic_python_flake8_args='--ignore=E712,E711 --max-complexity=12'

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>T :execute '!make test'<cr>
nnoremap <leader>t :execute '!PYTHONWARNINGS="d" TRAPIT_ENV=test nosetests -s %'<cr>
nnoremap <leader>s :execute '!PYTHONWARNINGS="d" python setup.py test'<cr>
nnoremap <leader>p :execute '!PYTHONWARNINGS="d" py.test %:p:h'<cr>

" hybrid colorscheme
let g:hybrid_use_Xresources = 1
colorscheme hybrid

" powerline
let g:netrw_keepdir=0

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
autocmd Filetype gitcommit setlocal spell textwidth=72

" reload .vimrc after saving
autocmd! BufWritePost .vimrc source %


" better command line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>

let g:pymode = 1
let g:pymode_options = 1
let g:pymode_folding = 0
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_virtualenv = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_unmodified = 1
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
let g:pymode_lint_cwindow = 1
let g:pymode_lint_signs = 1
let g:pymode_rope_regenerate_on_write = 1
let g:pymode_rope_show_doc_bind = '<C-c>d'
let g:pymode_rope_organize_imports_bind = '<C-c>ro'
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

nnoremap <leader>v :PymodeVirtualenv "./.virt"<cr>
