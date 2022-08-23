""""""""""""""""""""""
" rgon's VIM Settings
""""""""""""""""""""""
execute pathogen#infect()
call pathogen#helptags()

set nocompatible                    " choose no compatibility with legacy vi
set encoding=utf-8
set showcmd                         " display incomplete commands
syntax on
filetype plugin indent on           " load file type plugins + indentation
set autowrite                       " automatically :write before running cmds
set laststatus=2

"" Statusline
set statusline=                               " clear on reload
set statusline+=[%n]\                         " buffer number
set statusline+=%f                            " filename
set statusline+=%h%m%r%w                      " flags
set statusline+=%=                            " switch to the right side
set statusline+={%{strlen(&ft)?&ft:'none'}    " filetype
set statusline+=\|                            " separator
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " encoding
set statusline+=\|                            " separator
set statusline+=%{&ff}}\                      " file format
set statusline+=%-14.([%l/%L,%v]%)\           " cursor – [line/total, col]
set statusline+=%<%p%%                        " cursor progress

"" Whitespace
set nowrap                          " don't wrap lines
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent
set backspace=indent,eol,start		" backspace thru everything in insert mode

"" Margins
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%81v.\+/

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " start searching before pressing <ENTER>

"" Appearance
set background=dark
set t_Co=256                        " 256 colors in terminal

for scheme in [ 'molokai', 'solarized', 'desert' ]
  try
    execute 'colorscheme '.scheme
      break
  catch
    continue
  endtry
endfor

" Highlight 80th column
if exists('+colorcolumn')
    let &colorcolumn="80,".join(range(120,500),",")
else
    autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Temporary session-based file mgmt
if empty(glob($HOME.'/.vim/tmp'))
  call mkdir($HOME.'/.vim/tmp/backup', 'p')
  call mkdir($HOME.'/.vim/tmp/swp')
  call mkdir($HOME.'/.vim/tmp/undo')
endif
set backupdir=$HOME/.vim/tmp/backup//
set directory=$HOME/.vim/tmp/swp//
set undodir=$HOME/.vim/tmp/undo//

"" Plugins

" vim-session

" Disable automatic loading
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" ctrlp + The Silver Searcher
" Excluding version control directories
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
if executable('ag')
  " ag > grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  " ag is so fast there's no need to cache
  let g:ctrlp_use_caching = 0

  " Enable Ack.vim w/ The Silver Searcher
  let g:ackprg = 'ag --vimgrep --smart-case'

  " Add alias to rewrite "Ag" to "Ack" to aid in the transition effort.
  cnoreabbrev Ag Ack
endif

" vim-fugutive
noremap \gs :Gstatus<CR>
noremap \gc :Gcommit<CR>
noremap \ga :Gwrite<CR>
noremap \gl :Glog<CR>
noremap \gd :Gdiff<CR>
noremap \gb :Gblame<CR>

" vim-go
let g:go_fmt_command = "goimports"

" nerdtree
let NERDTreeWinPos = 'left'
let NERDTreeShowHidden = 1
let NERDTreeIgnore = [
  \'\.DS_Store$',
  \'\.git$',
  \'\.gitkeep$',
  \'\.pyc$',
  \'\.swo$',
  \'\.swp$',
\]
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>

" syntastic
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

"" syntastic filetype checkers
let g:syntastic_go_checkers = ['golint']

"" ALE
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" tagbar
nmap <F8> :TagbarToggle<CR>

"" ==============
"" Key Mappings
"" ==============

" set <Leader> key
let mapleader=" "

" Disable directionals b/c why not?! vim level: 10 :)
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Redraws the screen and removes any search highlighting
nnoremap <silent> <Leader>l :nohl<CR><C-l>

"" window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"" buffers
" <C-b><C-n> goes to next buffer
nnoremap <C-b><C-n> :bnext<CR>
" <C-b><C-p> goes to previous buffer
nnoremap <C-b><C-p> :bprevious<CR>
" <C-b><C-l> lists the current buffers
nnoremap <C-b><C-l> :ls<CR>

"" pastetoggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"" spellcheck - toggle spell checking
nnoremap <F7> :setlocal invspell spell?<CR>
set showmode
" Turn on spellcheck by default in git commit msgs and Markdown files
autocmd FileType gitcommit setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell

"" vim-markdown
" F9 toggles the TOC on
nnoremap <F9> :Toc<CR>
set nofoldenable  " disable folding

"" vim-terraform
" Automatically format on save.
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1

"" formatting

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

nnoremap <Leader>= :call TrimWhiteSpace()<CR>

"" load local config
if filereadable(glob($HOME.'/.vimrc.local'))
  source $HOME/.vimrc.local
endif

