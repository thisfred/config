filetype off                  " requiredu

call plug#begin('~/.vim/bundle')

Plug 'Chiel92/vim-autoformat'
Plug 'PeterRincker/vim-argumentative'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'ambv/black'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'fisadev/vim-isort', {'for': 'python'}
Plug 'jceb/vim-orgmode'
Plug 'jmcantrell/vim-virtualenv'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mgedmin/coverage-highlight.vim'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neomake/neomake'
Plug 'rhysd/committia.vim'
Plug 'thisfred/breakfast', {'for': 'python', 'rtp': 'vim'}
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

call plug#end()

set modelines=0 " disable security holes

" gutentags
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
let g:gutentags_cache_dir='~/.vim/tags'

" encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

set number
set path+=**
set history=10000
set undolevels=1000

""" undo
set undofile
if !has('nvim')
  set undodir=~/.vim/undo
endif
augroup vimrc
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

set inccommand=split
let g:mapleader=','

""" netrw
let g:netrw_banner=0

""" appearance
set title " show title in console title bar

""" completions
set wildmenu
set wildmode=longest,list,full
set complete=.,w,b,u,t,i,kspell
set completeopt=menuone,longest
set wildignore+=*.o,*.obj,.git,*.pyc,.svn,.bzr,__pycache__,.ensime_cache,**/target/**,.git,.m2,.tox,.venv
set tildeop

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
set fileformats=unix,dos,mac " Try recognizing dos, unix, and mac line endings.

""" indentation
set tabstop=4 " <tab> inserts 4 spaces
set shiftwidth=4 " but an indent level is 2 spaces wide.
set softtabstop=4 " <BS> over an autoindent deletes both spaces.
set expandtab " Use spaces, not tabs, for autoindent/tab key.
set shiftround " rounds indent to a multiple of shiftwidth
set autoindent
set backspace=indent,eol,start

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
set statusline+=%#warningmsg# 
set statusline+=%*

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
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
vnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" copying and pasting
set clipboard+=unnamedplus
set pastetoggle=<F2>

" Don't restore empty windows in session
set sessionoptions-=blank

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

set sessionoptions-=blank
" window navigation
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" Move between windows
if has('nvim')
  tnoremap <c-h> <C-\><C-n><C-w>h
  tnoremap <c-j> <C-\><C-n><C-w>j
  tnoremap <c-k> <C-\><C-n><C-w>k
  tnoremap <c-l> <C-\><C-n><C-w>l
  tnoremap <Esc> <C-\><C-n>
  highlight! link TermCursorNC Cursor
  highlight! TermCursorNC guibg=red guifg=white
endif

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
let deoplete#tag#cache_limit_size = 5000000
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" # fugitive

let g:fugitive_github_domains = ['https://github.banksimple.com']

" # neomake
let g:neomake_logfile = expand('~/neomake.log')
let g:neomake_open_list = 2

" ## python

let g:neomake_python_enabled_makers = ['flake8' , 'pylint']
let g:neomake_python_flake8_args = ['--ignore', 'C101,C812,C815,D100,D101,D102,D103,E122,E126,E203,W503,Q0,Z115,Z118,Z305,Z306,Z326', '--max-line-length', '88', '--max-complexity', '10']
let g:neomake_python_pylint_args = ['-d', 'redefined-outer-name,bad-continuation,trailing-newlines,misplaced-comparison-constant,line-too-long,unused-import,undefined-variable,unnecessary-semicolon,multiple-statements,missing-docstring,superfluous-parens', '--output-format=text', '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"', '--reports=no']

let g:neomake_python_mypy_args = ['--strict-optional'] 

hi link NeomakeErrorSign Error
hi link NeomakeWarningSign Search
hi link NeomakeError Error
hi link NeomakeWarning Search
set statusline+=\ %#ErrorMsg#%{neomake#statusline#LoclistStatus('')}

nnoremap <Leader>f :lfirst<CR>
nnoremap <Leader>n :lnext<CR>
nnoremap <Leader>p :lprev<CR>

" ## Color Scheme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
colorscheme base16-ocean
set background=dark

" ## auto/FileType specific changes

" # Python

augroup py
    autocmd!
    au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 tw=88
      \ nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
    autocmd BufWritePre *.py :Black
    "autocmd BufWritePre *.py :Isort
    autocmd BufWritePre *.py :call DeleteTrailingWS()
augroup END

let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

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
    autocmd Filetype markdown setlocal spell textwidth=72
augroup END

" java
augroup java
    autocmd!
    autocmd BufWritePre *.java :call DeleteTrailingWS()
augroup END

" ruby

augroup ruby
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
augroup END

" Grepper
let g:grepper = {'tools': ['git', 'grep']}
nmap ss  <plug>(GrepperOperator)
xmap ss  <plug>(GrepperOperator)

" terminal

tnoremap <ESC> <C-\><C-n>

" .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

augroup vimrc
    autocmd!
    autocmd! BufWritePost init.vim source %
augroup END

" Creates a session
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:sessionfile = b:sessiondir . '/session.vim'
  exe 'mksession! ' . b:sessionfile
endfunction

" Loads a session if it exists
function! LoadSession()
    let b:sessiondir = $HOME . '/.vim/sessions' . getcwd()
    let b:sessionfile = b:sessiondir . '/session.vim'
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
    else
      echo 'No session loaded.'
    endif
endfunction

augroup sessions
  autocmd!
  if argc() == 0
    au VimEnter * nested :call LoadSession()
    au VimLeave * :call MakeSession()
  endif
augroup END

nnoremap <leader>s :call MakeSession()<CR>

augroup syntax
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

autocmd! BufWritePost * Neomake

nnoremap <leader>* :Grepper -tool git -open -switch -cword -noprompt<cr>

" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>r :call RenameFile()<cr>


" vimwiki

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" fzf

map <leader>f :Files<cr>
map <leader>c :Commits<cr>
imap <c-x><c-l> <plug>(fzf-complete-line)


nmap <leader>c :let @+ = expand("%")<cr>
