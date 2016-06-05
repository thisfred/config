set nocompatible              " be iMproved, required
filetype off                  " required


call plug#begin('~/.vim/bundle')

Plug 'ensime/ensime-vim', {'for': 'scala'}
Plug 'PeterRincker/vim-argumentative'
Plug 'airblade/vim-gitgutter'
Plug 'alfredodeza/pytest.vim', {'for': 'python'}
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'derekwyatt/vim-scala', {'for': 'scala'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'fisadev/vim-isort'
Plug 'fntlnz/atags.vim', {'for': 'scala'}
Plug 'gcmt/wildfire.vim'
Plug 'idris-hackers/idris-vim'
Plug 'junegunn/vim-after-object'
Plug 'kien/ctrlp.vim'
Plug 'mbbill/undotree'
Plug 'michaeljsmith/vim-indent-object'
Plug 'python-rope/ropevim', {'for': 'python'}
Plug 'rhysd/committia.vim'
Plug 'scrooloose/syntastic',
Plug 'tell-k/vim-autopep8', {'for': 'python'}
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'w0ng/vim-hybrid'
Plug 'xolox/vim-misc'

call plug#end()

set modelines=0 " disable security holes
set encoding=utf-8
set termencoding=utf-8

set history=10000
set undolevels=1000
""" appearance
set title " show title in console title bar

""" completions
set wildmode=longest,list " <Tab> cycles between all matching choices.
set wildignore+=*.o,*.obj,.git,*.pyc,.svn,.bzr
set tildeop
"set completeopt=longest

""" don't bell or blink
set noerrorbells

""" Moving Around/Editing
"set cursorline " have a line indicate the cursor location
set nostartofline " Avoid moving cursor to BOL when jumping around
set virtualedit=block " Let cursor move past the last char in <C-v> mode
set scrolloff=5 " Keep context lines above and below the cursor
set backspace=2 " Allow backspacing over autoindent, EOL, and BOL

""" line endings/length
set textwidth=100
set colorcolumn=+1
set formatoptions=tcroqn1
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

" window navigation
map <c-h> <c-w><c-h>
map <c-j> <c-w><c-j>
map <c-k> <c-w><c-k>
map <c-l> <c-w><c-l>
" Move between windows
tnoremap <c-h> <C-\><C-n><C-w>h
tnoremap <c-j> <C-\><C-n><C-w>j
tnoremap <c-k> <C-\><C-n><C-w>k
tnoremap <c-l> <C-\><C-n><C-w>l

" sudo write this
cnoremap W! w !sudo tee % >/dev/null
cnoremap w!! w !sudo tee % >/dev/null

" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
inoremap <C-W> <C-O><C-W>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

set splitbelow


func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<tab>"
    else
        return "\<C-P>"
    endif
endfunction
inoremap <Tab> <C-R>=SuperCleverTab()<cr>

" better command line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <leader>T :execute '!make test'<cr>

" ## Plugins

" # atags


" # vimwiki

let g:vimwiki_list = [{'path': '~/simple/notes'}]

" # fugitive

let g:fugitive_github_domains = ['https://github.banksimple.com']

" # rhubarb

let g:github_enterprise_urls = ['https://github.banksimple.com']

" # autopep8

let g:autopep8_aggressive=3

" # syntastic

syntax enable

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_flake8_args = '--ignore=E712,E711 --max-complexity=12'
let g:syntastic_python_pylint_args = '-d missing-docstring,superfluous-parens'
" let g:syntastic_python_prospector_args = --strictness=veryhigh --profile ~/.prospector/pp.yaml'
" let g:syntastic_python_prospector_sort = v
let g:syntastic_python_checkers = ['flake8', 'pylint']

" # neomake

let g:neomake_open_list = 1
let g:neomake_verbose = 1
let g:neomake_logfile = 'neomake.log'

" # easyalign

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plugin>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plugin>(EasyAlign)

" # airline
let g:airline_powerline_fonts=0
let g:airline_left_sep=''
let g:airline_right_sep=''

" # vim-after-object
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

" # hybrid colorscheme
"let g:hybrid_use_Xresources = 1
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-ocean
set background=dark

" ## auto/FileType specific changes

" # Python

augroup py
    autocmd!
    au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 tw=79
    " \ nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" autocmd! BufWritePost *.py Neomake
autocmd BufWritePre *.py :call DeleteTrailingWS()

let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

let g:neomake_python_pylint_maker = {
    \ 'args': [
        \ '-f', 'text',
        \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
        \ '-r', 'n',
        \ '-d', 'missing-docstring']}

" Pytest
nmap <silent><Leader>p <Esc>:Pytest file<CR>
nmap <silent><Leader>c <Esc>:Pytest class<CR>
nmap <silent><Leader>m <Esc>:Pytest method<CR>
nmap <silent><Leader>f <Esc>:Pytest function<CR>

let g:ropevim_goto_def_newwin = 'vnew'

" git commits
autocmd Filetype gitcommit setlocal spell textwidth=72

" # Go
autocmd FileType go autocmd BufWritePre <buffer> GoFmt

" markdown
autocmd BufWritePre *.md :call DeleteTrailingWS()
autocmd Filetype markdown setlocal spell textwidth=72

" java
autocmd BufWritePre *.java :call DeleteTrailingWS()

" Scala :(

autocmd BufWritePost *.scala call atags#generate()
let g:syntastic_scala_scalastyle_jar = '~/scalastyle/scalastyle_2.11-0.8.0-20150902.090323-5-batch.jar'
let g:syntastic_scala_scalastyle_config_file = '~/scalastyle/scalastyle_config.xml'
" let g:syntastic_scala_fsc_args = '-Xfatal-warnings:false -Xfuture -Xlint -Xlint:adapted-args -Xlint:by-name-right-associative -Xlint:delayedinit-select -Xlint:doc-detached -Xlint:inaccessible -Xlint:infer-any -Xlint:missing-interpolator -Xlint:nullary-override -Xlint:nullary-unit -Xlint:option-implicit -Xlint:package-object-classes -Xlint:poly-implicit-overload -Xlint:private-shadow -Xlint:type-parameter-shadow -Xlint:unsound-match -Yno-adapted-args -Ywarn-adapted-args -Ywarn-dead-code -Ywarn-inaccessible -Ywarn-infer-any -Ywarn-nullary-override -Ywarn-nullary-unit -Ywarn-numeric-widen -Ywarn-unused-import -Ywarn-value-discard -d /private/var/tmp/ -deprecation -encoding UTF-8 -feature -language:existentials -language:higherKinds -language:implicitConversions -unchecked'
let g:syntastic_scala_checkers = ['ensime', 'scalastyle', 'fsc_improved']

autocmd BufWritePre *.scala :call DeleteTrailingWS()
autocmd BufWritePost *.scala :EnTypeCheck 

function! s:LoadClasspathsFromFile(filename)
    let classpath_file = fnamemodify('.classpath', ':p')
    if filereadable(classpath_file)
        return join(readfile(classpath_file), ':')[:-2]
    else
        return ''
    endif
endfunction

if !exists('g:neomake_scala_fsc_smart_classpath_file')
    let g:neomake_scala_fsc_smart_classpath_file = '.classpath'
endif

" let g:neomake_scala_fsclint_maker = {
"         \ 'exe': 'fsc',
"         \ 'errorformat': '%E%f:%l: %trror: %m,%Z%p^,%-G%.%#',
"         \ 'args': [
"            \ '-J-XX:MaxPermSize=2048M',
"            \ '-J-XX:PermSize=512M',
"            \ '-J-Xms512M',
"            \ '-J-Xmx2048M',
"            \ '-J-Xss512M',
"            \ '-Xfatal-warnings:false',
"            \ '-Xfuture',
"            \ '-Xlint',
"            \ '-Xlint:adapted-args',
"            \ '-Xlint:by-name-right-associative',
"            \ '-Xlint:delayedinit-select',
"            \ '-Xlint:doc-detached',
"            \ '-Xlint:inaccessible',
"            \ '-Xlint:infer-any',
"            \ '-Xlint:missing-interpolator',
"            \ '-Xlint:nullary-override',
"            \ '-Xlint:nullary-unit',
"            \ '-Xlint:option-implicit',
"            \ '-Xlint:package-object-classes',
"            \ '-Xlint:poly-implicit-overload',
"            \ '-Xlint:private-shadow',
"            \ '-Xlint:stars-align',
"            \ '-Xlint:type-parameter-shadow',
"            \ '-Xlint:unsound-match',
"            \ '-Yno-adapted-args',
"            \ '-Ywarn-adapted-args',
"            \ '-Ywarn-dead-code',
"            \ '-Ywarn-inaccessible',
"            \ '-Ywarn-infer-any',
"            \ '-Ywarn-nullary-override',
"            \ '-Ywarn-nullary-unit',
"            \ '-Ywarn-numeric-widen',
"            \ '-Ywarn-unused-import',
"            \ '-d /private/var/tmp/',
"            \ '-deprecation',
"            \ '-encoding UTF-8',
"            \ '-feature',
"            \ '-language:existentials',
"            \ '-language:higherKinds',
"            \ '-language:implicitConversions',
"            \ '-unchecked',
"            \ '-classpath ' . s:LoadClasspathsFromFile(g:neomake_scala_fsc_smart_classpath_file) 
"         \ ]
"     \ }

let g:neomake_scala_fsclint_maker = {
        \ 'exe': 'fsc',
        \ 'errorformat': '%E%f:%l: %trror: %m,%Z%p^,%-G%.%#',
        \ 'args': [
            \ '-J-XX:MaxPermSize=2048M',
            \ '-J-XX:PermSize=512M',
            \ '-J-Xms512M',
            \ '-J-Xmx2048M',
            \ '-J-Xss512M',
            \ '-Xlint',
            \ '-Xlint:adapted-args',
            \ '-Xlint:by-name-right-associative',
            \ '-Xlint:delayedinit-select',
            \ '-Xlint:doc-detached',
            \ '-Xlint:inaccessible',
            \ '-Xlint:infer-any',
            \ '-Xlint:missing-interpolator',
            \ '-Xlint:nullary-override',
            \ '-Xlint:nullary-unit',
            \ '-Xlint:option-implicit',
            \ '-Xlint:package-object-classes',
            \ '-Xlint:poly-implicit-overload',
            \ '-Xlint:private-shadow',
            \ '-Xlint:type-parameter-shadow',
            \ '-Xlint:unsound-match',
            \ '-Yno-adapted-args',
            \ '-Ywarn-adapted-args',
            \ '-Ywarn-dead-code',
            \ '-Ywarn-inaccessible',
            \ '-Ywarn-infer-any',
            \ '-Ywarn-nullary-override',
            \ '-Ywarn-nullary-unit',
            \ '-Ywarn-numeric-widen',
            \ '-Ywarn-unused-import',
            \ '-deprecation',
            \ '-feature',
            \ '-language:existentials',
            \ '-language:higherKinds',
            \ '-language:implicitConversions',
            \ '-unchecked',
            \ '-classpath "' . s:LoadClasspathsFromFile(g:neomake_scala_fsc_smart_classpath_file) . '"']}
let g:neomake_scala_enabled_makers = [] " 'fsclint']

au BufEnter *.scala setl formatprg=java\ -jar\ ~/scalariform/cli_2.11-0.1.8-SNAPSHOT-assembly.jar\ -f\ -q\ -danglingCloseParenthesis=prevent\ +doubleIndentClassDeclaration\ --stdin\ --stdout

"Javascript
augroup js
    autocmd!
    au BufRead *.js set makeprg=jslint\ %
augroup END

" .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
autocmd! BufWritePost .vimrc source %
autocmd! BufWritePost .nvimrc source %
