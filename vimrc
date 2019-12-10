" Make vundle work
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" misc
Plugin 'MarcWeber/vim-addon-mw-utils.git'
Plugin 'tomtom/tlib_vim.git'
Plugin 'gmarik/vundle.git'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'majutsushi/tagbar.git'
Plugin 'thaerkh/vim-indentguides'
Plugin 'itchyny/vim-gitbranch'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'

" themes
Plugin 'dracula/vim.git'
Plugin 'morhetz/gruvbox.git'
Plugin 'twerth/ir_black.git'
Plugin 'NLKNguyen/papercolor-theme.git'
Plugin 'gosukiwi/vim-atom-dark.git'
Plugin 'liuchengxu/space-vim-dark.git'
Plugin 'joshdick/onedark.vim'
Plugin 'whatyouhide/vim-gotham.git'
Plugin 'rakr/vim-one'
Plugin 'junegunn/seoul256.vim.git'
Plugin 'arzg/vim-substrata'

" editing,completion and linting
Plugin 'jiangmiao/auto-pairs.git'
Plugin 'docunext/closetag.vim'
Plugin 'tommcdo/vim-lion.git'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround.git'
Plugin 'honza/vim-snippets.git'
Plugin 'SirVer/ultisnips.git'
Plugin 'neoclide/coc.nvim'

" language specific
Plugin 'ap/vim-css-color.git'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'hdima/python-syntax.git'
Plugin 'mxw/vim-jsx.git'
Plugin 'noprompt/vim-yardoc'
Plugin 'leafgarland/typescript-vim.git'
Plugin 'epilande/vim-react-snippets'
Plugin 'jelera/vim-javascript-syntax.git'
Plugin 'crusoexia/vim-javascript-lib.git'

" git
Plugin 'tpope/vim-fugitive.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'rhysd/conflict-marker.vim'

" Preferences...................................................................
filetype plugin indent on
syntax on
runtime macros/matchit.vim          " use % to jump to matching tags
set mouse=a                         " add mouse support
set viminfo='51,<1000,s100,h        " increase maximum number of lines to yank
set wrap linebreak nolist           " wrap whole words instead of characters
set display+=lastline               " display long lines on same screen
set smartcase                       " case sensitive if search expression \
                                    " includes an uppercase character
set ignorecase                      " do case insensitive search
set number                          " show line numbers
set relativenumber                  " show relative line numbers
set breakindent                     " wrap preserving the indent
set title                           " show title on file opened
set cursorline                      " highlight current line
set scrolloff=3                     " show 3 lines before/after current line
set nohlsearch                      " turn off search highlight
set incsearch                       " jump to search results while typing
"set spell spelllang=en_us          " check spelling
set splitbelow                      " horizontal split window to bottom
set splitright                      " vertical split window to right
set incsearch                       " highlight next search
set timeoutlen=1000 ttimeoutlen=0   " remove keyboard delay
set foldmethod=manual               " **insert redundent comment here**
set synmaxcol=200                   " prevent vim from dying when line length \
                                    " is too long

" Only for neovim
if has('nvim')
    set inccommand=split
endif

" set indention and tab stuff
set ts=4                            " show existing tabs with 4 spaces
set sw=4                            " use 4 spaces when useing '>'
set expandtab                       " on pressing tab, insert 4 spaces
set softtabstop=4                   " backspace behavior on space indents 

" Enable true color
" set termguicolors " Enable true color support.
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Set theme.....................................................................
function! Set_colorscheme()
    colorscheme PaperColor
    set background=dark
endfunction

" Function to highlight lines 81 and 121
function! Highlight_columns()
    highlight ColorColumn ctermbg=235 guibg=#2c2d27
    let &colorcolumn='81,121'
endfunction

" Note: transparancy is dependent on the terminal emulator, this function
" simply removes vim's background.
function! Make_transparent()
    let t:is_transparent = 1
    highlight Normal guibg=NONE ctermbg=NONE
    call Highlight_columns()
endfunction

function! Make_opaque()
    let t:is_transparent = 0
    call Set_colorscheme()
    call Highlight_columns()
endfunction

call Make_opaque()
"/..............................................................................

" Toggle transparent background.................................................
function! Toggle_transparent()
    if t:is_transparent == 0
        call Make_transparent()
    else
        call Make_opaque()
    endif
endfunction

nnoremap <C-t> : call Toggle_transparent()<CR>
"/..............................................................................


