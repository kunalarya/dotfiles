"
" Kunal's .vimrc
"
" NOTE TO SELF: to change to current directory, use :cd %:p:h
"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
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
   colors kunal_win
   " Start maximized
   " Use ~x on an English Windows version or ~n for French.
   au GUIEnter * simalt ~x
else
    " do colors later, after loading Pathogen
endif

" Don't use Ex mode, use Q for formatting
map Q gq
imap jj <Esc>

" Navigating windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" This is for turning off highlight searches, from tip #1, by Zdenek Sekera
nnoremap <CR> :nohlsearch<CR>/<BS><CR>

" Tab stuff: (from tip 1313, jul)
if version >= 700
   set guitablabel=%N\ %t\ %M
   let g:toggleTabs = 0
   "when pressing F3, open all buffer in tabs / close all tabs
   map <silent><F3> :if g:toggleTabs == 1<CR>:tabo<CR>:set lines+=3<CR>:let g:toggleTabs = 0<CR>:else<CR>:set lines-=3<CR>:tab ball<CR>:let g:toggleTabs = 1<CR>:endif<CR>

   " tab navigation (next tab or next buffer) (firefox style)
   map <silent><C-tab> :if g:toggleTabs == 1<CR>:tabnext<CR>:else<CR>:bn<CR>:endif<CR>
   map <silent><C-S-tab> :if g:toggleTabs == 1<CR>:tabprevious<CR>:else<CR>:bp<CR>:endif<CR>
   "Show tabs by pressing alt down, hide tabs by pressing alt up
   map <A-Up> :tabo<CR>:set lines+=3<CR>:let g:toggleTabs = 0<CR>:simalt ~x<CR>
   map <A-Down> :set lines-=3<CR>:tab ball<CR>:let g:toggleTabs = 1<CR>:simalt ~x<CR>

   " tab navigation (next tab or next buffer) with alt left / alt right
   map <silent><A-Right> :if g:toggleTabs == 1<CR>:tabnext<CR>:else<CR>:bn<CR>:endif<CR>
   map <silent><A-Left> :if g:toggleTabs == 1<CR>:tabprevious<CR>:else<CR>:bp<CR>:endif<CR>

endif

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

" BufExplorer options
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSplitOutPathName=0  " Don't split the path and file
                                       " name.
" \\ will quickly bring up the buffers
map \\ \be

" \c will set the current directory to the same one
" as the active buffer.
map \c :cd %:p:h<CR>

source $VIMRUNTIME/macros/matchit.vim

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
au BufRead,BufNewFile *.hx set filetype=haxe

"map <leader>p :set paste!<cr>
map <leader>p "+p
map <leader>y "+y

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

" Pathogen
execute pathogen#infect()
call pathogen#helptags()

if !has("gui_running")
    colors 256_asu1dark "tchaba2
endif

" python folding
"au BufRead,BufNewFile *.py set foldmethod=indent
"au BufRead,BufNewFile *.py set foldnestmax=3

" SimpylFold options
"let g:SimpylFold_docstring_preview = 1
" Might need this:
"autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
"autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
"
" Disable folding for python files (slow and useless)
au BufRead,BufNewFile *.py set foldmethod=manual
au BufRead,BufNewFile *.py set nofoldenable

" remap space to fold/unfold
nnoremap <space> za
vnoremap <space> zf

set runtimepath^=~/vimfiles/bundle/ctrlp.vim

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
"let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  "let g:ctrlp_user_command = 'ag -l --nocolor --ignore *.pyc --ignore */*.pyc --ignore *~ --ignore */*~ --ignore *.swp --ignore */*.swp -g "" %s'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

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
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" now map \/ to recursive search
nnoremap <leader>/ :Ag<space>

" quick and easy search+replace with \r
noremap \r :%s///g<Left><Left>
vnoremap \r :s///g<Left><Left>

" Shortcut for the Tabularize plugin (which will align text horizontally)
map \t :Tabularize /

" powerline use patched fonts
let g:airline_powerline_fonts = 1

" EasyMotion
"
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" start easymotion
" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" " `s{char}{label}`
" nmap t <Plug>(easymotion-overwin-f)

"map <Leader>w <Plug>(easymotion-bd-w)

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
map \fw :%s/ \+$//g<cr>

autocmd FileType scala let &colorcolumn=join(range(101,999),",")
autocmd FileType scala highlight ColorColumn ctermbg=234


" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" YCM goto definition shortcut
nnoremap <leader>gd :YcmCompleter GoTo<CR>
" Go to all references
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>

" Ensure we don't have that preview pop-up window.
set completeopt-=preview

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

highlight ColorColumn ctermbg=234
