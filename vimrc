execute pathogen#infect()

" Preferences...................................................................
filetype plugin indent on
syntax on
runtime macros/matchit.vim          " use % to jump to matching tags
set mouse=a                         " add mouse support
set viminfo='51,<1000,s100,h        " increase maximum number of lines to yank
set wrap linebreak nolist           " wrap whole words instead of characters
set display+=lastline               " display long lines on same screen
set smartcase                       " case sensitive if search expression 
                                    " includes an uppercase character
set ignorecase                      " do case insensitive search
set number                          " show line numbers
set breakindent                     " wrap preserving the indent
set title                           " show title on file opened
set cursorline                      " highlight current line
set scrolloff=3                     " show 3 lines before/after current line
"set hlsearch                       " highlight search results
"set spell spelllang=en_us          " check spelling
set splitbelow                      " horizontal split window to bottom
set splitright                      " vertical split window to right
set incsearch                       " highlight next search
set timeoutlen=1000 ttimeoutlen=0   " remove keyboard delay
set foldmethod=manual               " **insert redundent comment here**

" set indention and tab stuff
set ts=4                            " show existing tabs with 4 spaces
set sw=4                            " use 4 spaces when useing '>'
set expandtab                       " on pressing tab, insert 4 spaces
set softtabstop=4                   " backspace behavior on space indents 

" Enable true color
set termguicolors " Enable true color support.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" set theme
colorscheme monokai                 " for some reason need to load this for other shit to work
let g:seoul256_background = 233
colorscheme space-vim-dark
if has('gui_running')
    colorscheme atom-dark
endif
set background=light
set background=dark


" Function to make background transparent and change color of
" background of only the text beyond 80 chars.
function! Make_transparent()
    hi Normal guibg=NONE ctermbg=NONE

    " Change color of background beyond 80 characters
    highlight ColorColumn ctermbg=NONE guibg=NONE
    let &colorcolumn=join(range(81,999),",")

    " Highlight Columns that cross 80 characters
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endfunction

" Function to make opaque and change color of background beyond 
" 80 chars
function! Make_opaque()
        colorscheme space-vim-dark
        set background=dark

        " Change color of background beyond 80 characters
        highlight ColorColumn ctermbg=235 guibg=#2c2d27
        let &colorcolumn=join(range(81,999),",")

endfunction

" Toggle transparent background
let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
    " Make transparent
        call Make_transparent()

        let t:is_transparent = 1
    else
    " Make opaque
        call Make_opaque()
        let t:is_transparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>
"...............................................................................

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
"...............................................................................

"...............................................................................
" remove menu, tool and scroll bars for gvim
if has('gui_running')
    set guioptions-=m               "menu bar
    set guioptions-=T               "toolbar
    set guioptions-=r               "scrollbar
endif
"...............................................................................

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

" prevent d from yanking 
"nnoremap d "_d
"vnoremap d "_d

" nerdtreetoggle
inoremap <C-f> <Esc>:NERDTreeToggle<CR>
nnoremap <C-f> <Esc>:NERDTreeToggle<CR>

" moving lines
nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
inoremap <C-J> <Esc>:m .+1<CR>==gi
inoremap <C-K> <Esc>:m .-2<CR>==gi
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" remap yanking to system clipboard
vnoremap <C-c> "+y

" remap pasting to system clipboard
vnoremap <C-p> "+p
nnoremap <C-p> "+p
inoremap <C-v> <Esc>"+pa    " put and enter insert mode

" select all
nnoremap <C-a> ggvG$

" if syntax highlighting gets messed up, usually on larger files
noremap <F5> <Esc>:syntax sync fromstart<CR>

" remap save
nnoremap <C-u> <Esc>:up<CR> :echo 'saved' <CR>
inoremap <C-u> <Esc>:up<CR> :echo 'saved' <CR>

" remap save and quit
nnoremap <C-w> <Esc>:up<CR> <Esc> :q<CR> :echo 'save and quit' <CR>
inoremap <C-w> <Esc>:up<CR> <Esc> :q<CR> :echo 'save and quit' <CR>

" close scratch
inoremap <C-c> <Esc>:pclose<CR>a
nnoremap <C-c> <Esc>:pclose<CR>

" make build and make run shortcuts and output to Scratch buffer.
nnoremap <F9> :Scratch!<CR>:0read !make build<CR><CR>
nnoremap <F10> :Scratch!<CR>:0read !make run<CR><CR>
let g:scratch_height=15
let g:scratch_top=0
"...............................................................................

" UltiSnips Stuff...............................................................
" Change ultisnips triggers, because fuck YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
"...............................................................................

" YouCompleteMe Stuff...........................................................
" Restart ycmd with proper python path set for Jedi.
python << EOF
import sys, vim, os
def setJediHttpPythonPath():
    ve_dir = vim.eval('$VIRTUAL_ENV')
    ve_dir in sys.path or sys.path.insert(0, ve_dir)
    ve_path = os.path.join(os.path.join(ve_dir, 'bin'), 'python3')
    vim.command("YcmCompleter RestartServer "+ve_path)
    vim.command("echo 'restarting ycmd with virtualenv %s'" % (ve_dir))
EOF
nnoremap <F2> :python setJediHttpPythonPath()<CR><CR>   

" let g:ycm_filetype_specific_completion_to_disable = {
" some random change yo! When will it show up?
" the world may never know.
"       \ 'java': 1
"       \}

" Misc. ycm stuff.
let &titleold=getcwd()
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
"...............................................................................

" Change command to invoke CtrlP................................................
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlP'
"...............................................................................
call Make_transparent()
