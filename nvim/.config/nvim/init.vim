source ~/.vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set laststatus=0

call plug#begin('~/.local/share/nvim/plugged')
"scheme
Plug 'Olical/vim-scheme', { 'for': 'scheme', 'on': 'SchemeConnect' }
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'elzr/vim-json'
Plug 'simonjbeaumont/vim-ocamlspot'
Plug 'vim-scripts/CRefVim'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'HiPhish/repl.nvim'
"let g:racer_cmd = "/home/francis/.cargo/bin/racer"{{{
"let g:racer_insert_paren = 1
"au FileType rust nmap gd <Plug>(rust-def)
"au FileType rust nmap gs <Plug>(rust-def-split)
"au FileType rust nmap gx <Plug>(rust-def-vertical)
"au FileType rust nmap K <Plug>(rust-doc)
"Plug 'racer-rust/vim-racer'}}}
Plug 'tpope/vim-fugitive'
call plug#end()

set hidden
set foldmethod=marker

augroup filetype_rust"{{{
	inoremap <silent><expr> <c-n> coc#refresh()
	"set completefunc=coc#refresh()
	set signcolumn=yes
	set completeopt=menu
	" Use `[c` and `]c` for navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)

	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K for show documentation in preview window
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
	  if &filetype == 'vim'
	    execute 'h '.expand('<cword>')
	  else
	    call CocAction('doHover')
	  endif
	endfunction
	vmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)
augroup END"}}}

"if executable('rls'){{{
"	au User lsp_setup call lsp#register_server({
"		\'name':'rls',
"		\'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
"		\'whitelist':['rust'],
"		\})
"endif}}}



" Starts the REPL.
autocmd FileType scheme nnoremap <buffer> <localleader>rc :SchemeConnect<cr>

" Evaluates the outer most / top level form and jumps the cursor back to where it was.
autocmd FileType scheme nnoremap <buffer><silent> <localleader>re :normal mscpaF<cr>`s

autocmd FileType scheme call repl#define_repl('scheme', {'bin':'guile'}, 'force')
" Evaluates the entire file.
autocmd FileType scheme nnoremap <buffer><silent> <localleader>rf :normal msggcpG<cr>`s

autocmd FileType scheme nmap <leader>rs <Plug>(ReplSend)

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap <Esc><Esc> <C-\><C-n>
autocmd BufWinEnter,WinEnter term://* startinsert


autocmd FileType json nnoremap <silent>]] :call JSONMove('e')<cr>"{{{
autocmd FileType json nnoremap <silent>[[ :call JSONMove('be')<cr>
autocmd FileType json onoremap iq i"

function! JSONMove(flags)
	let pattern = '\m:\s*"\=[0-9a-zA-Z]\='
	call search(pattern, a:flags)
endfunction"}}}

"C++:
"
autocmd filetype cpp call g:ExpTabs()

autocmd FileType cpp set keywordprg=:Cppman
command! -nargs=* Cppman pclose | ped +:terminal\ cppman\ <args>

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"

augroup filetype_ml"{{{
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
"}}}
augroup filetype_go"{{{
	autocmd!
	autocmd FileType go nnoremap <Leader>i <Plug>(go-info)
	autocmd FileType go nnoremap <Leader>B :GoBuild<cr>
	autocmd FileType go nnoremap <Leader>I :GoImports<cr>
	autocmd FileType go nnoremap <Leader>C :GoCallers<cr>
	autocmd FileType go nnoremap <Leader>TF :GoTestFunc<cr>
	autocmd FileType go nnoremap <silent>FF :execute "normal! mq?func (\r:nohlsearch\ryt)`qpa) "<cr>:startinsert!<cr>
augroup END
let g:ale_sign_column_always = 1
"}}}

:tnoremap <Leader><Esc> <C-\><C-n>"{{{

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
"}}}
set path+=/usr/avr/include
set path+=/usr/avr/include/avr

"imap <silent> <CR> <C-r>=ExpandLspSnippet()<CR>{{{
"function! ExpandLspSnippet()
"    call UltiSnips#ExpandSnippetOrJump()
"    if !pumvisible() || empty(v:completed_item)
"        return ''
"    endif
"
"    " only expand Lsp if UltiSnips#ExpandSnippetOrJump not effect.
"    let l:value = v:completed_item['word']
"    let l:matched = len(l:value)
"    if l:matched <= 0
"        return ''
"    endif
"
"    " remove inserted chars before expand snippet
"    if col('.') == col('$')
"        let l:matched -= 1
"        exec 'normal! ' . l:matched . 'Xx'
"    else
"        exec 'normal! ' . l:matched . 'X'
"    endif
"
"    if col('.') == col('$') - 1
"        " move to $ if at the end of line.
"        call cursor(line('.'), col('$'))
"    endif
"
"    " expand snippet now.
"    call UltiSnips#Anon(l:value)
"    return ''
"endfunction
"
"imap <C-k> <C-R>=ExpandLspSnippet()<CR>}}}
