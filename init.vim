"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> Customizations
"    -> Plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" it deletes everything until the last slash 
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Map ½ to something useful
map ½ $
cmap ½ $
imap ½ $

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.config/nvim/tempdirs/undodir
    set undofile
catch
endtry

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "
let g:mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2
set shiftround

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Customizations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map ESC to jk
inoremap jk <esc>
" map ESC and save to jkl
inoremap jkl <esc>:w<cr>
" map ESC, save and quit to jkl;
inoremap jkl; <esc>:wq<cr>
" map ESC, save and quit to jklö
inoremap jklö <esc>:wq<cr>
" map ESC and quit without saving to ;lkj
inoremap ;lkj <esc>:q!<cr>
" map ESC and quit without saving to ölkj
inoremap ölkj <esc>:q!<cr>
" new line below current in normal mode
nnoremap <S-Enter> O<Esc>
" new line above current in normal mode
nnoremap <CR> o<Esc>
" show row numbers
set number
" Make it obvious where 80 characters is
if exists('+colorcolumn')
  set textwidth=80
  set colorcolumn=+1
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif
" don't let comments in when pasting
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" display incomplete commands
set showcmd
" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
" Switch between the last two files
nnoremap <Leader><Leader> <c-^>
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" when pasting
set pastetoggle=<F10>
" live substitute
set inccommand=nosplit
" Point to the Python executables
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3.6'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins (Vim-Plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" UI
"Plug 'trevordmiller/nova-vim'
"Plug 'vim-airline/vim-airline'            " Handy info
"Plug 'retorillo/airline-tablemode.vim'
""Plug 'edkolev/tmuxline.vim'               " Make the Tmux bar match Vim
""Plug 'ryanoasis/vim-webdevicons'
"Plug 'machakann/vim-highlightedyank'
Plug 'altercation/vim-colors-solarized' 
Plug 'junegunn/goyo.vim'
Plug 'itchyny/lightline.vim'

" Project Navigation
""Plug 'junegunn/fzf',                      { 'dir': '~/.fzf', 'do': './install --all' }
""Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
""Plug 'vim-scripts/ctags.vim'              " ctags related stuff
""Plug 'majutsushi/tagbar'

" File Navigation
""Plug 'vim-scripts/matchit.zip'            " More powerful % matching
""Plug 'Lokaltog/vim-easymotion'            " Move like the wind!
Plug 'jeffkreeftmeijer/vim-numbertoggle'  " Smarter line numbers
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'amix/open_file_under_cursor.vim'
""Plug 'wellle/targets.vim'
""Plug 'kshenoy/vim-signature'
Plug 'haya14busa/incsearch.vim'           " Better search highlighting

" Editing {{{3
Plug 'tpope/vim-surround'                 " Change word surroundings
Plug 'tpope/vim-commentary'               " Comments stuff
""Plug 'tpope/vim-repeat'
""Plug 'dhruvasagar/vim-table-mode',        { 'on': 'TableModeEnable' }
""Plug 'kana/vim-textobj-user'
""Plug 'sgur/vim-textobj-parameter'
""Plug 'jasonlong/vim-textobj-css'
""Plug 'Konfekt/FastFold'
""Plug 'editorconfig/editorconfig-vim'

" Git
""Plug 'tpope/vim-fugitive'                 " Git stuff in Vim
""Plug 'airblade/vim-gitgutter'
""Plug 'junegunn/gv.vim',                   { 'on': 'GV' }
""Plug 'jez/vim-github-hub'

" Task Running
""Plug 'tpope/vim-dispatch'                 " Run tasks asychronously in Tmux
Plug 'w0rp/ale'                           " Linter
""Plug 'wincent/terminus'
""Plug 'christoomey/vim-tmux-navigator'
""Plug 'Olical/vim-enmasse'                 " Edit all files in a Quickfix list
""Plug 'janko-m/vim-test'

