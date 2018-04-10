execute pathogen#infect()

"......preferences.......
filetype plugin indent on
syntax on
runtime macros/matchit.vim          " use % to jump to matching tags
set mouse=a                         " to prevent selecting line numbers with mouse
set viminfo='51,<1000,s100,h        " increase maximum number of lines to yank
set wrap linebreak nolist           " wrap whole words instead of characters
set display+=lastline               " display long lines on same screen
set smartcase                       " case sensitive if search expression includes a uppercase character
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
set foldmethod=manual

" set indent and tab stuff
set ts=4                            "show existing tabs with 4 spaces
set sw=4                            "use 4 spaces when useing '>'
set expandtab                       "on pressing tab, insert 4 spaces
set softtabstop=4                   "backspace behavior on space indents 
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" set theme
colorscheme monokai                 " for some reason need to load this for other shit to work
let g:seoul256_background = 233
" colo seoul256
:colorscheme space-vim-dark
if has('gui_running')
    colorscheme atom-dark
endif
set background=dark

" needed for lightline
set laststatus=2
" config lightline
let g:lightline = {
            \ 'colorscheme': 'seoul256',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
            \   'right':  [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'linter_warnings', 'linter_errors', 'linter_ok' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_expand': {
            \   'linter_warnings': 'LightlineLinterWarnings',
            \   'linter_errors': 'LightlineLinterErrors',
            \   'linter_ok': 'LightlineLinterOK'
            \ },
            \ 'component_type': {
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error',
            \   'linter_ok': 'ok'
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ }
autocmd User ALELint call lightline#update()

" ale + lightline
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ⚠', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction

" remove menu, tool and scroll bars for gvim
if has('gui_running')
    set guioptions-=m               "menu bar
    set guioptions-=T               "toolbar
    set guioptions-=r               "scrollbar
endif
"......................

".....remaps.....

" folding inside braces
nnoremap Zf vi{zf

" cycle through splits
nnoremap <Tab><Tab> <C-w>=<C-w><C-w>
nnoremap <Tab>h <C-w><C-h>
nnoremap <Tab>l <C-w><C-l>
nnoremap <Tab>j <C-w><C-j>
nnoremap <Tab>k <C-w><C-k>

nnoremap <Tab><Leader> <C-w>\|
nnoremap <Tab>- <C-w>_
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
inoremap <C-v> <Esc>"+pa

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
"...............

" Set ultisnips triggers, because fuck YouCompleteMe
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

let &titleold=getcwd()
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0

" nnoremap <F7> :Scratch<CR>
nnoremap <F8> :Scratch!<CR>:0read !make build<CR><CR>
nnoremap <F9> :Scratch!<CR>:0read !make run<CR><CR>
let g:scratch_height=15
let g:scratch_top=0
