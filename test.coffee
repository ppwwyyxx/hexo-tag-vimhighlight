# File: test.coffee
# Date: Sun Aug 11 13:33:46 2013 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>


vimhl = require('./vimhl').vimHighlight

test = """
filetype off            " haha
if isdirectory($HOME . "/.vim/bundle/accelerated-jk")        " a variable not assigned
    nmap j <Plug>(accelerated_jk_gj)
    nmap k <Plug>(accelerated_jk_gk)
endif
let g:accelerated_jk_acceleration_limit = 500
let g:accelerated_jk_acceleration_table = [10, 20, 30, 35, 40, 45, 50]

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <c-l> $
nnoremap <c-h> 0
imap <c-h> <Left>
imap <c-j> <Down>
imap <c-k> <Up>
imap <c-l> <Right>
imap <c-e> <End>
imap <c-d> <Home>
inoremap <c-b> <S-Left>
inoremap <a-f> <S-Right>
inoremap <a-b> <S-Left>
cmap <c-j> <Down>
cmap <c-k> <Up>
cmap <c-h> <Left>
cmap <c-l> <Right>
cmap <a-f> <S-Right>
cmap <c-b> <S-Left>
cmap <a-b> <S-Left>
cmap <c-e> <End>
cmap <c-d> <Home>
" undoable C-U, C-W
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
"vnoremap << <gv<gv
"vnoremap >> >gv>gv
" Save Cursor Position:
au BufReadPost *
           \ if line("'\"") > 0 && line("'\"") <= line("$") |
           \   exe "normal g`\"" |
           \ endif
" Hint On Moving Cursor:
func HintCursorLine(opr)
    if a:opr == 0            " clear cursorline
        set nocursorline
        if exists("&cc") | set cc= | endif
        return
    endif

    if ! exists('g:last_line') | let g:last_line = -1 | end
    if ! exists('g:last_pos')  | let g:last_pos  = -1 | end
    if ! exists('g:last_win')  | let g:last_win  = -1 | end
    let cur_pos  = winline()
    let cur_line = line(".")
    let diff = max([ abs(g:last_line - cur_line), abs(g:last_pos - cur_pos) ])
    if g:last_win != winnr() || diff > 3
        set cursorline
    endif
    let g:last_pos  = cur_pos
    let g:last_line = cur_line
    let g:last_win  = winnr()
endfunc
"""

console.log(vimhl test, 'vim')
