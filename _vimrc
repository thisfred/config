filetype off

call plug#begin('~/.vim/bundle')

Plug 'Chiel92/vim-autoformat'
Plug 'PeterRincker/vim-argumentative'
Plug 'airblade/vim-gitgutter'
Plug 'psf/black', {'for': 'python'}
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'fisadev/vim-isort', {'for': 'python'}
Plug 'jmcantrell/vim-virtualenv'
Plug 'ludovicchabant/vim-gutentags', {'for': 'python'}
Plug 'mgedmin/coverage-highlight.vim'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ncm2/float-preview.nvim'
Plug 'neomake/neomake'
Plug 'rhysd/committia.vim'
Plug 'thisfred/breakfast', {'for': 'python', 'rtp': 'vim'}
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'ervandew/supertab'

" Clojure
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': 'clojure'}

" JS
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax

Plug 'dense-analysis/ale', {'for': ['css', 'javascript', 'typescript', 'typescriptreact', 'clojure']}
Plug 'sbdchd/neoformat', {'for': ['javascript', 'typescript']}

call plug#end()

" ## Color Scheme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
colorscheme base16-ocean
set background=dark

highlight SpellBad ctermbg=NONE ctermfg=1 cterm=undercurl 
highlight SpellCap ctermbg=NONE ctermfg=3 cterm=undercurl

let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'typescript': ['eslint'],
\  'typescriptreact': ['eslint'],
\}

" Place configuration AFTER `call plug#end()`!
let g:ale_linters = {
      \ 'clojure': ['clj-kondo', 'joker']
      \}
let g:ale_fix_on_save = 1

nnoremap <leader>G :ALEGoToDefinition<cr>

set modelines=0 " disable security holes
set cursorline

" gutentags
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
let g:gutentags_cache_dir='~/.cache/vim/tags'

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

" supertab

"let g:SuperTabLongestHighlight=1
let g:SuperTabCrMapping=1
let g:SuperTabDefaultCompletionType = "<c-n>"
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
set formatoptions=croqn1
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

inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" # fugitive

let g:fugitive_github_domains = ['https://github.banksimple.com']

" # neomake
let g:neomake_logfile = expand('~/neomake.log')

" ## python

let g:neomake_python_enabled_makers = ['flake8', 'pylint', 'mypy']
let g:neomake_python_flake8_args = ['--ignore', 'E203,E501,W503', '--max-complexity', '10']
let g:neomake_python_pylint_args = ['-d', 'unsubscriptable-object,invalid-name,redefined-outer-name,bad-continuation,trailing-newlines,misplaced-comparison-constant,line-too-long,unused-import,undefined-variable,unnecessary-semicolon,multiple-statements,missing-function,docstring,missing-docstring,superfluous-parens,ungrouped-imports', '--output-format=text', '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"', '--reports=no']
let g:black_virtualenv = '~/eden/grdn/.pyenv'


set statusline+=\ %#ErrorMsg#%{neomake#statusline#LoclistStatus('')}

nnoremap <Leader>f :lfirst<CR>
nnoremap <Leader>n :lnext<CR>
nnoremap <Leader>p :lprev<CR>

" ## auto/FileType specific changes

" # Python

augroup py
    autocmd!
    au FileType python setlocal expandtab indentkeys-=<:> shiftwidth=4 tabstop=4 softtabstop=4 tw=88
      \ nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
    autocmd BufWritePre *.py :Isort
    autocmd BufWritePre *.py :Black
    autocmd BufWritePre *.py :call DeleteTrailingWS()
augroup END

augroup js
    autocmd BufWritePre *.js Neoformat prettier
augroup END

augroup ts
    autocmd BufWritePre *.ts Neoformat prettier
augroup END    
    
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

" copy filename of current buffer
nmap <leader>c :let @+ = expand("%")<cr>

" vim-iced
" Enable vim-iced's default key mapping
" This is recommended for newbies
let g:iced_enable_clj_kondo_analysis = v:true
let g:iced_enable_clj_kondo_local_analysis = v:true


aug VimAutoFormatOnWriting
  au!
  au BufWritePre *.clj,*.edn :%!zprint '{:search-config? true}'
aug END

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

" COC
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <leader>u <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

let g:coc_enable_locationlist = 0
autocmd User CocLocationsChange CocList --normal location

inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> [l <Plug>(coc-diagnostic-prev)
nmap <silent> ]l <Plug>(coc-diagnostic-next)
nmap <silent> [k :CocPrev<cr>
nmap <silent> ]k :CocNext<cr>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

nnoremap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cruw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crua :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> crel :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cris :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cref :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>aq  <Plug>(coc-fix-current)
" workspace symbols 
nnoremap <silent><leader>s  :<C-u>CocList -I symbols<cr>

autocmd BufReadCmd,FileReadCmd,SourceCmd jar:file://* call s:LoadClojureContent(expand("<amatch>"))
 function! s:LoadClojureContent(uri)
  setfiletype clojure
  let content = CocRequest('clojure-lsp', 'clojure/dependencyContents', {'uri': a:uri})
  call setline(1, split(content, "\n"))
  setl nomodified
  setl readonly
endfunction
