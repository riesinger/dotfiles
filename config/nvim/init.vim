" {{{ --- Base config -- -

set nocompatible                " Still being compatible with Vi doesn't make sense
set wrap                        " Visually wrap long lines
set textwidth=100               " Wrap lines after 100 chars
set tabstop=2                   " Tabs 2 spaces wide, tabs are spaces
set shiftwidth=2
set scrolloff=4                 " Move page when cursor has 4 lines of space
set autoread
set foldmethod=marker
set wildignore+=.git/,node_modules/,vendor/ " We won't ever need to read those directories
set fillchars+=vert:\           " Remove | from split lines
set nospell                     " Disable spell checking
set timeoutlen=1000 ttimeoutlen=10 " Make the editor more responsive
set completeopt=menuone,noselect,longest
set number                      " Line numbering
set relativenumber
set mouse=a                     " Mouse support
set shortmess+=c                " suppress completion messages
set updatetime=1000             " For CursorHold and CursorHoldI
set signcolumn=yes              " Always show signs (erors etc.)
set cmdheight=1
set ignorecase                  " Make search smater
set smartcase
set incsearch
set noshowmode                  " Hide the -- INSERT -- etc. line
set noruler                     " Don't display current line in message line (it's in the status line)
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:» " Show tabs, trailing and leading spaces
set nolist

" Make splits more natural
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <bs> <C-W><C-H>
set splitbelow
set splitright

" }}}

"{{{ --- Plugins ---

" Since vimtex is incompatible with LaTeX-Box, disable latex from polyglot
" We want to use vimtex, since it integrates with coc.nvim
" Also, I already use vim-sleuth, so autoindent doesn't make sense
let g:polyglot_disabled = ['latex', 'autoindent']

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

"--- Plugins ---
call plug#begin(stdpath('data') . './plugged')

" Functionality

Plug 'Konfekt/vim-detectspelllang', { 'for': ['markdown', 'vimwiki', 'text', 'mail', 'pandoc'] }
Plug 'SirVer/ultisnips'
Plug 'alvan/vim-closetag'
Plug 'christoomey/vim-tmux-navigator'       " Integration with TMUX
Plug 'christoomey/vim-tmux-runner'          " Run make in a TMUX pane
Plug 'danro/rename.vim'                     " To rename files on the fly
Plug 'editorconfig/editorconfig-vim'        " To auto-adjust the indentation settings
Plug 'godlygeek/tabular'                    " For markdown table alignment
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'janko/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'                    " A clean slate for writing
Plug 'liuchengxu/vista.vim'                 " Symbol tree based on coc.nvim
Plug 'mattn/calendar-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'tpope/vim-abolish'                    " A life-saver for handling word casing
Plug 'tpope/vim-commentary'                 " For easy commenting
Plug 'tpope/vim-dispatch'                   " Do things asynchronously
Plug 'tpope/vim-fugitive'                   " Git
Plug 'tpope/vim-obsession'                  " Session tracking. Good for TMUX
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'                     " Guess the indentation settings
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'                 " More useful mappings
Plug 'vimwiki/vimwiki'

" Languages
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'lervag/vimtex'
Plug 'saltstack/salt-vim'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'NLKNguyen/cloudformation-syntax.vim'
Plug 'pedrohdz/vim-yaml-folds'

" Visuals
Plug 'morhetz/gruvbox'
Plug 'cormacrelf/vim-colors-github'

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

" Go
let g:go_code_completion_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_auto_type_info = 0

let g:detectspelllang_langs = {}
let g:detectspelllang_langs.aspell = [ 'en_US', 'de_DE', 'en', 'de' ]

" Ack
let g:ackprg = 'rg --vimgrep'

" FZF
let $FZF_DEFAULT_OPTS="--reverse"
let g:fzf_tags_command = 'ctags --exclude=vendor -R'
let g:fzf_preview_floating_window_winblend = 0
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'highlight': 'Todo', 'border': 'rounded' } }

