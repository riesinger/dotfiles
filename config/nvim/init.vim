"--- Base config ---
syntax on
set relativenumber number
set wrap

set tabstop=4
set shiftwidth=4
set expandtab
set so=4
set autoread
" Ingore node_modules folders
set wildignore+=node_modules/**

" Remember cursor position between vim sessions
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif
              " center buffer around cursor when opening files

" Remove | from split lines
set fillchars+=vert:\ 

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

"--- Plugins ---
call plug#begin()

" Functionality
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'suan/vim-instant-markdown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'jiangmiao/auto-pairs'
Plug 'danro/rename.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
" Languages
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-markdown'

" Visuals
Plug 'vim-airline/vim-airline'

call plug#end()


"--- Airline config ---
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''

"--- Keymaps ---
let mapleader = ","
"Tab navigation
nmap <leader>h :tabp<cr>
nmap <leader>l :tabn<cr>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
map <C-n> :NERDTreeToggle<CR>
nnoremap Q <nop>
" FZF
nnoremap <c-p> :FZF<cr>
" Notes
command! -nargs=1 Ngrep lvimgrep "<args>" $SCHOOL_DIR/**/*.md
nnoremap <leader>[ :Ngrep 
" Project GREP (Coffeescript)
command! -nargs=1 Pgrep lvimgrep "<args>" ./**/*.coffee
nnoremap <leader>] :Pgrep
"Clear search
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
"Exit out of terminal mode
tnoremap <Esc> <C-\><C-n>
"Special chars
nnoremap <leader>--> a➔<Esc>


"--- Neomake ---
autocmd! BufEnter,BufWritePost * Neomake
let g:neomake_coffee_enabled_makers = ['coffeelint']

"--- Instant Markdown Preview---
let g:instant_markdown_autostart = 0

"--- Vim-Session ---
let g:session_autosave = 'no'
