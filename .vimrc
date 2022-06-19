"
" Kunal's .vimrc
"
set nocompatible

" Make it so that vim hides buffers by default instead of closing them
set hidden

" Enable 256 colors
set t_Co=256

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif

set history=100     " keep 100 lines of command line history
set undolevels=1000 " keep 100 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set shiftwidth=4
set shiftround      " use multiples of shiftwidth with < and >
set expandtab
set tabstop=4
set nowrap
set number
set makeprg=gmake
set showmatch     " show matching parens

" Turn off beeps
set novisualbell
set noerrorbells

" Tell vim not to search included files for autocomplete
set complete-=i

" Ignore certain filetypes
set wildignore=*.git,*.bak,*.pyc,*.swp,*.swp,*~
" Tell the netrw file browser to ignore *.swp, *~, and *.pyc files
let g:netrw_list_hide='.*\.swp$,.*\.pyc$,.*\~$'

" Allow vim to grab the mouse
set mouse=a

if has("gui_running")
   set guifont=Roboto\ Mono\ 9
   " Start maximized
   " Use ~x on an English Windows version or ~n for French.
   au GUIEnter * simalt ~x
endif

" Don't use Ex mode, use Q for formatting
map Q gq
inoremap jj <Esc>

" Navigating windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" This is for turning off highlight searches, from tip #1, by Zdenek Sekera
nnoremap <CR> :nohlsearch<CR>/<BS><CR>
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Always show filename bar at the bottom
set laststatus=2

" Show a nice horizontal menu for command completion
set wildmenu
" Have it auto-compete to the longest prefix, then show the menu on second tab
set wildmode=longest:full,full

" Show at least 2 line(s) +/- the current cursor
set scrolloff=2
set sidescrolloff=5

if v:version > 703 || v:version == 703 && has("patch541")
set formatoptions+=j " Delete comment character when joining commented lines
endif

" -- vim-plug Setup --
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'noah/vim256-color'
Plug 'danro/rename.vim'
Plug 'derekwyatt/vim-scala'
Plug 'jceb/vim-orgmode'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

" BufExplorer options
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSplitOutPathName=0  " Don't split the path and file
                                       " name.
" \\ will quickly bring up the buffers
map <Leader>\ <Leader>be

" \c will set the current directory to the same one
" as the active buffer.
map <Leader>c :cd %:p:h<CR>

" Make a simple "search" text object.
" From Vim Tip 1597: http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" mainly for Python syntax highlighting
let python_highlight_numbers = 1
let python_highlight_builtins = 1

" Override .md files for markdown not modula2
au BufRead,BufNewFile *.md set filetype=markdown

" Useful copy/paste
map <Leader>p "+p
map <Leader>y "+y

" Force it to use external diff program
set diffexpr=
" Have diff ignore whitespace
set diffopt+=iwhite

" Always start in C:\Dev\
cd %:p:h


" Search the modeline to be anywhere in the file (well, the first 10K lines)
set modelines=10000

" Associate TSP scripts with LUA syntax
au BufRead,BufNewFile *.tsp setfiletype lua

" SCons
au BufRead,BufNewFile SConstruct setfiletype python

" Disable folding for python files (slow and useless)
au BufRead,BufNewFile *.py set foldmethod=manual
au BufRead,BufNewFile *.py set nofoldenable

" remap space to fold/unfold
nnoremap <space> za
vnoremap <space> zf

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
"let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  "set grepprg='ag --nogroup --nocolor'
  "let &grepprg='ag --nogroup --nocolor ' . shellescape(&wildignore) . ' $*'
  "let agcmd='ag --vimgrep --ignore *.pyc --ignore */*.pyc --ignore *~ --ignore */*~ --ignore *.swp --ignore */*.swp $*'
  let agcmd='ag --nogroup --nocolor --ignore "*~" '
  let &grepprg=agcmd.'$*'
  "set grepprg=ag\ --vimgrep\ ignore?\ $*

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  "let g:ctrlp_user_command = 'ag -l --nocolor --ignore *.pyc --ignore */*.pyc --ignore *~ --ignore */*~ --ignore *.swp --ignore */*.swp -g "" %s'
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore *.pyc --ignore */*.pyc --ignore *~ --ignore */*~ --ignore *.swp --ignore */*.swp -g ""'
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  let g:ctrlp_custom_ignore = '~$|pyc$|swp$'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " enable line searching
  "let g:ctrlp_map = '<c-p>'
  "let g:ctrlp_cmd = 'CtrlPLastMode'
  "let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" create the Ag editor command to allow custom ag searches
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
command! -nargs=? -complete=file -bar CB silent! !cargo build <args>|cwindow|redraw!

" now map \/ to recursive search
nnoremap <Leader>/ :Ag<Space> ''<Left>

" quick and easy search+replace with \r
noremap <Leader>r :%s///g<Left><Left>
vnoremap <Leader>r :s///g<Left><Left>

" Shortcut for the Tabularize plugin (which will align text horizontally)
map <Leader>t :Tabularize /

" powerline use patched fonts
let g:airline_powerline_fonts = 1

" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" \h and \l for word motions
map <Leader>h <Plug>(easymotion-b)
map <Leader>l <Plug>(easymotion-w)


" map \fw to "Fix Whitespace" at newlines
" -- e.g. replace all trailing whitespace
map <Leader>fw :%s/ \+$//g<cr>

autocmd FileType scala let &colorcolumn=join(range(101,999),",")
autocmd FileType scala highlight ColorColumn ctermbg=234

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" rust support in YCM
let g:ycm_rust_src_path = '/Users/kunal/build/rust/src'

" YCM goto definition shortcut
nnoremap <Leader>gd :YcmCompleter GoTo<CR>
" Go to all references
nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>

" Ensure we don't have that preview pop-up window.
set completeopt-=preview

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

highlight ColorColumn ctermbg=234

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Color scheme
" colors 256_asu1dark
"
colors jellybeans
hi VertSplit ctermfg=242 ctermbg=242
hi Search ctermfg=250 ctermbg=126


command! Cb :make build

map <Leader>bu :make build<cr>
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