" Remaps........................................................................
" folding inside braces
nnoremap Zf vi{zf

" cycle through splits
nnoremap <Tab><Tab> <C-w>=<C-w><C-w>
nnoremap <Tab>h <C-w><C-h>
nnoremap <Tab>l <C-w><C-l>
nnoremap <Tab>j <C-w><C-j>
nnoremap <Tab>k <C-w><C-k>

" make split occupy all vertical space
nnoremap <Tab><Leader> <C-w>\|
" make split occupy all horizonal space
nnoremap <Tab>- <C-w>_
" all splits occupy equal space
nnoremap <Tab>= <C-w>=

" common typos
command W w
command Wq wq
command WQ wq
command Q q

nnoremap <C-b> :TagbarToggle<CR>

" nerdtreefind, open nerdtree with path to current file expanded.
function MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction
inoremap <C-f> <Esc>:call MyNerdToggle()<CR>
nnoremap <C-f> <Esc>:call MyNerdToggle()<CR>

" moving lines
nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv
" inoremap <C-J> <Esc>:m .+1<CR>==gi
" inoremap <C-K> <Esc>:m .-2<CR>==gi

" remap yanking to system clipboard
vnoremap <C-c> "+y

" remap pasting to system clipboard
vnoremap <C-p> "+p
nnoremap <C-p> "+p
inoremap <C-v> <Esc>"+pa

" select all
nnoremap <C-a> ggvG$

" if syntax highlighting gets messed up, usually on larger files
noremap <F5> <Esc>:syntax sync fromstart<CR>

" remap save
nnoremap <C-u> <Esc>:up<CR> :echo 'saved' <CR>
inoremap <C-u> <Esc>:up<CR> :echo 'saved' <CR>

" close scratch
inoremap <C-c> <Esc>:pclose<CR>a
nnoremap <C-c> <Esc>:pclose<CR>
"/..............................................................................

" UltiSnips Stuff...............................................................
" Change ultisnips triggers, because fuck YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
"/..............................................................................


" Python Specific Stuff.........................................................
" Highlight 'self'.
augroup python
    autocmd!
    autocmd FileType python
                \   syn keyword pythonSelf self
                \ | highlight def link pythonSelf Special
augroup end
let python_highlight_all=1
"/..............................................................................

" Ruby Specific Stuff...........................................................
augroup ruby
    autocmd!
    autocmd FileType html,xml,js,eruby,ruby,erb
                \ set ts=2           " show existing tabs with 2 spaces
                \ set sw=2           " use 2 spaces when useing '>'
                \ set expandtab      " on pressing tab, insert 2 spaces
                \ set softtabstop=2  " backspace behavior on space indents 
augroup end
"/..............................................................................

" JavaScript Specific Stuff.....................................................
let g:jsx_ext_required = 0
"/..............................................................................

" Lightline configurations..............................................
" needed for lightline
set laststatus=2
" config lightline
let g:lightline = {
            \    'colorscheme': 'seoul256',
            \    'active': {
            \      'left': [ [ 'mode', 'paste' ],
            \                [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
            \      'right':  [ [ 'lineinfo' ],
            \                 [ 'percent' ],
            \                 [ 'linter_warnings', 'linter_errors', 'linter_ok' ],
            \                 [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \    },
            \    'component_function': {
            \      'gitbranch': 'fugitive#head'
            \    },
            \ }
"/..............................................................................

"GUI Specific Configs...........................................................
" remove menu, tool and scroll bars for gvim
if has('gui_running')
    set guioptions-=m               "menu bar
    set guioptions-=T               "toolbar
    set guioptions-=r               "scrollbar
endif
"/..............................................................................

" Update GitGutter on save
autocmd BufWritePost * GitGutter

" Disable characters (json and markdown files)
let g:indentguides_ignorelist = ['json', 'markdown']
autocmd FileType json set conceallevel=0
autocmd FileType markdown set conceallevel=0

let g:indentguides_spacechar = '⎸' " 'LEFT VERTICAL BOX LINE' (U+23B8)


function! MakeSessionGitBranch()
    execute 'NERDTreeClose'
    let l:command=substitute('mksession!  session_'.fugitive#head(), "/", "-", "").'.vim'
    execute l:command
    echo l:command
endfunction

function! RetrieveSessionGitBranch()
    let l:command=substitute('source session_'.fugitive#head(), "/", "-", "").'.vim'
    execute l:command
    echo l:command
endfunction

command Ms :call MakeSessionGitBranch()
command Rs :call RetrieveSessionGitBranch()

" Strip leading whitespaces on save
autocmd FileType c,cpp,java,php,ruby,python,javascript autocmd BufWritePre <buffer> %s/\s\+$//e

" coc settings..................................................................
" From: http://blog.jamesnewton.com/setting-up-coc-nvim-for-ruby-development
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_global_extensions = ['coc-solargraph']
let g:coc_global_extensions = ['coc-python']
let g:coc_global_extensions = ['coc-lists']

" Jump to definition
nmap gd <Plug>(coc-definition)
" nmap <silent> gd <Plug>(coc-definition)

let g:coc_user_config = {}
let g:coc_user_config['solargraph.diagnostics'] = 'true'
let g:coc_user_config['solargraph.autoformat'] = 'true'
let g:coc_user_config['solargraph.formatting'] = 'true'
let g:coc_user_config['solargraph.hover'] = 'true'
let g:coc_user_config['python.jediEnabled'] = 'true'
"/..............................................................................
"
" Fuzzy find with coc-lists.....................................................
nnoremap <C-o> :CocList files<CR>
nnoremap <C-m> :CocList mru<CR>
nnoremap <C-w> :CocList grep<CR>
"/..............................................................................

nnoremap cp :let @+ = expand("%")<CR>

" Make parent directories
command Mk :!mkdir -p %:h
