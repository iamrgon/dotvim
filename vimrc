""""""""""""""""""""""
" rgon's VIM Settings
""""""""""""""""""""""
execute pathogen#infect()

set nocompatible                    " choose no compatibility with legacy vi
set encoding=utf-8
set showcmd                         " display incomplete commands
syntax on
filetype plugin indent on           " load file type plugins + indentation
set laststatus=2
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

"" Whitespace
set nowrap                          " don't wrap lines
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent
set backspace=indent,eol,start		" backspace thru everything in insert mode

"" File-Based Whitespace
autocmd filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4

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

"" Plugins

" vim-fugutive
noremap \gs :Gstatus<CR>
noremap \gc :Gcommit<CR>
noremap \ga :Gwrite<CR>
noremap \gl :Glog<CR>
noremap \gd :Gdiff<CR>
noremap \gb :Gblame<CR>

" nerdtree
let NERDTreeWinPos='left'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

"" ==============
"" Key Mappings
"" ==============
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" <Ctrl-l> redraws the screen and removes any search highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>

"" buffers
" <Alt-n> goes to next buffer
nnoremap <C-b><C-n> :bnext<CR>
" <Alt-n> goes to previous buffer
nnoremap <C-b><C-p> :bprevious<CR>
" <Alt-l> lists the current buffers
nnoremap <C-b><C-l> :ls<CR>

"" pastetoggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


