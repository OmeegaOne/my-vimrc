" Basic settings {{{
filetype on
syntax on
set encoding=utf-8
set splitright
set nospell
set laststatus=2
set statusline=%f " File name
set statusline+=%= " Go to the right
set statusline+=%y " FileType
set statusline+=[%l/%L] " Lines
set statusline+=%m%r " Modifiable and ReadOnly
set incsearch
set hlsearch
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set clipboard^=unnamed
set number
set background=dark

" Netrw expanded {{{
" Not fully tested
function! OpenFileOrDir(file)
  " Check if Netrw is active and a file is selected
  let path = b:netrw_curdir . '/' .  a:file
  if isdirectory(path)
      execute 'ex' . path
  else
    " Open regular file in a new pane or current pane
    if exists('$TMUX')
      " If inside tmux, open file in a new pane using vim clientserver
      execute 'vim --servername tmuxEditor --remote-tab ' . path
    else
      " If not in tmux, open file in the current pane
      execute 'vsp ' . path
    endif
  endif
endfunction

" Remove the default <CR> mapping in Netrw
let g:netrw_browse_maps = 0
" Redefine <CR> behavior in Netrw
autocmd FileType netrw nnoremap <buffer> <CR> :call OpenFileOrDir(expand('<cWORD>'))<CR>
" }}}
" }}}

" Mapings {{{
let mapleader = ","
let maplocalleader = ";"

inoremap <c-u> <esc>viwUi
inoremap <c-l> <esc>viwui
inoremap jk <esc>
inoremap <esc> <nop>
inoremap hh <left>

nnoremap <leader>c ddO
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr> :echo "File sourced"<cr>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>pb execute "rightbelow split" . bufname("#")<cr>
nnoremap <leader>; execute "normal! mqA;\e`q"<cr>
nnoremap <leader>w mq:match Error /\v\s+$/<cr> /\v\s+$<cr>`q
nnoremap <leader>wc mq:%s/\v\s+$/<cr>`q
nnoremap <leader>mn :match none<cr> :nohlsearch<cr>
nnoremap <leader>sn :nohlsearch<cr>
nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen 15<cr>
nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprevious<cr>
nnoremap H 0
nnoremap L $
nnoremap / /\v

vnoremap H 0
vnoremap L $

onoremap p i(
" }}}

" Abbreviations {{{
iabbrev @@ your@mail.com
iabbrev ssig Firstname LASTNAME<cr>your@mail.com
" }}}

" Settings for specific FileType {{{
"" HTML file settings {{{
augroup filetype_html
  autocmd!
  autocmd BufWritePre,BufRead *.html :normal gg=G
  autocmd BufNewFile,BufRead *.html setlocal nowrap
augroup END
"" }}}
"" Python file settings {{{
augroup filetype_python
  autocmd!
  autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
  autocmd FileType python vnoremap <buffer> <localleader>c :s/^/# <esc>
  autocmd FileType python iabbrev <buffer> iff if:<left>
  autocmd FileType python iabbrev <buffer> ret return
  autocmd FileType python onoremap f :<c-u>execute "normal! ?def\rjV/return\rk"<cr> " Not working yet
augroup END
"" }}}
"" Vimscript file settings {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim nnoremap <buffer> <localleader>c I" <esc>
  autocmd FileType vim vnoremap <buffer> <localleader>c :s/^/" <esc>
  autocmd FileType vim setlocal nospell
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevelstart=0
augroup END
"" }}}
"" Markdown file settings {{{
augroup filetype_markdown
  autocmd!
  autocmd FileType markdown nnoremap <buffer> <localleader>i viw<esc>a*<esc>bi*<esc>lel
  autocmd FileType markdown nnoremap <buffer> <localleader>b viw<esc>bi**<esc>ea**<esc>lel
  autocmd FileType markdown nnoremap <buffer> <localleader>c viw<esc>bi`<esc>ea`<esc>lel
  autocmd FileType markdown nnoremap <buffer> <localleader>t I#<esc> " Improvement needed
  autocmd FileType markdown vnoremap <buffer> <localleader>c c```<cr><c-r>"```<cr><esc>
  autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?^#\r$vF#ll"<cr>
  autocmd FileType markdown onoremap @ :<c-u>execute "normal! /@\rEvB"<cr>
  autocmd FileType markdown setlocal spell
  autocmd FileType markdown setlocal spell spelllang=en,fr
augroup END
"" }}}
"" JS file settings {{{
augroup filetype_js
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
  autocmd FileType javascript iabbrev <buffer> iff if ()<left>
augroup END
"" }}}
" }}}
"
" Ty Steve Losh
