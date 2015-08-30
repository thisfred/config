set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'NLKNguyen/papercolor-theme'
Plugin 'alfredodeza/pytest.vim'
Plugin 'bling/vim-airline'
Plugin 'derekwyatt/vim-scala'
Plugin 'fisadev/vim-isort'
Plugin 'jnwhiteh/vim-golang'
Plugin 'junegunn/vim-easy-align'
Plugin 'majutsushi/tagbar'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'python-rope/ropevim'
Plugin 'scrooloose/syntastic'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'w0ng/vim-hybrid'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

call vundle#end()            " required
filetype plugin indent on    " required

set modelines=0 " disable security holes
set encoding=utf-8

set t_Co=256
set term=xterm-256color
set termencoding=utf-8

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
set textwidth=100
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
    au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 tw=79
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

let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

syntax enable
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_python_flake8_args = '--ignore=E712,E711 --max-complexity=12'
let g:syntastic_python_prospector_args = '--strictness=veryhigh --profile ~/.prospector/pp.yaml'
" let g:syntastic_python_prospector_sort = 1
let g:syntastic_python_checkers = ['prospector']
let g:syntastic_scala_scalastyle_jar = '~/scalastyle/scalastyle_2.11-0.8.0-20150730.210236-3-batch.jar'
let g:syntastic_scala_scalastyle_config_file = '~/scalastyle/scalastyle_config.xml'
let g:syntastic_scala_checkers = ['scalac', 'fsc', 'scalastyle']
let g:syntastic_scala_fsc_args = '-Xfatal-warnings:false -Xfuture -Xlint -Xlint:adapted-args -Xlint:by-name-right-associative -Xlint:delayedinit-select -Xlint:doc-detached -Xlint:inaccessible -Xlint:infer-any -Xlint:missing-interpolator -Xlint:nullary-override -Xlint:nullary-unit -Xlint:option-implicit -Xlint:package-object-classes -Xlint:poly-implicit-overload -Xlint:private-shadow -Xlint:type-parameter-shadow -Xlint:unsound-match -Yno-adapted-args -Ywarn-adapted-args -Ywarn-dead-code -Ywarn-inaccessible -Ywarn-infer-any -Ywarn-nullary-override -Ywarn-nullary-unit -Ywarn-numeric-widen -Ywarn-unused-import -Ywarn-value-discard -d /private/var/tmp/ -deprecation -encoding UTF-8 -feature -language:existentials -language:higherKinds -language:implicitConversions -unchecked'
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>T :execute '!make test'<cr>
nnoremap <leader>t :execute '!PYTHONWARNINGS="d" TRAPIT_ENV=test nosetests -s %'<cr>

" Pytest
nmap <silent><Leader>p <Esc>:Pytest file<CR>
nmap <silent><Leader>c <Esc>:Pytest class<CR>
nmap <silent><Leader>m <Esc>:Pytest method<CR>
nmap <silent><Leader>f <Esc>:Pytest function<CR>

" hybrid colorscheme
let g:hybrid_use_Xresources = 1
colorscheme hybrid

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
autocmd Filetype gitcommit setlocal spell textwidth=72

" reload .vimrc after saving
autocmd! BufWritePost .vimrc source %


" better command line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>

autocmd FileType go autocmd BufWritePre <buffer> Fmt

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWritePre *.md :call DeleteTrailingWS()
autocmd BufWritePre *.py :call DeleteTrailingWS()
autocmd BufWritePre *.scala :call DeleteTrailingWS()
autocmd BufWritePre *.java :call DeleteTrailingWS()

nmap <F8> :TagbarToggle<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
