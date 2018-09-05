" {{{ --- Base config ---

syntax on
set wrap                        " Visually wrap long lines
set textwidth=100               " Wrap lines after 100 chars
set tabstop=2                   " Tabs 2 spaces wide, tabs are spaces
set shiftwidth=2
set expandtab
set scrolloff=4                 " Move page when cursor has 4 lines of space
set autoread
set foldmethod=marker
set wildignore+=.git/,node_modules/,.glide,vendor/
set fillchars+=vert:\           " Remove | from split lines
set nospell                     " Disable spell checking
set timeoutlen=1000 ttimeoutlen=10
set completeopt=menuone,noselect,longest
set relativenumber

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <bs> <C-W><C-H>
set splitbelow
set splitright

" Use ag insead of grep
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
Plug 'danro/rename.vim'                     " To rename files on the fly
Plug 'godlygeek/tabular'                    " For markdown table alignment
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-emoji'
Plug 'Konfekt/vim-guesslang', { 'for': 'markdown' }
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'w0rp/ale'

" Languages
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'mustache' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'posva/vim-vue', { 'for': 'vue'}
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'uarun/vim-protobuf', { 'for': 'protobuf' }
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }

" Visuals
" Plug 'arial7/vim-airline-themes'
" Plug 'arial7/base16-vim'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'

if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif



call plug#end()
" }}}

"{{{ --- Plugin config ---

" Ultisnips
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<c-e>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOBIN.'/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#pointer = 1

" Go
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_auto_type_info = 1

" Tern
let g:tern_show_signature_in_pum = 1
let g:tern_request_timeout = 1
let g:tern_map_keys = 0
let g:tern#filetypes = [
    \ 'jsx',
    \ 'javascript.jsx',
    \ 'vue'
    \ ]

let g:guesslang_langs = [ 'en_US', 'de_DE', 'en', 'de' ]

" ALE
let g:ale_sign_column_always = 1
let g:ale_sign_error = "!"
let g:ale_sign_warning = "~"

" }}}

" {{{ --- Keymaps ---
"  Leaders
let mapleader = ","
nnoremap <leader>] :Ack!<space>
nnoremap <leader>--> a<space>➔<Esc>
nnoremap <leader>-> a➔<Esc>
nnoremap <leader>tt :Tab/\|<cr>
nnoremap <leader>t= :Tab/=<cr>
nnoremap <leader>t: :Tab/:<cr>
nnoremap <leader>e :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr><Esc><Esc>

" Plugin Keymaps
nnoremap <c-p> :FZF<cr>
nnoremap <leader>k :Ag<space><c-r><c-w><cr>


" Neovim keybindings
if has('nvim')

tnoremap <Esc> <C-\><C-n>
aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer> <esc><esc> <c-c>
aug END

endif

" Golang Keymaps
autocmd FileType go nmap <F5> <Plug>(go-build)

" Autohide the completion popup
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Disable this
nnoremap Q <nop>
" To clear the highlighting from searches
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
" }}}

" {{{ --- Misc config ---
let base16colorspace=256
let t_Co=256
let g:nord_italic_comments = 1
colorscheme nord
set guicursor=n:hor100

" Remove light border between splits
" hi VertSplit ctermbg=bg ctermfg=bg

" --- Custom commands ---

" Remember cursor position between vim sessions
autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif

autocmd BufEnter text,markdown,tex setlocal spell

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

" Create parent dirs on save
function! s:MkNonExDir(file, buf)
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


" Statusline configuration

let g:statusline_seperator=' · '

" Clear the statusline
set statusline=%-2{toupper(mode())}
set statusline+=%{g:statusline_seperator}
set statusline+=%-.35f%m
set statusline+=%=
set statusline+=%y
set statusline+=%{g:statusline_seperator}
set statusline+=%4l/%-4L

" }}}
