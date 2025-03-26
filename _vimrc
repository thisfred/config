filetype off

call plug#begin('~/.vim/bundle')

Plug 'Chiel92/vim-autoformat'
Plug 'PeterRincker/vim-argumentative'
Plug 'airblade/vim-gitgutter'
Plug 'bogado/file-line'
Plug 'RRethy/base16-nvim'
Plug 'christoomey/vim-sort-motion'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ncm2/float-preview.nvim'
Plug 'neomake/neomake'
Plug 'neovim/nvim-lspconfig'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'rhysd/committia.vim'
Plug 'rust-lang/rust.vim'
Plug 'thisfred/breakfast', {'for': 'python', 'rtp': 'vim'}
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-test/vim-test'
Plug 'AndrewRadev/id3.vim'

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


set modelines=0 " disable security holes
set cursorline

" gutentags
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
let g:gutentags_cache_dir='~/.cache/vim/tags'

" encoding
set encoding=utf-8
set fileencoding=utf-8

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
set wildmode=longest,list,full
set wildmenu
" set complete=.,w,b,u,t,i,kspell
" set completeopt=menuone,longest
set wildignore+=*.o,*.obj,.git,*.pyc,.svn,.bzr,__pycache__,.ensime_cache,**/target/**,.git,.m2,.tox,.venv
set tildeop

" supertab
let g:SuperTabLongestHighlight=1
let g:SuperTabCrMapping=1
""" don't bell or blink
set noerrorbells

""" Moving Around/Editing
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

let test#python#runner = 'pytest'
nnoremap <leader>T :execute '!make test'<cr>
nnoremap <leader>t :TestFile<CR>
nnoremap <leader>n :tn<CR>


" ## Plugins

" # neomake
let g:neomake_logfile = expand('~/neomake.log')
let g:neomake_open_list = 2

" ## python

let g:neomake_python_enabled_makers = ['mypy']
nnoremap <Leader>f :lfirst<CR>
nnoremap <Leader>n :lnext<CR>
nnoremap <Leader>p :lprev<CR>

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
    " autocmd BufWritePre *.py silent! :lua vim.lsp.buf.format()

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
" map <leader>r :call RenameFile()<cr>

" copy filename of current buffer
nmap <leader>c :let @+ = expand("%")<cr>

map <C-w>f <C-w>vgf
map <C-w>F <C-w>vgF


lua require('lspbreakfast')

" Rust
lua require'lspconfig'.rust_analyzer.setup({})

let g:rustfmt_autosave = 1

" for geotags: move line to top of file then select it minus newline
noremap <leader>g :norm ddggP<cr>0y$
xnoremap <leader>G c<C-R>=trim(system("python3 -c " . shellescape("import pygeohash; print(pygeohash.encode(" . @" . "))")))<CR><Esc>
