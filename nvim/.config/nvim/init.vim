source ~/.vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

call plug#begin('~/.local/share/nvim/plugged')

Plug 'fatih/vim-go'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
Plug 'roxma/nvim-completion-manager'
Plug 'tpope/vim-surround'

call plug#end()

let g:UltiSnipsExpandTrigger="<tab>"

autocmd FileType go nmap <Leader>R <Plug>(go-run)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>I <Plug>(go-doc)
autocmd FileType go nmap <Leader>D <Plug>(go-def)
autocmd FileType go nmap <Leader>B <Plug>(go-build)

let g:ale_sign_column_always = 1

"COMPLETION-MANAGER
let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}

"Yaml-lint
let g:ale_yaml_yamllint_options = 'relaxed'


"VIM-GO SETTINGS:
let g:go_fmt_fail_silently = 1

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
