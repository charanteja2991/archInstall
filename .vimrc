
" An example for a vimrc file.
"
" Maintainer:	The Vim Project <https://github.com/vim/vim>
" Last Change:	2023 Aug 10
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" i, j, l needs to be remaped, k is fine
nnoremap j h
nnoremap k j
nnoremap i k

xnoremap j h
xnoremap k j
xnoremap i k

onoremap j h
onoremap k j
onoremap i k

" 'h' means "inside" for text objects: ciw -> chw, di( -> dh(
onoremap h i
xnoremap h i

" since i is going and i need insert, i use a as insert... :)
nnoremap a i

set tabstop=4

syntax on

let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1
let g:cpp_operator_highlight = 1

set clipboard=unnamedplus

" ===================================================
" C++ IDE setup (added)
" ===================================================

" --- Editor comfort ---
let mapleader = " "                        " Space is the "leader" key for shortcuts
set number                                 " line numbers
set shiftwidth=4 expandtab                 " indent with 4 spaces (matches your tabstop)
set signcolumn=yes                         " keeps a column on the left for error markers
set updatetime=300                         " faster error refresh
set completeopt=menuone,noinsert,noselect  " popup doesn't force-insert a suggestion

" --- Language server (clangd gives completion + error checking) ---
let g:lsp_diagnostics_echo_cursor = 1      " show error text at the bottom when on that line

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  nmap <buffer> gd <plug>(lsp-definition)      " go to definition (Ctrl-o to jump back)
  nmap <buffer> gr <plug>(lsp-references)      " find all uses
  nmap <buffer> K  <plug>(lsp-hover)           " show documentation
  nmap <buffer> <leader>rn <plug>(lsp-rename)  " rename a variable/function everywhere
  nmap <buffer> ]g <plug>(lsp-next-diagnostic) " jump to next error
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" --- Autocomplete popup: Tab to move, Enter to accept ---
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? (complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-e>\<CR>") : "\<CR>"

" --- Fuzzy finder ---
nnoremap <leader>f :Files<CR>              " Space f: find a file by name
nnoremap <leader>g :Rg<CR>                 " Space g: search text across files

" --- Build and run with F5 (change c++17 to c++98 etc. if you like) ---
augroup cpp_run
  autocmd!
  autocmd FileType cpp nnoremap <buffer> <F5> :w<CR>:!g++ -std=c++17 -Wall -Wextra -g % -o %:r && ./%:r<CR>
augroup END

" --- Auto-close brackets and quotes ---
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
" {<Enter> gives you an indented empty line between the braces
inoremap {<CR> {<CR>}<Esc>O
" Typing the closing character when it is already next to the cursor just steps over it
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
