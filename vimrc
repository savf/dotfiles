syntax enable
set background=light
colorscheme solarized
" turn on line numbers
set nu
" turn on relativenumber
set relativenumber
" remap : to ; for less typing
nnoremap ; :
" define tab size as 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
" vim-smooth-scroll
noremap <silent> <s-j> :call smooth_scroll#down(4, 1, 1)<CR>
noremap <silent> <s-k> :call smooth_scroll#up(4, 1, 1)<CR>
