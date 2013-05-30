" ==========================================================
" General setup
" ==========================================================

set modelines=0 " disable security holes
set nocompatible " not compatiable with vi
set encoding=utf-8
let mapleader = ','
" ==========================================================
" Pathogen - Allows us to organize our vim plugins
" ==========================================================
" Load pathogen with docs for all plugins
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ==========================================================
" Basic Settings
" ==========================================================
syntax on " syntax highlighing
filetype on " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype

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

"""line numbers
set number " Display line numbers
set numberwidth=1 " using only 1 column (and 1 space) while possible
set ruler " show the cursor position all the time

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
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})

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
set clipboard=unnamed,autoselect


" ===============
" Macros/commands
" ===============

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" sudo write this
cnoremap W! w !sudo tee % >/dev/null
cnoremap w!! w !sudo tee % >/dev/null

" window navigation
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
inoremap <C-W> <C-O><C-W>

" open/close the quickfix window
nnoremap <leader>c :copen<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
nnoremap <leader>cc :cclose<CR>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Select the item in the list with enter
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" add python debug statement
nnoremap <c-p> oimport pdb; pdb.set_trace()<Esc>

" keep cursor in place when joining
nnoremap J mzJ`z

" center after jumping
nnoremap n nzz
nnoremap } }zz

" fix Y
nnoremap Y y$

set splitbelow
set splitright

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
    au FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 nosmartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
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

" ===========================================================
" Plugin config
" ============================================================

set t_Co=256
" let g:solarized_termtrans=1    "default value is 0
syntax enable
set background=dark
" colorscheme solarized

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
set pastetoggle=<F2>

nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap jk <esc>

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<C-U>call <SID>GrepOperator(visualmode())<cr>
nnoremap <leader>t :execute '!wr test'<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! -R --exclude-dir build " . shellescape(@@) . " ."
    redraw!

    let @@ = saved_unnamed_register
endfunction

" hybrid colorscheme
let g:hybrid_use_Xresources = 1
colorscheme hybrid

" powerline

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
" let g:Powerline_symbols = 'fancy'
