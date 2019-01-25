" {{{ --- Base config ---

syntax on
set wrap                        " Visually wrap long lines
set textwidth=100               " Wrap lines after 100 chars
set tabstop=2                   " Tabs 2 spaces wide, tabs are spaces
set shiftwidth=2
set scrolloff=4                 " Move page when cursor has 4 lines of space
set autoread
set foldmethod=marker
set wildignore+=.git/,node_modules/,.glide,vendor/
set fillchars+=vert:\           " Remove | from split lines
set nospell                     " Disable spell checking
set timeoutlen=1000 ttimeoutlen=10
set completeopt=menuone,noselect,longest
set number
set relativenumber
set mouse=a
set shortmess+=c " suppress completion messages
set updatetime=1000 " For CursorHold and CursorHoldI
set signcolumn=yes
set cmdheight=2

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

Plug 'Chiel92/vim-autoformat'
Plug 'Konfekt/vim-guesslang', { 'for': 'markdown' }
Plug 'SirVer/ultisnips'
Plug 'christoomey/vim-tmux-navigator'
Plug 'danro/rename.vim'                     " To rename files on the fly
Plug 'godlygeek/tabular'                    " For markdown table alignment
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-emoji'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Languages

Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'herringtondarkholme/yats.vim'
Plug 'jodosha/vim-godebug', { 'for': 'go' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'mustache' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'posva/vim-vue', { 'for': 'vue'}
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'uarun/vim-protobuf', { 'for': 'protobuf' }
" Visuals
" Plug 'vim-airline/vim-airline-themes'
" Plug 'ayu-theme/ayu-vim-airline'
" Plug 'vim-airline/vim-airline'
" Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'jeffkreeftmeijer/vim-dim'
" Plug 'Yggdroot/indentLine'

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
let g:ale_sign_error = "!!"
let g:ale_sign_warning = ">>"
let g:ale_completion_enabled = 1

" Indent Line
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

" Ack
let g:ackprg = 'ag --nogroup --nocolor --column --ignore vendor --ignore .git'

" JSON
let g:vim_json_syntax_conceal = 0

" FZF
let g:fzf_tags_command = 'ctags --exclude=vendor -R'

" Indent Line
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

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
nnoremap <F2> :Tags<cr>
nnoremap <F3> :BTags<cr>
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

" COC.nvim
inoremap <silent><expr> <Tab>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr> <S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" Disable this
nnoremap Q <nop>
" To clear the highlighting from searches
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
" }}}

" {{{ --- Misc config ---
"let base16colorspace=256
"let t_Co=256
let ayucolor="dark"
colorscheme dim
set guicursor=n:hor100
set cursorline

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


" }}}

"{{{ --- Statusline

" Colors
highlight! StatusLine guibg=#20272C guifg=#FFFFFF
highlight! StatusLineNC guibg=#20272C guifg=#BBBBBB
" Mode indicator, end piece
highlight! User1 guibg=#C2D94C guifg=#0F1419
" Branch background, lighter grey
highlight! User2 guibg=#363F46 guifg=#FFFFFF

let g:statusline_seperator='  '

let g:currentmode={
      \ 'n'  : ' NORMAL ',
      \ 'no' : ' NORMAL_',
      \ 'v'  : ' VISUAL ',
      \ 'V'  : ' V·LINE ',
      \ '' : ' V·BLOK ',
      \ 's'  : ' SELECT ',
      \ 'S'  : ' S·LINE ',
      \ '' : ' S·BLOK ',
      \ 'i'  : ' INSERT ',
      \ 'R'  : ' REPLAC ',
      \ 'Rv' : ' V·RPLC ',
      \ 'c'  : ' CMD   ',
      \ 'cv' : ' VIM EX ',
      \ 'ce' : ' EX    ',
      \ 'r'  : ' PROMPT ',
      \ 'rm' : ' MORE  ',
      \ 'r?' : ' CNFRM ',
      \ '!'  : ' SHELL ',
      \ 't'  : ' TERM '
      \}

function! GitBranch()
	let branch = ""
	if exists("*fugitive#head")
		let branch = fugitive#head()
	endif
	if branch != ''
		return '  ⎇ '.branch.' '
	endif
	return ''
endfunction


function! SetStatusline()
	let mode = mode()
	if (mode ==# 'i')
		highlight! User1 guibg=#59C2FF guifg=#0F1419
	else
		highlight! User1 guibg=#C2D94C guifg=#0F1419
	endif
	return ''
endfunction

function! GetObsessionStatus()
	let status = ""
	if exists("*ObsessionStatus")
		let status = ObsessionStatus('0.0', '-.-')
	endif
	if status != ''
		return '  '.status.' '
	endif
	return '  -.- '
endfunction

set statusline=
set statusline+=%{SetStatusline()}
set statusline+=%1*%8{g:currentmode[mode()]}%*
set statusline+=%2*%{GitBranch()}%*
set statusline+=%{g:statusline_seperator}
set statusline+=%-.55f%m
set statusline+=%=
set statusline+=%y
set statusline+=%{g:statusline_seperator}
set statusline+=%2*%{GetObsessionStatus()}%*
set statusline+=%1*\ %4l:%-3c\ \│\ %-4L%*

" }}}