" Vim Test
let test#strategy = "dispatch"

" Vimtex
let g:tex_flavor = "latex"
let g:vimtex_quickfix_mode = 0 " Don't open the quickfix window automatically

" Coc.nvim
let g:coc_global_extensions = [
\ 'coc-angular',
\ 'coc-css',
\ 'coc-emmet',
\ 'coc-emoji',
\ 'coc-eslint',
\ 'coc-go',
\ 'coc-highlight',
\ 'coc-html',
\ 'coc-json',
\ 'coc-lists',
\ 'coc-marketplace',
\ 'coc-python',
\ 'coc-rls',
\ 'coc-snippets',
\ 'coc-tsserver',
\ 'coc-vimtex',
\ 'coc-yaml',
\]

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Goyo
let g:goyo_width = 120
let g:goyo_height = 90

" Better Ripgrep (RG) implementation, which updates rg instead of filtering lines with FZF
function! RipgrepFzf(query, fullscreen)
let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
let initial_command = printf(command_fmt, shellescape(a:query))
let reload_command = printf(command_fmt, '{q}')
let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Pandoc
let g:pandoc#modules#disabled = ["folding", "spell"]
let g:pandoc#formatting#mode = 'hA'

" Tree-Sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

" Vista
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "f",
\   "variable": "v",
\   "constant": "c",
\  }
let g:vista_fzf_preview = ['right:50%']
let g:vista_sidebar_width = 50
let g:vista_echo_cursor_strategy = 'floating_win'

" Vimwiki
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_list = [
	\{'path': '~/Documents/wiki/work/', 'syntax': 'markdown', 'ext': '.md'},
	\{'path': '~/Documents/wiki/personal/', 'syntax': 'markdown', 'ext': '.md'}
\]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown'}
let g:mkdp_filetypes = ['markdown', 'vimwiki']
:autocmd FileType vimwiki map <leader>d :VimwikiMakeDiaryNote<cr>
:autocmd FileType vimwiki nnoremap <leader>md :MarkdownPreview<cr>
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map <leader>c :call ToggleCalendar()
" I am German and my diary should be too :)
let g:vimwiki_diary_months = {
  \ 1: 'Januar', 2: 'Februar', 3: 'März', 4: 'April', 5: 'Mai', 6: 'Juni',
  \ 7: 'Juli', 8: 'August', 9: 'September', 10: 'Oktober', 11: 'November', 12: 'Dezember'
  \ }
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_listsyms = '○◐●✓'
let g:vimwiki_listsym_rejected = '✗'


" CloseTags
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,javascriptreact,typescriptreact'
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx,javascriptreact,tsx,typescriptreact'
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

"}}}

" {{{ --- Keymaps ---

"  Leaders
let mapleader = " "
" Focus
nnoremap <silent> <leader>f :Goyo<cr>
" Alignment
nnoremap <leader>aa :Tab/\|<cr>
nnoremap <leader>a= :Tab/=<cr>
nnoremap <leader>a: :Tab/:<cr>
nnoremap <silent> <leader>e :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr><Esc><Esc>
nnoremap <leader>r <Plug>(coc-rename)
" Code action for current line
nnoremap <leader>aa <Plug>(coc-codeaction)
" Autofix for current line
nnoremap <leader>af <Plug>(coc-fix-current)
nnoremap <silent> <leader>rg :Rg<cr>
nnoremap <silent> <leader>p :RG<cr>
nnoremap <silent> <leader>o :Vista!!<cr>
" Plugin Keymaps
nnoremap <silent> <C-p> :Files<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>t :TestFile<cr>
nnoremap <leader>ts :TestSuite<cr>
nnoremap <silent> <F5> :VtrSendCommandToRunner! make<cr>
nnoremap <silent> <F6> :VtrSendCommandToRunner! make run<cr>
nnoremap <silent> <F7> :VtrFocusRunner!<cr>
autocmd FileType go nnoremap <silent> <F5> :Dispatch :GoBuild!<cr>

