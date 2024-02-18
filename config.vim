" tab setup
set tabstop=4
set shiftwidth=4
set expandtab

" mouse
set mouse=a

" pretty stuff
set termguicolors
set cursorline
set number relativenumber
set signcolumn=yes
colorscheme catppuccin

" better folding
filetype plugin indent on
syntax on
autocmd FileType * AnyFoldActivate
set foldlevel=0

" keybinds
nnoremap <leader>of :NvimTreeToggle<CR>
nnoremap <leader>ot :ToggleTerm<CR>
nnoremap <leader>oa :AerialToggle<CR>
nnoremap <leader>om :MarkdownPreview<CR>

" autocmd
autocmd FileType c,cpp :AerialToggle
