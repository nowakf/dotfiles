
set nocompatible
set guioptions=
set guifont=Deja\ Vu\ Sans\ Mono\ 14


nnoremap <leader>K :echo(eval('"\'.expand('<cword>').'"'))<cr>
set hlsearch
filetype plugin on
syntax on
set autowrite

nnoremap gr $
nnoremap gl 0

"set shortmess=aqcst
"
cnoremap W! w !sudo tee > /dev/null %

let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.5.0/src'

"operator pending mapping to do stuff in quotes

nnoremap <silent><nowait><leader>/ :noh<cr>



"this clears search on escearch

"Forgot about this, very cool:
command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'SirVer/Ultisnips'
Plug 'Valloric/YouCompleteMe', { 'on': [] }
"some weirdness here
Plug 'chrisbra/csv.vim'
Plug 'HiPhish/info.vim'
Plug 'beyondmarc/glsl.vim'
Plug 'tommcdo/vim-exchange'
Plug 'kopischke/vim-fetch'
Plug 'mhinz/vim-startify'
Plug 'dhruvasagar/vim-table-mode'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf' "?
Plug 'junegunn/goyo.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'

Plug 'mbbill/undotree'
Plug 'xtal8/traces.vim'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
"Plug 'tpope/vim-sensible'
"these have problems in neovim
if !has('nvim')
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'vim-utils/vim-man'
	Plug 'rhysd/open-pdf.vim'
endif

call plug#end()
"Some experimental stuff for pdfs


autocmd FileType haskell call g:ExpTabs()
autocmd FileType notex call g:ExpTabs()


command! ExpTabs :call ExpTabs()
"so I can call this manually
function! g:ExpTabs(...)
        if a:0 > 0
                let stop = a:1
        else
                let stop = 8
        endif
	let &tabstop=stop
	set expandtab
	let &softtabstop=stop / 2
	let &shiftwidth=stop / 2
	set shiftround
endfunction


set mouse=a
"C# stuff

command! AutoComplete  :call plug#load('YouCompleteMe')
nnoremap <leader>ac :AutoComplete<cr>

"move to current file
"switching buffers:
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <silent><Leader><CR> :Buffers<cr>
"noremap <esc><esc> :ccl<cr>
nnoremap <leader><T> :Tags<cr>


function! s:buflist()
	redir => ls
	silent ls
	redir END
	return split(ls, '\n')
endfunction

"function! s:bufopen(e)
"	execute 'buffer' matchstr(a:e, '^[ 0-9]*')
"endfunction

set backspace=indent,eol,start

autocmd FileType twee :nnoremap � /<C-R>="::".expand('<cword>')<C+)<CR>"

autocmd FileType markdown iab <buffer> mrr <!--more-->
autocmd Filetype markdown iab <buffer><expr> dts strftime("%Y%m%d")

"plaintext editing stuff:
autocmd FileType text :nnoremap <leader>cd :cd /home/francis/Documents/z-n.0.01/<cr>

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
autocmd GUIEnter * set visualbell t_vb=
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

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

map <Leader>g :Goyo<CR>

map Y y$

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
if !has('nvim')
	nnoremap <A-j> :m .+1<CR>==
	nnoremap <A-k> :m .-2<CR>==
	inoremap <A-j> <Esc>:m .+1<CR>==gi
	inoremap <A-k> <Esc>:m .-2<CR>==gi
	vnoremap <A-j> :m '>+1<CR>gv=gv
	vnoremap <A-k> :m '<-2<CR>gv=gv
else
	nnoremap ê :m .+1<CR>==
	nnoremap ë :m .-2<CR>==
	inoremap ê <Esc>:m .+1<CR>==gi
	inoremap ë <Esc>:m .-2<CR>==gi
	vnoremap ê :m '>+1<CR>gv=gv
	vnoremap ê :m '<-2<CR>gv=gv
endif

vnoremap < <gv
vnoremap > >gv

map <leader>ta :Tabularize /

"let &t_AB="\e[48;5;%dm" 
"let &t_AF="\e[38;5;%dm" 

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

set laststatus=0
set splitbelow
set splitright


let g:markdown_fenced_languages = ['rust']

set textwidth=0
set wrapmargin=0

"better easymotion colors

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

"" Backup, Swap and Undo
set undofile " Persistent Undo
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//


