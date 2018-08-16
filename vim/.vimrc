set nocompatible
set hlsearch
set title titlestring=
filetype plugin on
syntax on
set autowrite

iab <expr> dts strftime("%Y%m%d")

"set shortmess=aqcst
"
cnoremap W! w !sudo tee > /dev/null %

"operator pending mapping to do stuff in quotes

nnoremap <silent><esc><c-l> :noh<cr>

"some mappings to deal with the diff between english and US keyboards 
noremap ' "
noremap @ '
noremap " @

"this clears search on escearch

command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a

call plug#begin('~/.vim/plugged')

Plug 'SirVer/Ultisnips'
"Plug 'Valloric/YouCompleteMe'
Plug 'chrisbra/csv.vim'
Plug 'HiPhish/info.vim'
Plug 'tommcdo/vim-exchange'
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
Plug 'mbbill/undotree'
Plug 'xtal8/traces.vim'
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
"these have problems in neovim
if !has('nvim')
	Plug 'vim-utils/vim-man'
	Plug 'rhysd/open-pdf.vim'
endif

call plug#end()
"Some experimental stuff for pdfs
set mouse=a

function! Altmap(char)
	if has('gui_running') | return ' <A-'.a:char.'> ' | else | return ' <Esc>'.a:char.' '|endif
endfunction

autocmd filetype haskell call g:ExpTabs()


function! g:ExpTabs()
	set tabstop=8
	set expandtab
	set softtabstop=4
	set shiftwidth=4
	set shiftround
endfunction

"C# stuff
let g:ycm_filetype_whitelist = { 'cs' : 1 }
autocmd FileType cs call LoadYCM() 
function! LoadYCM()
	if !exists("g:loaded_youcompleteme")
		let g:ycm_always_populate_location_list = 1
		packadd YouCompleteMe
	endif
endfunction

"move to current file
"switching buffers:
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <silent><Leader><CR> :Buffers<cr>
nnoremap <silent><esc><esc> :ccl <cr>
nnoremap <leader><T> :Tags<cr>

"sneak stuff
autocmd ColorScheme * hi! link Sneak Conditional
let g:sneak#s_next = 1
function! s:buflist()
	redir => ls
	silent ls
	redir END
	return split(ls, '\n')
endfunction

function! s:bufopen(e)
	execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

set backspace=indent,eol,start

autocmd FileType twee :nnoremap � /<C-R>="::".expand('<cword>')<C+)<CR>"

autocmd FileType markdown :nnoremap <leader>m :i<!--more--><cr>P

"plaintext editing stuff:
autocmd FileType text :nnoremap <leader>cd :cd /home/francis/Documents/z-n.0.01/<cr>
autocmd FileType *.txt :nmap f <Plug>(easymotion-f)
autocmd FileType *.txt :nmap F <Plug>(easymotion-F)

:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78
"Undotree
nnoremap <F5> :UndotreeToggle<cr>
let persistent_undo = 1
set undodir=~/.undodir/
if has('persistent_undo')
	set undofile
endif
" Only apply the mapping to generated buffers

autocmd FileType info nmap gu <Plug>(InfoUp)
autocmd FileType info nmap gn <Plug>(InfoNext)
autocmd FileType info nmap gp <Plug>(InfoPrev)
autocmd FileType info nmap <Space> <PageDown>



let g:undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
let g:undotree_CustomDiffpanelCmd = 'belowright 10 new'

"Table mode stuff:
let g:table_mode_auto_align = 1
let g:table_mode_motion_left_map = '[['
let g:table_mode_motion_right_map = ']]'
let g:table_mode_map_prefix = '<Leader>t'
let g:table_mode_toggle_map = 'm'


if !has('nvim')
	set t_Co=256
endif

set noerrorbells visualbell t_vb=
set autoindent

set spell spelllang=en_gb




autocmd FileType twee :nnoremap � /<C-R>="::".expand('<cword>')<CR><CR>
autocmd FileType yarn :nnoremap � /<C-R>="title: ".expand('<cword>')<CR><CR>

"FZF stuff
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <Leader>o  :History <CR>
nnoremap <silent> <Leader>F :Lines <CR>



autocmd VimEnter * command St noautocmd enew | call startify#insane_in_the_membrane()
let g:startify_bookmarks = [ {'c': '~/.vimrc'}, {'n':'~/.config/nvim/init.vim'}, '~/.zshrc' ]
let g:startify_custom_header = []


set ttimeoutlen=0
autocmd TabEnter * set showtabline=1 
autocmd TabEnter * let timer = timer_start(1000, 'SetTabLine')
func! SetTabLine(timer)
	set showtabline=0
endfunc

map <Leader>g :Goyo<CR>

function! g:Goyo_Before()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! g:Goyo_After()
	" Quit Vim if this is the only remaining buffer
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction

let g:goyo_callbacks = [function('g:Goyo_Before'), function('g:Goyo_After')]

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
"
"if has('nvim')
"	nnoremap <BS> <C-W>h
"endif

nnoremap <c-h> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

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
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"" Backup, Swap and Undo
set undofile " Persistent Undo
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//

