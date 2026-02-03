" colo delek
" colo peachpuff
colo desert

syntax enable " syntax highlighting

set tabstop=4 " spaces/TAB when writing a file
set softtabstop=4 " spaces when WRITING a tab
set expandtab " TAB = put 4 spaces instead of \t
set shiftwidth=4 " indent by 4
set autoindent " auto ident

set number relativenumber " line numbers
set showmatch " highlight matching [{()}]
set hlsearch " highlight search results

set incsearch " incremental search

let mapleader="-"

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" gotta go fast
nnoremap J 5j
nnoremap K 5k

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

"save window buffers
nnoremap <leader>s :mksession!<CR>

"shortcut to edit vimrc
nnoremap <leader>rc :vsp ~/.vimrc<CR>

"make backspace behave properly
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

nnoremap <F2> :execute "set cc=" . (&cc == "" ? "80" : "") <CR>
" toggle cursorline
fun! ToggleCursorline()

    if &cursorline == 1
        set nocursorline
    else
        set cursorline
    endif
endfun
nnoremap <F3> :call ToggleCursorline()<CR>
nnoremap <F4> yiw:grep -R <C-r>" ./* <CR>

" makes working with tabs easier
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Write blank lines without entering insert mode
nmap <S-Enter> Ojkj
nmap <CR> ojkk

" movement while in insert mode
"
" end of line
inoremap <C-e> <C-o>$
" beginning of line
inoremap <C-b> <C-o>^

" put the last word typed onto the next line
inoremap <C-j> <C-o>B<BS><CR><C-o>$

" Abbreviation for vertical split find
cabbrev vsf rightb vert sfind

" Easier to remember for whatever reason
nnoremap ]] ][
nnoremap ][ ]]

nnoremap <leader>k :cn<CR>
nnoremap <leader>j :cp<CR>

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>


" added text fg=green, bg=black
highlight DiffAdd       cterm=bold ctermfg=2 ctermbg=0
" deleted text fg=red, bg=black
highlight DiffDelete    cterm=bold ctermfg=1 ctermbg=0
" changed text (the line that was changed) fg=blue, bg=black
highlight DiffChange    cterm=bold ctermfg=4 ctermbg=0
" changed text (the actual text that was changed) fg=blue, bg=white
highlight DiffText      cterm=bold ctermfg=4 ctermbg=7

augroup scons_ft
    au!
    autocmd BufNewFile,BufRead SConstruct set syntax=python
    autocmd BufNewFile,BufRead SConscript set syntax=python
augroup END
