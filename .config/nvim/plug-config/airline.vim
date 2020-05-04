" status line
" set laststatus=2

" Airline stuff
let g:airline_theme='nord'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = 'LF'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = 'BR: '
let g:airline_symbols.paste = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = ''
let g:airline#extensions#obsession#enabled = 1
" Tabline, replaces MiniExplorer
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '

