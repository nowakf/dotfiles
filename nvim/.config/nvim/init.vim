source ~/.vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set laststatus=0

call plug#begin('~/.local/share/nvim/plugged')

Plug 'fatih/vim-go'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'roxma/nvim-completion-manager'
Plug 'w0rp/ale'
Plug 'roxma/ncm-clang'
Plug 'tpope/vim-fugitive'
Plug 'OmniSharp/omnisharp-vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'cyansprite/deoplete-omnisharp'
call plug#end()



" Compile C# programs with the Unity engine DLL file
let g:ale_cs_mcsc_assembly_path = [
\ '/opt/Unity/Editor/Data/Managed/',
\]
let g:ale_cs_mcsc_assemblies = [
\ '/opt/Unity/Editor/Data/Managed/',
\]
"OmniSharp

let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_server_path = '/home/francis/.omnisharp/omnisharp/OmniSharp.exe'
let g:OmniSharp_selector_ui = 'fzf'
function! g:CS_stuff()
	"setlocal noshowmatch
endfunction

autocmd FileType cs :call g:CS_stuff()

augroup filetype_go
	autocmd!
	autocmd FileType go nnoremap <Leader>R <Plug>(go-run)
	autocmd FileType go nnoremap <Leader>i <Plug>(go-info)
	autocmd FileType go nnoremap <Leader>B :GoBuild<cr>
	autocmd FileType go nnoremap <silent>FF :execute "normal! mq?func (\r:nohlsearch\ryt)`qpa) "<cr>:startinsert!<cr>
augroup END
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

"{{{ PATH

set path+=/usr/avr/include
set path+=/usr/avr/include/avr

"}}}
