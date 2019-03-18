" My Personal Neovim Config

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rhysd/clever-f.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
Plug 'tommcdo/vim-lion'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-grepper'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'rstacruz/vim-closer'
Plug '907th/vim-auto-save'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'terryma/vim-smooth-scroll'
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

call plug#end()
" }}}

" General configs {{{
" Set numbers on left
set nu

" Fold Option marker
set foldmethod=marker
" Set locale
language en_US

" Remap leader key
let mapleader = " "

" Remap tab to 2 spaces
set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.

set shiftwidth=2    " Indents will have a width of 2

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
" }}}

" Fuzzy Finder {{{
" Some remaps for fuzzy file searching
nnoremap <silent> <leader><Space> :Files<CR>
" }}}

" Clever-F {{{
let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms = 3000
" }}}

" Vim-Lion {{{
let g:lion_squeeze_spaces = 1
" }}}

" NERDTree {{{
" General config and remap
let NERDTreeHijackNetrw = 0
noremap <silent> <leader>n :NERDTreeToggle<CR> <C-w>=
noremap <silent> <leader>f :NERDTreeFind<CR> <C-w>=

" Auto-refresh 
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" Nerdtree Git Plugin
let g:NERDTreeUpdateOnCursorHold = 0
let g:NERDTreeUpdateOnWrite      = 0
" }}}

" Airline {{{
" Airline config
let g:airline_theme='gruvbox'
" }}}

" Colorscheme {{{
" Colorscheme Configs
set termguicolors
colorscheme gruvbox

" Color switching depending on System colors
if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
  set background=dark
else
  set background=light
endif
" }}}

" COC Completions {{{
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" }}}

" IndentLine {{{
let g:indentLine_faster=1
let g:indentLine_setColors=0
let g:indentLine_setConceal = 0
" }}}

" Grepper {{{
let g:grepper = {}
runtime autoload/grepper.vim
let g:grepper.jump = 1
let g:grepper.stop = 500
noremap <leader>gr :GrepperRg<Space>
xmap gr <plug>(GrepperOperator)
" }}}

" Auto Save {{{
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]
" }}}

" Fugitive {{{
noremap <leader>gb :Gblame<CR>
" }}}

" Neotex {{{
let g:neotex_enabled = 2
let g:neotex_latexdiff = 1
let g:neotex_pdflatex_alternative = "lualatex"
let g:tex_flavor = 'latex'
" }}}

" Markdown Preview {{{

" Commands are :MarkdownPreview and :MarkdownPreviewStop
" Listen to buffer write and display images as well
let g:mkdp_auto_start = 0
" }}}
