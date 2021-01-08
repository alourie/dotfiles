" Python-specific stuff
autocmd FileType python set cc=120
autocmd FileType python set commentstring=#\ %s

" Terraform-specific stuff
autocmd BufWritePre *.tf :TerraformFmt

" Go stuff
"autocmd FileType go autocmd BufWritePre <buffer> GoFmt
autocmd FileType go compiler golang

" HTML/CSS/JS stuff
autocmd FileType html set tabstop=2
autocmd FileType html set shiftwidth=2
autocmd FileType css set tabstop=2
autocmd FileType css set shiftwidth=2

" Remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" TypeScript
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" FORMATTERS
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

" Highlighter
autocmd CursorHold * silent call CocActionAsync('highlight')

filetype indent on
filetype plugin on

set nocompatible
set termguicolors
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set shell=zsh


" general stuff
syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=1                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number                              " Line numbers
" set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nofoldenable                        " Don't fold on start
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=600                      " Faster completion
set timeoutlen=400                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set ignorecase                          " Ignore case in searches
set smartcase                           " Switch to case-sensitive is upper case used in a search
set history=100                         " History of searches and : commands
set shiftround                          " Round ident (>, <) to shiftwidth multiples
set listchars+=eol:¬                    " Show hidden chars in list mode
set completeopt=menuone,longest,preview " How to show popup menu in completions
set undofile                            " Use undo files
"set autochdir                           " Your working directory will always be the same as your working directory

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

" You can't stop me
cmap w!! w !sudo tee %

" Colors are set here
set background=dark
colorscheme nord

set guifont=JetBrains\ Mono-16

" " YCM
" let g:ycm_auto_trigger = 1

" Stuff that goes nowhere else
" " Jedi stuff
" let g:jedi#use_tabs_not_buffers = 0
" let g:jedi#popup_on_dot = 0
" let g:jedi#popup_select_first = 0
" let g:jedi#goto_definition_command = "<leader>g"


" GoLang
" " use goimports for formatting
let g:go_fmt_command = "goimports"
" " turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

