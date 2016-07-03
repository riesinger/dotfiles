" {{{ --- Base config ---

syntax on
set relativenumber number
set wrap                        " Visually wrap long lines
set tabstop=4
set shiftwidth=4
set expandtab
set so=4
set autoread
set foldmethod=marker
set wildignore+=node_modules/** " Ingore node_modules folders
set fillchars+=vert:\           " Remove | from split lines

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" }}}

"{{{ --- Plugins ---
call plug#begin()

" Functionality
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'suan/vim-instant-markdown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'jiangmiao/auto-pairs'
Plug 'danro/rename.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'godlygeek/tabular'

" Languages
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" Visuals
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/seoul256.vim' 
Plug 'altercation/vim-colors-solarized'

call plug#end()
" }}}

colorscheme solarized
set background=dark

" --- Custom commands ---
" Notes grep
command! -nargs=1 Ngrep lvimgrep "<args>" $SCHOOL_DIR/**/*.md
" Project grep (Coffeescript)
command! -nargs=1 Pgrep lvimgrep "<args>" ./**/*.coffee
" Remember cursor position between vim sessions
autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif
              " center buffer around cursor when opening files


" --- Plugin config ---
" Airline
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
let g:airline_section_z = '%{g:airline_symbols.maxlinenr}%4l/%L:%3v'
" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_coffee_enabled_makers = ['coffeelint']
" Instant Markdown Preview
let g:instant_markdown_autostart = 0
" Vim-Session
let g:session_autosave = 'no'

" --- Keymaps ---
"  Leaders
let mapleader = ","
nmap <leader>h :tabp<cr>
nmap <leader>l :tabn<cr>
nnoremap <leader>[ :Ngrep 
nnoremap <leader>] :Pgrep 
nnoremap <leader>--> a➔<Esc>
nnoremap <leader>n Neomake
nnoremap <leader>tt :Tab/\|<cr>
nnoremap <leader>t= :Tab/=<cr>
nnoremap <leader>t: :Tab/:<cr>
" Plugin Keymaps
map <C-n> :NERDTreeToggle<CR>
nnoremap <c-p> :FZF<cr>
" Misc Keymaps
nnoremap Q <nop>
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
tnoremap <Esc> <C-\><C-n>

