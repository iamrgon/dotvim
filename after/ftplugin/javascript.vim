""""""""""""""""""""""
" rgon's Javascript Settings
""""""""""""""""""""""

"" Whitespace
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal expandtab

"" ale linters
" Support the "standard" lint style for Javascript.
let g:ale_linters = {
\   'javascript': ['standard'],
\}
let b:ale_fixers = {'javascript': ['standard']}
