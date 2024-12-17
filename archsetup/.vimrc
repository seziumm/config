syntax on                      " Abilita l'evidenziazione della sintassi
set termguicolors
set bg=dark
colorscheme default
highlight Normal guibg=black ctermbg=black
set number                     " Mostra i numeri di riga
set relativenumber             " Numeri di riga relativi
set tabstop=2                  " Imposta la larghezza del tab a 4 spazi
set shiftwidth=2               " Imposta il numero di spazi per indentazione
set expandtab                  " Usa spazi invece di tab
set smartindent                " Indentazione intelligente
set autoindent                 " Mantiene l'indentazione
set nowrap                     " Evita il wrapping automatico
set clipboard=unnamedplus

set scrolloff=0
set fileformat=unix            " Usa line ending Unix
set fileformats=unix,dos       " Riconoscimento automatico dei line ending
set mouse=a 

set guioptions-=T
set guioptions-=m

set guioptions-=r     " Rimuove la barra di scorrimento verticale sulla destra
set guioptions-=R     " Rimuove la barra di scorrimento orizzontale in basso

autocmd VimEnter * 
    \ if filereadable('input.txt') | tabedit input.txt | endif |
    \ execute 'tabfirst'

nnoremap <Tab> :tabprevious<CR>
nnoremap <S-Tab> :tabnext<CR>


inoremap {<CR> {<CR>}<Esc>O

autocmd FileType cpp noremap <F6>  :w <bar> !clear && g++ -D MYDEBUG -std=c++17 -fsanitize=address -g -Og -Wall -Wextra %:t -o %:r && ./%:r < input.txt<CR>
autocmd FileType cpp noremap <F7>  :w <bar> !clear && g++ -D MYDEBUG -std=c++17 -fsanitize=address -g -Og -Wall -Wextra %:t -o %:r && ./%:r <CR>

autocmd FileType cpp noremap <F8>  :w <bar> !clear && g++ -D MYDEBUG -std=c++17 -O3 %:t -o %:r && ./%:r < input.txt<CR>
autocmd FileType cpp noremap <F9>  :w <bar> !clear && g++ -D MYDEBUG -std=c++17 -O3 %:t -o %:r && ./%:r<CR>
autocmd FileType cpp noremap <F10> :w <bar> !clear && g++ -D MYDEBUG -std=c++17 -O3 %:t -o %:r && ./%:r < input.txt > output.txt<CR>

let &t_SI = "\e[6 q"  " Modalità inserimento (linea verticale)
let &t_EI = "\e[2 q"  " Modalità normale (blocco)

set timeoutlen=1000 ttimeoutlen=0


"per commentare
vnoremap gc :s/^/\/\/<CR>

" Abilita l'undo persistente
set undofile        " Abilita la registrazione degli undo su file
set undodir=~/.vim/undodir " Specifica la directory per i file di undo
" creare prima la dir
"mkdir -p ~/.vim/undodi

if exists('g:loaded_wayland_clipboard')
    finish
endif
let g:loaded_wayland_clipboard = 1

" only run this in Vim on Wayland -- Vim on X has native clipboard support,
" and Neovim already works with wl-copy by default
if has('nvim') || empty($WAYLAND_DISPLAY)
    finish
endif

" }}}

" Yanking {{{

" The '+' register doesn't work for yanking if:
" - vim was built without 'clipboard'.
" - x11 / xwayland is unavailable.
" (https://github.com/vim/vim/blob/93197fde0f1db09b1e495cf3eb14a8f42c318b80/src/register.c#L247)
"
" My solution is to map '"+' to '"w' and send the 'w' register to the
" Wayland clipboard as well.
"
" This variable controls whether '"+' gets mapped to '"w'. It's on by default
" if the 'clipboard' feature isn't available, or if $DISPLAY isn't set,
" but the user can turn it off always if desired.
let s:plus_to_w = (!has('clipboard') || empty($DISPLAY)) && !exists('g:wayland_clipboard_no_plus_to_w')

" remap '"+' to '"w' -- this will only apply to yanking since '"+p' and '"+P'
" are also remapped below
if s:plus_to_w
    nnoremap "+ "w
    vnoremap "+ "w
endif

let s:copy_args = exists('g:wayland_clipboard_copy_args') ? g:wayland_clipboard_copy_args : []

" pass register contents to wl-copy if the '+' (or 'w') register was used
function! s:WaylandYank()
    if v:event['regname'] == '+' ||
                \ (v:event['regname'] == 'w' && s:plus_to_w) ||
                \ (v:event['regname'] == '' && &clipboard =~ 'unnamedplus')
        silent call job_start(['wl-copy'] + s:copy_args + ['--', getreg(v:event['regname'])], {
            \   "in_io": "null", "out_io": "null", "err_io": "null",
            \   "stoponexit": "",
            \ })
    endif
endfunction

" run s:WaylandYank() after every time text is yanked
augroup waylandyank
    autocmd!
    autocmd TextYankPost * call s:WaylandYank()
augroup END

" }}}

" Pasting {{{

" remap paste commands to first pull in clipboard contents with wl-paste

let s:paste_args = exists('g:wayland_clipboard_paste_args') ? g:wayland_clipboard_paste_args : []
let s:paste_args_str = empty(s:paste_args) ? '' : ' ' . join(s:paste_args)

function! s:clipboard_to_unnamed()
    silent let @"=substitute(system('wl-paste --no-newline' . s:paste_args_str), "\r", '', 'g')
endfunction

function! s:put(p, fallback)
    if a:fallback
        return a:p
    endif

    call s:clipboard_to_unnamed()
    return '""' . a:p
endfunction

function! s:ctrl_r(cr)
    call s:clipboard_to_unnamed()
    return a:cr . '"'
endfunction

nnoremap <expr> <silent> "+p <SID>put('p', v:false)
nnoremap <expr> <silent> "+P <SID>put('P', v:false)
nnoremap <expr> <silent> p <SID>put('p', &clipboard !~ 'unnamedplus')
nnoremap <expr> <silent> P <SID>put('P', &clipboard !~ 'unnamedplus')

vnoremap <expr> <silent> "+p <SID>put('p', v:false)
vnoremap <expr> <silent> "+P <SID>put('P', v:false)
vnoremap <expr> <silent> p <SID>put('p', &clipboard !~ 'unnamedplus')
vnoremap <expr> <silent> P <SID>put('P', &clipboard !~ 'unnamedplus')

inoremap <expr> <silent> <C-R>+ <SID>ctrl_r("\<C-R>")
inoremap <expr> <silent> <C-R><C-R>+ <SID>ctrl_r("\<C-R>\<C-R>")
inoremap <expr> <silent> <C-R><C-O>+ <SID>ctrl_r("\<C-R>\<C-O>")
inoremap <expr> <silent> <C-R><C-P>+ <SID>ctrl_r("\<C-R>\<C-P>")

" }}}
