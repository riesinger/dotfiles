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

if executable('ag')
    set grepprg="ag --vimgrep"
endif

" }}}

"{{{ --- Plugins ---
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

"--- Plugins ---
call plug#begin()

" Functionality
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-emoji'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Languages
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'uarun/vim-protobuf', { 'for': 'protobuf' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'


" Visuals
Plug 'vim-airline/vim-airline'
Plug 'Arial7/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/seoul256.vim'

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
let g:airline_section_y = ''
let g:airline_section_z = '%{g:airline_symbols.maxlinenr}%4l/%L:%3v'
" Neomake
"autocmd! BufWritePost * Neomake
let g:neomake_coffee_enabled_makers = ['coffeelint']
let g:neomake_typescript_enabled_makers = []
" Instant Markdown Preview
let g:instant_markdown_autostart = 0
" Vim-Session
let g:session_autosave = 'no'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $HOME."/development/jooy/bin/gocode"
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#pointer = 1

set completeopt+=noselect

" }}}

" {{{ --- Keymaps ---
"  Leaders
let mapleader = ","
nmap <leader>h :tabp<cr>
nmap <leader>l :tabn<cr>
nnoremap <leader>[ :Ngrep<space>
nnoremap <leader>] :Ack!<space>
nnoremap <leader>--> a<space>➔<Esc>
nnoremap <leader>-> a➔<Esc>
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
nnoremap <F5> :Dispatch go install gitlab.com/jooy/server/oceanic<cr>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Misc Keymaps
nnoremap Q <nop>
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
tnoremap <Esc> <C-\><C-n>
" }}}

" {{{ --- Misc config ---
let g:seoul256_background = 235
colorscheme seoul256
set background=dark
set t_Co=256

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

" Hide the -- INSERT -- etc. line
set noshowmode
set noruler

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

" Create parent dirs on save
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

autocmd BufWritePre * :call StripTrailingWhitespaces()

" }}}
