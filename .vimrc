"colo delek
colo blue

syntax enable " syntax highlighting

set tabstop=4 " spaces/TAB when reading a file
set softtabstop=4 " spaces when WRITING a tab
set expandtab
set shiftwidth=4 " indent by 4
set autoindent " auto indent

set number relativenumber " show line numbers
set showmatch " highlight matching [{()}]

set incsearch " search as characters are entered
set hlsearch " highlight result

" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

" gotta go fast
nnoremap B ^
nnoremap E $
nnoremap ^ <nop>
nnoremap $ <nop>

nnoremap J 5j
nnoremap K 5k

" jk is escape
inoremap jk <esc>

" ease of life
:command WQ wq
:command W w
:command Q q
:command Wq wq

"search into subfolders
"provides tab-completion for all file-related tasks
set path+=**
"display all matching files when we tab complete
set wildmenu

"hs = horizontal split. Easier to remember
cnoreabbrev <expr> hs ((getcmdtype() is# ':' && getcmdline() is# 'hs')?('sp'):('hs'))

"save window buffers
nnoremap ,s :mksession!<CR>

"shortcut to edit vimrc
nnoremap ,rc :vsp ~/.vimrc<CR>

"make backspace behave properly
set backspace=indent,start,eol

set cc=80

"Sam as windo, but leaves cursor on original window
function! WinDo(command)
    let currwin=winnr()
    execute 'windo ' . a:command
    execute currwin . 'wincmd w'
endfun
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

"Make :windo call the WinDo function above
cnoreabbrev <expr> windo ((getcmdtype() is# ':' && getcmdline() is# 'windo')?('Windo'):('windo'))

nnoremap <F2> :execute "set cc=" . (&cc == "" ? "80" : "") <CR>

"make it easier to print things in C++
let @p='istd::cout << '
let @n='A << ''\n'';jkV>'

"fun! ToggleCC()
"    if &cc=''
"        set cc=80
"    else
"        set cc=
"    endif
"endfun
"nnoremap <F2> :call ToggleCC()<CR>

nmap <S-Enter> Ojkj
nmap <CR> ojkk


nnoremap ,1 1gt
nnoremap ,2 2gt
nnoremap ,3 3gt
nnoremap ,4 4gt
nnoremap ,5 5gt
nnoremap ,6 6gt
nnoremap ,7 7gt
nnoremap ,8 8gt
nnoremap ,9 9gt
