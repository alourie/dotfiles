" For some reason home and end keys are not mapping properly.
" Home key
imap <esc>OH <esc>0i
cmap <esc>OH <home>
nmap <esc>OH 0
imap <esc>[1~ <esc>0i
cmap <esc>[1~ <home>
nmap <esc>[1~ 0
" "" End key
nmap <esc>OF $
imap <esc>OF <esc>$a
cmap <esc>OF <end>
nmap <esc>[4~ $
imap <esc>[4~ <esc>$a
cmap <esc>[4~ <end>

" Remap leader
let mapleader=","


" Better shifting
vnoremap < <gv
vnoremap > >gv
vmap <C-_> gc

" Set/unset line numbers
nnoremap <Leader>n :set number!<CR>
" Show hidden chars
nnoremap <Leader>l :set list!<CR>
" Delete current buffer from the list
nnoremap <Leader>d :bdelete<CR>
" exit immediately
nnoremap <Leader>q :qall!
" goyo
nnoremap <Leader>g :Goyo<CR>
" next/prev buffers
" nnoremap <M-]> :bnext<CR>
" nnoremap <M-[> :bprev<CR>
nnoremap <M-]> :bnext<CR>
nnoremap <M-[> :bprev<CR>

" Todo list toggle
nnoremap <Leader>t :TlistToggle<CR>
" NerdTree toggle
nnoremap <Leader>N :NERDTreeToggle<CR>
"nnoremap <F8> :PyLint<CR> -- conflicts with byobu

" Just fix common mistypes
nnoremap :W :w
nnoremap :Q :q

" Remap pageup/pagedown
nnoremap <PAGEUP> <C-u>
nnoremap <PAGEDOWN> <C-d>

" Better window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

" Better window resize
nnoremap <M-j> :resize -2<cr>
nnoremap <M-k> :resize +2<cr>
nnoremap <M-l> :vertical resize -2<cr>
nnoremap <M-h> :vertical resize +2<cr>

" Golang stuff, currently off
" map <Leader>a :GoAlternate<CR>
" map <Leader>. :GoDeclsDir<CR>
"
" Emmet
let g:user_emmet_leader_key='<TAB>'

" FZF
nnoremap <C-p> :<C-u>FZF<CR>
