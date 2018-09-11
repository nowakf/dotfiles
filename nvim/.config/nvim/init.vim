source ~/.vimrc

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set laststatus=0

call plug#begin('~/.local/share/nvim/plugged')

Plug 'elzr/vim-json'
Plug 'simonjbeaumont/vim-ocamlspot'
Plug 'vim-scripts/CRefVim'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'

Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap <Esc><Esc> <C-\><C-n>
autocmd BufWinEnter,WinEnter term://* startinsert


autocmd FileType json nnoremap <silent>]] :call JSONMove('e')<cr>
autocmd FileType json nnoremap <silent>[[ :call JSONMove('be')<cr>
autocmd FileType json onoremap iq i"

function! JSONMove(flags)
	let pattern = '\m:\s*"\=[0-9a-zA-Z]\='
	call search(pattern, a:flags)
endfunction

"autocmd FileType json nnoremap ]] :execute 'silent normal! ' . '/' . ':\s*"' . '/' . 'e' . "\r" 

"C++:
"
autocmd filetype cpp call g:ExpTabs()
 
let g:ale_cpp_clangtidy_checks=[
\ 'modernize-*',
\ 'performance-*',
\ 'clang-analyser-*',
\ 'bugprone-*',
\]   

" 'clang-analyser-*','clang-analyser-cplusplus-*','bugprone-*','performance-*','llvm-*', 'modernize-*', 'google-*', 'fuschia-*'

autocmd FileType cpp set keywordprg=:Cppman
command! -nargs=* Cppman pclose | ped +:terminal\ cppman\ <args>

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

augroup filetype_ml
	autocmd!
	autocmd FileType ocaml call g:ExpTabs()
	autocmd FileType ocaml execute "set rtp+=" . substitute(system('opam config var share'), '\n$', '', '''') . "/ocp-indent/vim/indent/ocaml.vim"
	autocmd FileType ocaml :let g:ale_lint_on_text_changed='never'
	autocmd FileType ocaml :let g:ale_lint_on_enter=0
        autocmd FileType ocaml :let g:ale_lint_on_filetype_changed = 0
	autocmd FileType ocaml :let g:ale_lint_on_insert_leave=0
	autocmd FileType ocaml :let g:ale_lint_on_save=1
	autocmd FileType ocaml :ALEToggle
	autocmd FileType ocaml :ALEToggle
	"autocmd FileType ocaml :let g:ale_lint_delay=99999999999
augroup END

"Mapping to togal ale
nnoremap <Leader>a :ALEToggle<cr>

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
	autocmd FileType go nnoremap <Leader>i <Plug>(go-info)
	autocmd FileType go nnoremap <Leader>B :GoBuild<cr>
	autocmd FileType go nnoremap <Leader>I :GoImports<cr>
	autocmd FileType go nnoremap <Leader>C :GoCallers<cr>
	autocmd FileType go nnoremap <Leader>TF :GoTestFunc<cr>
	autocmd FileType go nnoremap <silent>FF :execute "normal! mq?func (\r:nohlsearch\ryt)`qpa) "<cr>:startinsert!<cr>
augroup END
let g:ale_sign_column_always = 1


"COMPLETION-MANAGER
let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}

"Yaml-lint
let g:ale_yaml_yamllint_options = 'relaxed'

"VIM-GO SETTINGS:
let g:go_fmt_fail_silently = 1

"TERMINAL
:tnoremap <Leader><Esc> <C-\><C-n>

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
