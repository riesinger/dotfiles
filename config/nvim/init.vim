" {{{ --- Base config -- -

set nocompatible                " Still being compatible with Vi doesn't make sense
set wrap                        " Visually wrap long lines
set textwidth=100               " Wrap lines after 100 chars
set tabstop=2                   " Tabs 2 spaces wide, tabs are spaces
set shiftwidth=2
set shiftround                  " Fixes indentation errors by rounding to the nearest indentation
set scrolloff=4                 " Move page when cursor has 4 lines of space
set foldmethod=marker
set wildignore+=.git/,node_modules/,vendor/ " We won't ever need to read those directories
set fillchars+=vert:\           " Remove | from split lines
set timeoutlen=1000 ttimeoutlen=10 " Make the editor more responsive
set completeopt=menuone,noselect,longest
set number                      " Line numbering
set mouse=a                     " Mouse support
set shortmess+=c                " suppress completion messages
set updatetime=1000             " For CursorHold and CursorHoldI
set signcolumn=yes              " Always show signs (erors etc.)
set ignorecase                  " Make search smater
set smartcase                   " by automatically doing case sensitive searches
set incsearch                   " Hightlight search results as you type
set inccommand=nosplit          " Show the results of commands as you type
set noshowmode                  " Hide the -- INSERT -- etc. line (it's in the status line)
set noruler                     " Don't display current line in message line (it's in the status line)
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:» " Show tabs, trailing and leading spaces

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <bs> <C-W><C-H>
set splitbelow
set splitright
" }}}

" {{{ --- Keymaps ---

"  Leaders
let mapleader = " "
nnoremap <silent> <leader>e :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr><Esc><Esc>
" Disable this
nnoremap Q <nop>
" To clear the highlighting from searches
nnoremap <silent> <Esc><Esc> :let @/=""<CR>

" Neovim keybindings
if has('nvim')

tnoremap <Esc> <C-\><C-n>
aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer> <esc><esc> <c-c>
aug END

endif

" }}}
