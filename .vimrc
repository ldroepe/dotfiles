" colo delek
colo peachpuff

syntax enable " syntax highlighting

set tabstop=4 " spaces/TAB when writing a file
set softtabstop=4 " spaces when WRITING a tab
set expandtab " TAB = put 4 spaces instead of \t
set shiftwidth=4 " indent by 4
set autoindent

set number relativenumber " line numbers
set showmatch " highlight matching [{()}]

set incsearch " incremental search
set hlsearch " highlight result

" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

" gotta go fast
nnoremap B ^
nnoremap E $
nnoremap J 5j
nnoremap K 5k

vnoremap B ^
vnoremap E $

" jk is escape
inoremap jk <esc>

" ease of life
:command W w
:command Wq wq
:command WQ wq
:command Q q

"search into subfolders
"provides tab-completion for all file-related tasks
set path+=**
"display all matching files when we tab complete
set wildmenu

"hs = horizontal split. Easier to remember
cnoreabbrev <expr> hs ((getcmdtype() is# ':' && getcmdline() is# 'hs')?('sp'):('hs'))

" save window buffers
nnoremap ,s :mksession<CR>

" shortcut to vimrc
nnoremap ,rc :vsp ~/.vimrc<CR>

" fix backspace
set backspace=indent,start,eol

" 80 character reminder
set cc=80

" change cc color
highlight ColorColumn ctermbg=green

" toggle color column on & off
fun! ToggleCC()
    if &cc == ''
        set cc=80
    else
        set cc=
    endif
endfun
nnoremap <F2> :call ToggleCC()<CR>

"same as windo, but leaves curser on original window
function! WinDo(command)
    let currwin=winnr()
    execute 'windo ' . a:command
    execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

"make :windo call the Windo function above
cnoreabbrev <expr> windo ((getcmdtype() is# ':' && getcmdline() is# 'windo')?('Windo'):('windo'))

" make it easier to print things in C++
let @p='istd::cout << '
let @n='A << ''\n'';jkV>'


" makes working with tabs easier
nnoremap ,1 1gt
nnoremap ,2 2gt
nnoremap ,3 3gt
nnoremap ,4 4gt
nnoremap ,5 5gt
nnoremap ,6 6gt
nnoremap ,7 7gt
nnoremap ,8 8gt
nnoremap ,9 9gt
nnoremap ,b :ls<CR>
nnoremap ,o :only<CR>


" Write blank lines without entering insert mode
nmap <S-Enter> Ojkj
nmap <CR> ojkk

fun! ToggleCursorline()

    if &cursorline == 1
        set nocursorline
    else
        set cursorline
    endif
endfun
nnoremap <F3> :call ToggleCursorline()<CR>

inoremap <C-e> <C-o>$
inoremap <C-b> <C-o>^

" Abbreviation for vertical split find
cabbrev vsf rightb vert sfind