" Autocomplete {{{3
Plug 'Shougo/deoplete.nvim',              { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ternjs/tern_for_vim',               { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs',          { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim',                   { 'for': ['javascript', 'javascript.jsx'] }
""Plug 'zchee/deoplete-jedi'
""Plug 'alexlafroscia/deoplete-flow',       { 'branch': 'pass-filename-to-autocomplete' }
"Plug 'wokalski/autocomplete-flow'
" For func argument completion
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'

" Language Support {{{3
" JavaScript {{{4
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Plug 'rhysd/npm-debug-log.vim'
"Plug '~/projects/vim-plugins/vim-ember-cli'
"Plug 'AndrewRadev/ember_tools.vim'
Plug 'neovim/node-host',                  { 'do': 'yarn install' }

" TypeScript {{{4
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript',       { 'do': ':UpdateRemotePlugins' }

" Elm {{{4
""Plug 'ElmCast/elm-vim'

" HTML {{{4
Plug 'othree/html5.vim',                  { 'for': 'html' }
Plug 'mustache/vim-mustache-handlebars'
Plug 'mattn/emmet-vim'

" CSS {{{4
Plug 'hail2u/vim-css3-syntax',            { 'for': 'css' }

" Sass {{{4
Plug 'cakebaker/scss-syntax.vim'

" Ruby {{{4
"Plug 'vim-ruby/vim-ruby',                 { 'for': 'ruby' }
"Plug 'tpope/vim-rails'
"Plug 'tpope/vim-bundler'
"Plug 'tpope/vim-endwise'

" Python {{{4
"Plug 'klen/python-mode',                  { 'for': 'python' }
"Plug 'davidhalter/jedi-vim',              { 'for': 'python' }
"Plug 'alfredodeza/pytest.vim',            { 'for': 'python' }

" Rust {{{4
"Plug 'wellbredgrapefruit/tomdoc.vim',     { 'for': 'ruby' }
"Plug 'wting/rust.vim'
"Plug 'cespare/vim-toml'

" Go {{{4
"Plug 'fatih/vim-go'
"Plug 'nsf/gocode',                        { 'rtp': 'nvim', 'do': './nvim/symlink.sh' }
"Plug 'zchee/deoplete-go'

" Markdown {{{4
Plug 'reedes/vim-pencil'                  " Markdown, Writing
Plug 'godlygeek/tabular',                 { 'for': 'markdown' } " Needed for vim-markdown
Plug 'plasticboy/vim-markdown',           { 'for': 'markdown' }

" Elixir {{{4
"Plug 'elixir-editors/vim-elixir'
"Plug 'slashmili/alchemist.vim'

call plug#end()

" Load plugin configurations {{{2
" For some reason, a few plugins seem to have config options that cannot be
" placed in the `plugins` directory. Those settings can be found here instead.


" Normal Mode Remaps {{{2

" Quickly find file in NERDTree
"nnoremap <leader>f :NERDTreeFind<CR>

"nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Smarter pasting
nnoremap <Leader>p :set invpaste paste?<CR>

" -- Smart indent when entering insert mode with i on empty lines --------------

" Tab Shortcuts
nnoremap tk :tabfirst<CR>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tj :tablast<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :CtrlSpaceTabLabel<CR>
nnoremap td :tabclose<CR>

if filereadable($DOTFILES . "/nvim/init.local.vim")
  source $DOTFILES/nvim/init.local.vim
endif

set background=dark
colorscheme solarized


" PLUGIN CONFIGS

" Omnifunc settings for autocomplete
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

" Deoplete sources for autocomplete
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['member', 'file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:deoplete#sources#ternjs#types = 1

" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1

" Tab for everthing except UltiSnips which uses C-j
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Ale
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'html': []
\}

let g:ale_fixers = {
\   'javascript': ['eslint']
\}

nmap <leader>d <Plug>(ale_fix)

" tern

let g:tern_show_argument_hints = 'on_move'

autocmd FileType javascript nnoremap <S-k> :TernDoc<CR>

" vim-javascrip
" Enable JSDoc highlighting
let g:javascript_plugin_jsdoc = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
"   let g:deoplete#enable_ignore_case = 1
"   let g:deoplete#enable_smart_case = 1
"   let g:deoplete#enable_camel_case = 1
"   let g:deoplete#enable_refresh_always = 1
"   let g:deoplete#max_abbr_width = 0
"   let g:deoplete#max_menu_width = 0
"   let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
"   call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
"
"   let g:tern_request_timeout = 1
"   let g:tern_request_timeout = 6000
"   let g:tern#command = ["tern"]
"   let g:tern#arguments = ["--persistent"]
"   let g:deoplete#sources#tss#javascript_support = 1

" Deoplete ternjs
let g:deoplete#sources#ternjs#timeout = 1

" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and 
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some 
" heuristics to try and return some properties anyway. Set this to 0 to 
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 0

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of 
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been 
" spelled out by at least two characters. Default: 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not 
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

" If completions should be returned when inside a literal. Default: 1
let g:deoplete#sources#ternjs#in_literal = 0


"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]

"If you are using tern_for_vim, you also want to use the same tern command with deoplete-ternjs

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]"   let g:tsuquyomi_javascript_support = 1
"   let g:tsuquyomi_auto_open = 1
"   let g:tsuquyomi_disable_quickfix = 1

