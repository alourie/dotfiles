" Leader is king
" Remap leader
let mapleader=","


" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Auto pairs, only pick one
Plug 'jiangmiao/auto-pairs'

" Colour themes
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'

" Colouriser
Plug 'norcalli/nvim-colorizer.lua'

" Tree
" Plug 'nvim-treesitter/nvim-treesitter'

" Emmet
Plug 'mattn/emmet-vim'

" Generic stuff/control
" Git improver. I'm using git from cli mostly, so consider removing
Plug 'tpope/vim-fugitive'
" Surround sections with other things
Plug 'tpope/vim-surround'
" Repeat last commands, not just edits
Plug 'tpope/vim-repeat'
" Session management
Plug 'tpope/vim-obsession'
" Comment shit out
Plug 'tpope/vim-commentary'
" Nerdtree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
" ChadTree
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
"Ctrl-P
"Plug 'kien/ctrlp.vim'
"FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Syntastic
Plug 'vim-syntastic/syntastic'
" Use :Ack from vim
Plug 'mileszs/ack.vim'
" Wakatime stats
Plug 'wakatime/vim-wakatime'
" Formatter, i.e. for prettier, black, etc
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
" Plug 'prettier/vim-prettier', {'do': 'yarn install'}
" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Multiple cursor
Plug 'terryma/vim-multiple-cursors'
" Improve shit in VTE-based terminals
" Plug 'wincent/terminus'

" Distraction free
Plug 'junegunn/goyo.vim'

"Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'davidhalter/jedi-vim'

"Unite buffers for all vim sessions, have to run vim in a server mode, i.e.
" alias vim="vim --servername personal"
" unfortunately, neovim doesn't support server mode, so off for now.
" Plug 'ardagnir/united-front'

" Minibuffer, currently off, replaced by airline. See config.
" Plug 'fholgado/minibufexpl.vim'


" Supposedly overridden by COC
" Plug 'fs111/pydoc.vim'
" Plug 'vim-scripts/taglist.vim'
" Plug 'nvie/vim-flake8'
" Plug 'hynek/vim-python-pep8-indent'
" Plug 'Valloric/YouCompleteMe'

" Tasklist, for TODOs? Haven't used for a while, so off for now
" Plug 'vim-scripts/TaskList.vim'

"""""" Languages
" Svelte
"Plug 'evanleck/vim-svelte'
Plug 'leafOfTree/vim-svelte-plugin'

" Js/Typescript
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'

" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'

" Ruby, currenty off
" Plug 'vim-ruby/vim-ruby'

" Groovy, currently off
" Plug 'vim-scripts/groovy.vim'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rjohnsondev/vim-compiler-go'

" Scala
" Plug 'derekwyatt/vim-scala'

" Terraform, currently off
" Plug 'hashivim/vim-terraform'
" Plug 'juliosueiras/vim-terraform-completion'

" Jenkins, currently off
" Plug 'martinda/Jenkinsfile-vim-syntax'

" Supposedly overridden by COC
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

call plug#end()


" Conflicting with AL
"Plug 'dense-analysis/ale'


" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

