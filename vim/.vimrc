set nocompatible
filetype plugin on
syntax on
set autowrite

map <silent><esc> :noh<cr>
"this clears search on esc.

command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a

call plug#begin('~/.vim/plugged')

Plug 'kopischke/vim-fetch'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
Plug 'junegunn/goyo.vim'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
"At some point I should probably make this neater
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
"this has a problem in neovim
Plug 'rhysd/open-pdf.vim'
Plug 'mbbill/undotree'
Plug 'xtal8/traces.vim'

call plug#end()
"Some experimental stuff for pdfs
set mouse=a

function! Altmap(char)
  if has('gui_running') | return ' <A-'.a:char.'> ' | else | return ' <Esc>'.a:char.' '|endif
endfunction

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78
"Undotree
nnoremap <F5> :UndotreeToggle<cr>
let persistent_undo = 1
if has('persistent_undo')
	set undodir=~/.undodir/
	set undofile
endif

let g:undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
let g:undotree_CustomDiffpanelCmd = 'belowright 10 new'

"Table mode stuff:
let g:table_mode_auto_align = 1
let g:table_mode_motion_left_map = '[<Bar>'
let g:table_mode_motion_right_map = ']<Bar>'

if !has('nvim')
  set term=xterm
  set t_Co=256
endif

set noerrorbells visualbell t_vb=
set autoindent

set spell spelllang=en_gb

"let g:taskwiki_taskrc_location = '/cygdrive/c/Users/Administrator/.taskrc'
"let g:taskwiki_data_location = '/cygdrive/c/Users/Administrator/.task'

set backspace=indent,eol,start

autocmd FileType twee :nnoremap � /<C-R>="::".expand('<cword>')<CR><CR>
autocmd FileType yarn :nnoremap � /<C-R>="title: ".expand('<cword>')<CR><CR>

"vim-go stuff
nnoremap <silent> <Leader>L :GoLint<CR>
nnoremap <silent> <Leader>E :GoErrCheck<CR>

"FZF stuff
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <Leader>o  :History <CR>
nnoremap <silent> <Leader>F :Lines <CR>
autocmd VimEnter * command St noautocmd enew | call startify#insane_in_the_membrane()
set ttimeout
set ttimeoutlen=0
autocmd TabEnter * set showtabline=1 
autocmd TabEnter * let timer = timer_start(1000, 'SetTabLine')
func SetTabLine(timer)
	set showtabline=0
endfunc
"pomodoro
let g:startify_custom_header = []

map <Leader>g :Goyo<CR>

exec 'nnoremap'.Altmap('j').':m .+1<CR>=='
exec 'nnoremap'.Altmap('k').':m .-2<CR>=='

map <leader>ta :Tabularize /

let &t_AB="\e[48;5;%dm" 
let &t_AF="\e[38;5;%dm" 

set wrap
set linebreak
set nolist
set display=lastline
set breakindent

colors zenburn

"some stuff for splits:
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

let g:vimwiki_table_mappings=0
let g:vimwiki_table_auto_fmt=0

set textwidth=0
set wrapmargin=0

"better easymotion colors

hi link EasyMotionTarget Boolean

let g:EasyMotion_do_mapping = 0
map <Leader>f <Plug>(easymotion-s)
map f <Plug>(easymotion-f)
map F <Plug>(easymotion-F)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"for i in range(97,122)
"	let c = nr2char(i)
"	exec "map ".c." <M-".c.">"
"	exec "map! ".c." <M-".c.">"
"endfor