autocmd FileType pandoc map <buffer><silent> <leader>t :TOC<cr>

" Neovim keybindings
if has('nvim')

tnoremap <Esc> <C-\><C-n>
aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer> <esc><esc> <c-c>
aug END

endif

" COC.nvim
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

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

" Indents
let g:indent_guides_guide_size = 1
autocmd BufReadPost *.yaml IndentGuidesEnable

" Disable this
nnoremap Q <nop>
" To clear the highlighting from searches
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
" }}}

" {{{ --- Misc config ---
set termguicolors
set bg=dark
let g:gruvbox_italic=1
colorscheme gruvbox
set guicursor=n:hor100
highlight link GitGutterChange GruvboxAqua
highlight SignColumn ctermbg=0 ctermfg=7 guifg=#ebdbb2 guibg=#282828
highlight CursorLineNr ctermbg=0 ctermfg=5
highlight CocUnderline cterm=undercurl term=undercurl gui=undercurl
highlight VertSplit ctermbg=fg ctermfg=bg guibg=#32302f

" --- Custom commands ---

" Remember cursor position between vim sessions
autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif

autocmd BufEnter text,markdown,mail,pandoc setlocal spell

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
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePost *.go :GoBuild
autocmd BufWritePost sh !chmod +x %
autocmd BufWritePost zsh !chmod +x %
autocmd BufWritePost bash !chmod +x %

" Format the current buffer with coc.nvim
command! -nargs=0 Fmt :call CocAction('format')
command! -nargs=0 C edit ~/.config/nvim/init.vim

" }}}

"{{{ --- Statusline

" Colors
highlight StatusLineNC ctermbg=0 ctermfg=15 cterm=NONE guibg=#32302f guifg=#a89984 gui=NONE
highlight StatusLine ctermbg=7 ctermfg=0 cterm=NONE guibg=#3c3836 guifg=#ebdbb2 gui=bold
highlight User1 ctermbg=2 ctermfg=0

" Make the left and right block blue in insert mode
au InsertEnter * hi User1 ctermbg=4 ctermfg=0
au InsertLeave * hi User1 ctermbg=2 ctermfg=0

let g:statusline_seperator='  '

let g:currentmode={
      \ 'n'  : ' N ',
      \ 'no' : ' NOR_ ',
      \ 'v'  : ' V ',
      \ 'V'  : ' L ',
      \ '' : ' B ',
      \ 's'  : ' SLCT ',
      \ 'S'  : ' SLIN ',
      \ '' : ' SBLK ',
      \ 'i'  : ' I ',
      \ 'R'  : ' R ',
      \ 'Rv' : ' r ',
      \ 'c'  : ' C ',
      \ 'cv' : ' X ',
      \ 'ce' : ' x ',
      \ 'r'  : ' ! ',
      \ 'rm' : ' … ',
      \ 'r?' : ' ? ',
      \ '!'  : ' $ ',
      \ 't'  : ' T '
      \}

function! GitBranch()
	let branch = ""
	if exists("*fugitive#head")
		let branch = fugitive#head()
	endif
	if branch != ''
		return '  ⎇  '.branch.' '
	endif
	return ''
endfunction


function! GetObsessionStatus()
	let status = ""
	if exists("*ObsessionStatus")
		let status = ObsessionStatus('🐵', '🙈')
	endif
	if status != ''
		return ' '.status.'  '
	endif
	return '🙈'
endfunction

set statusline=
set statusline+=%1*%3{g:currentmode[mode()]}%*
set statusline+=%{GitBranch()}
set statusline+=\ %-.55f%m
set statusline+=%=
" set statusline+=%{g:go#statusline#Show()}
set statusline+=%y
set statusline+=%{g:statusline_seperator}
set statusline+=%{GetObsessionStatus()}
set statusline+=%1*\ %P\ ·\ %4l:%-3c\%*

" }}}
