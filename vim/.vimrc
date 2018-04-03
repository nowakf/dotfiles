set nocompatible
filetype plugin on
syntax on
set autowrite

map <silent><esc> :noh<cr>
"this clears search on escearch'


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
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'

call plug#end()
"Some experimental stuff for pdfs
set mouse=a

function! Altmap(char)
  if has('gui_running') | return ' <A-'.a:char.'> ' | else | return ' <Esc>'.a:char.' '|endif
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

"plaintext editing stuff:
autocmd FileType text :nnoremap <leader>cd :cd /home/francis/Documents/z-n.0.01/<cr>
autocmd FileType text :nmap f <Plug>(easymotion-f)
autocmd FileType text :nmap F <Plug>(easymotion-F)

:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78
"Undotree
nnoremap <F5> :UndotreeToggle<cr>
let persistent_undo = 1
set undodir=~/.undodir/
if has('persistent_undo')
	set undofile
endif

let g:undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
let g:undotree_CustomDiffpanelCmd = 'belowright 10 new'

"Table mode stuff:
let g:table_mode_auto_align = 1
let g:table_mode_motion_left_map = '[['
let g:table_mode_motion_right_map = ']]'
let g:table_mode_map_prefix = '<Leader>t'
let g:table_mode_toggle_map = 'm'


if !has('nvim')
  set term=xterm
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


set ttimeout
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
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"" Backup, Swap and Undo
set undofile " Persistent Undo
set directory=~/.vim/swap,/tmp
set backupdir=~/.vim/backup,/tmp
set undodir=~/.vim/undo,/tmp

