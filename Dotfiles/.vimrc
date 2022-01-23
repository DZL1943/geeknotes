"" for macvim
"" updated: 20220115

if has("gui_running")
    set gfn=Menlo-Regular:h16
    set lines=38 columns=100
    colorscheme desert
    set guioptions-=r
endif


syntax enable
set nocp
set mouse=a
set nu
set ru
set cul
set cuc
set ts=4
set sw=4
set sts=4
set et
"set list
set backspace=indent,eol,start
set hls
set scs    " smartcase
set is    " incsearch
set sm    " showmatch
set smd    " showmode
set sc    " showcmd
set ai
set fen    " foldenable
"set fdm=indent
set wrap
set whichwrap=b,s,<,>,[,]
set wildmenu
set ls=2
set stl=%<%f\%w%h%m%r\ [%{&ff}/%Y]
set acd


autocmd BufWritePost $MYVIMRC source $MYVIMRC
"let g:Powerline_colorscheme='solarized256'
