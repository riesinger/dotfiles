" {{{ --- Base config ---

syntax on
" set relativenumber number
set wrap                        " Visually wrap long lines
set tabstop=4
set shiftwidth=4
set expandtab
set so=4
set autoread
set foldmethod=marker
set wildignore+=node_modules/** " Ingore node_modules folders
set fillchars+=vert:\           " Remove | from split lines
set nospell
set timeoutlen=1000 ttimeoutlen=10

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <bs> <C-W><C-H>
set splitbelow
set splitright

set grepprg=ag

" }}}

"{{{ --- Plugins ---
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

"--- Plugins ---
call plug#begin()

" Functionality
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-emoji'
Plug 'mileszs/ack.vim'
Plug 'suan/vim-instant-markdown'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Languages
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'Quramy/tsuquyomi'

" Visuals
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'kien/rainbow_parentheses.vim'

call plug#end()
" }}}

"{{{ --- Plugin config ---
" Airline
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
let g:airline_section_a = '%{airline#util#wrap(airline#parts#mode(), 0)}'
let g:airline_section_z = '%{g:airline_symbols.maxlinenr}%4l/%L:%3v'
" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_coffee_enabled_makers = ['coffeelint']
let g:neomake_typescript_enabled_makers = []
" Instant Markdown Preview
let g:instant_markdown_autostart = 0
" Vim-Session
let g:session_autosave = 'no'

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" }}}

" {{{ --- Keymaps ---
"  Leaders
let mapleader = ","
nmap <leader>h :tabp<cr>
nmap <leader>l :tabn<cr>
nnoremap <leader>[ :Ngrep<space>
nnoremap <leader>] :Ack!<space>
nnoremap <leader>--> a➔<Esc>
nnoremap <leader>n Neomake
nnoremap <leader>tt :Tab/\|<cr>
nnoremap <leader>t= :Tab/=<cr>
nnoremap <leader>t: :Tab/:<cr>
nnoremap <leader>e :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr><Esc><Esc>
" Plugin Keymaps
map <C-n> :NERDTreeToggle<CR>
nnoremap <c-p> :FZF<cr>
aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer> <esc><esc> <c-c>
aug END
" Misc Keymaps
nnoremap Q <nop>
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
tnoremap <Esc> <C-\><C-n>
" }}}

" {{{ --- Misc config ---
colorscheme solarized
set background=dark

" Remove light border between splits
hi VertSplit ctermbg=bg ctermfg=bg

" --- Custom commands ---
" Notes grep
command! -nargs=1 Ngrep lvimgrep "<args>" $SCHOOL_DIR/**/*.md

" Remember cursor position between vim sessions
autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif

autocmd BufNewFile $SCHOOL_DIR/**/*.md set spell spelllang=de_de

" Remove trailing whitespace
function! StripTrailingWhitespaces()
    if &ft == "markdown"
        return
    endif
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

function! SchoolTemplate()
    r ~/.dotfiles/school-markdown-template.md
endfunction

command! SchoolTemplate :call SchoolTemplate()

autocmd BufWritePre * :call StripTrailingWhitespaces()

" }}}
