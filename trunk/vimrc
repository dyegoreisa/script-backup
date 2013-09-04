syntax on
colorscheme slate
set number
set autoindent

let $VIM = "/etc/vim/gvimrc"

" Faz as string de querys tenha highlight
let php_sql_query = 1 

" Trabalha o tab como espaço
set ts=4
set shiftwidth=4
set expandtab
set smarttab
set tabstop=4 "Seta o tab para 4 espaços

" PHP autocomplete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

nnoremap <silent> <c-/> I

" Useful aliases to close the editor
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq | cab Bn bn | cab Bp bp | cab Bd bd

" PHP Documentor from Vim
"source ~/.vim/php-doc.vim 
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 

" Identando código css copiado do firebug
vnoremap <C-i> :s/\(.\+\)\(:\)\(.*\)/\ \ \ \ \1\2\ \3/<CR>

" Hightlight current line
:set cursorline
:set cursorcolumn
:hi Cursorline   guibg=#000000
:hi Cursorcolumn guibg=#111111

" Hightlight search
:set hls

" Retira hightlight
nnoremap <C-h> /ºlimpa-search-hightlightª<CR>

" Atalhos para trabalhar com Abas
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-o> :browse tabnew<CR>
nnoremap <silent> <c-l> :buffers<CR>
map <C-y> :tabf
map <C-w> :bd<CR>

" Set character invisible
:set lcs=tab:>-,eol:«,nbsp:·

" Aprimorando a busca
set incsearch
set hlsearch
nmap n nzz
nmap N Nzz

" Autorregarregando nosso .gvimrc
autocmd! bufwritepost .gvimrc source %
autocmd! bufwritepost .vimrc source %

" Executando shell
set shell=/bin/bash
nnoremap <C-s> :shell<CR>

