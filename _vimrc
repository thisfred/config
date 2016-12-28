filetype off                  " required

call plug#begin('~/.vim/bundle')

Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'derekwyatt/vim-scala', {'for': 'scala'}
Plug 'ensime/ensime-vim', {'for': 'scala', 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'michaeljsmith/vim-indent-object'
Plug 'python-rope/ropevim', {'for': 'python'}
Plug 'rhysd/committia.vim'
Plug 'scrooloose/syntastic'
Plug 'thisfred/breakfast', {'for': 'python', 'rtp': 'vim'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

call plug#end()

set modelines=0 " disable security holes

set relativenumber
set number
let mapleader=","
set path+=**
set history=10000
set undolevels=1000
set undofile
set inccommand=split

""" appearance
set title " show title in console title bar

""" completions
set wildmenu
set wildmode=longest,list,full
set wildignore+=*.o,*.obj,.git,*.pyc,.svn,.bzr,__pycache__,.ensime_cache,**/target/**,.git,.m2,.tox,.venv
set tildeop
set complete=.,w,b,u,t,i,kspell
set tags=tags
set completeopt=menu

function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    else
        " if &omnifunc != ''
        "     return "\<C-X>\<C-O>"
        " else
        if &dictionary != ''
            return "\<C-K>"
        else
            return "\<C-N>"
        endif
    endif
endfunction
inoremap <Tab> <C-R>=SuperCleverTab()<cr>

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
set confirm " Y-N-C prompt if closing with unsaved changes.
set showcmd " Show incomplete normal mode commands as I type.
set report=0 " : commands always print changed line count.
set shortmess+=a " Use [+]/[RO]/[w] for modified/readonly/written.
set laststatus=2 " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})
set showtabline=1

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:->,trail:-,precedes:<,extends:>

""" Searching and Patterns
" sane regex
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
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>
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
set splitright

func! DeleteTrailingWS()
 " use remapped gm to m, to work with easyclip
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <leader>T :execute '!make test'<cr>


" ## Plugins

" deoplete.
let g:deoplete#enable_at_startup = 1

" # fugitive

let g:fugitive_github_domains = ['https://github.banksimple.com']

" # rhubarb

let g:github_enterprise_urls = ['https://github.banksimple.com']

" # syntastic

syntax enable

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

hi link SyntasticErrorSign Error
hi link SyntasticWarningSign Search
hi link SyntasticError Error
hi link SyntasticWarning Search

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol='!'
let g:syntastic_loc_list_height=10
let g:syntastic_python_checkers = ['flake8', 'pylint', 'mypy']
let g:syntastic_python_flake8_args = '--ignore=E712,E711 --max-complexity=12'
let g:syntastic_python_pylint_args = '-d unnecessary-semicolon,multiple-statements,missing-docstring,superfluous-parens,invalid-name'
let g:syntastic_python_mypy_args = '--strict-optional'
let g:syntastic_style_error_symbol='x'
let g:syntastic_style_warning_symbol='~'
let g:syntastic_warning_symbol='?'
" # neomake

let g:neomake_open_list = 1
let g:neomake_verbose = 1
let g:neomake_logfile = 'neomake.log'

let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-ocean
set background=dark

" ## auto/FileType specific changes

" # Python

augroup py
    autocmd!
    au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 tw=79
      \ nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
    autocmd BufWritePre *.py :call DeleteTrailingWS()
augroup END

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
nnoremap <silent><Leader>p <Esc>:Pytest file<CR>
nnoremap <silent><Leader>c <Esc>:Pytest class<CR>
nnoremap <silent><Leader>m <Esc>:Pytest method<CR>
nnoremap <silent><Leader>f <Esc>:Pytest function<CR>

let g:ropevim_goto_def_newwin = 'vnew'

" git commits
augroup git
    autocmd!
    autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

" # Go
augroup go
    autocmd!
    autocmd FileType go autocmd BufWritePre <buffer> GoFmt
augroup END

" markdown
augroup md
    autocmd!
    autocmd BufWritePre *.md :call DeleteTrailingWS()
    autocmd Filetype markdown setlocal spell textwidth=72
augroup END

" java
augroup java
    autocmd!
    autocmd BufWritePre *.java :call DeleteTrailingWS()
augroup END

" Scala :(

let g:syntastic_scala_scalastyle_jar = '~/scalastyle/scalastyle_2.11-0.8.0-20150902.090323-5-batch.jar'
let g:syntastic_scala_scalastyle_config_file = '~/scalastyle/scalastyle_config.xml'
let g:syntastic_scala_checkers = ['scalastyle', 'ensime', 'fsc']
let g:syntastic_mode_map = { 'mode': 'active' }

if has('autocmd')
    function! FindClasspath(where)
        let cpf = findfile('.classpath', escape(a:where, ' ') . ';')
        let sep = syntastic#util#isRunningWindows() || has('win32unix') ? ';' : ':'
        try
            return cpf !=# '' ? [ '-classpath', join(readfile(cpf), sep) ] : []
        catch
            return []
        endtry
    endfunction

    let g:syntastic_scala_fsc_args = [
        \ '-Xfatal-warnings:false',
        \ '-Xfuture',
        \ '-Xlint',
        \ '-Ywarn-adapted-args',
        \ '-Ywarn-dead-code', 
        \ '-Ywarn-inaccessible',
        \ '-Ywarn-infer-any',
        \ '-Ywarn-nullary-override',
        \ '-Ywarn-nullary-unit',
        \ '-Ywarn-numeric-widen',
        \ '-Ywarn-unused-import',
        \ '-Ywarn-value-discard',
        \ '-deprecation',
        \ '-encoding', 'UTF-8',
        \ '-feature',
        \ '-language:existentials',
        \ '-language:higherKinds', 
        \ '-language:implicitConversions',
        \ '-unchecked',
        \ '-d', ($TMPDIR !=# '' ? $TMPDIR : '/tmp') ]

    augroup syntastic_fsc
        autocmd!
        autocmd FileType scala let b:syntastic_scala_fsc_args =
            \ get(g:, 'syntastic_scala_fsc_args', []) +
            \ FindClasspath(expand('<afile>:p:h', 1))
    augroup END
endif

augroup scala
    autocmd!
    autocmd BufWritePre *.scala :call DeleteTrailingWS()
augroup END

" ruby

augroup ruby
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
augroup END

" .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

augroup vimrc
    autocmd!
    autocmd! BufWritePost .vimrc source %
    autocmd! BufWritePost .nvimrc source %
    autocmd! BufWritePost init.vim source %
augroup END

autocmd BufEnter * :syntax sync fromstart
