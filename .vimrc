set backspace=indent,eol,start
set guifont=Fura\ Code\ Light\ Nerd\ Font\ Complete:h16
set mouse=v
set number
set cursorline
set cursorcolumn
set ic
set showcmd
set linebreak
set dy=lastline
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set autoindent
set iminsert=0
set imsearch=0
set laststatus=2
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]
set rtp+=/usr/local/opt/fzf
au BufRead /tmp/mutt-* set tw=72
" https://habr.com/ru/post/468265/
filetype plugin indent on "Включает определение типа файла, загрузку соответствующих ему плагинов и файлов отступов
set encoding=utf-8 "Ставит кодировку UTF-8
set nocompatible "Отключает обратную совместимость с Vi
set rtp+=/usr/local/opt/fzf " fzf
syntax enable "Включает подсветку синтаксиса
"colorscheme desert
colorscheme nord
" colorscheme sublimemonokai "Добавьте это НЕ в список плагинов

let g:airline_powerline_fonts = 1 "Включить поддержку Powerline шрифтов
let g:airline#extensions#keymap#enabled = 0 "Не показывать текущий маппинг
let g:airline_section_z = "\ue0a1:%l/%L Col:%c" "Кастомная графа положения курсора
let g:Powerline_symbols='unicode' "Поддержка unicode
let g:airline#extensions#xkblayout#enabled = 0 "Про это позже расскажу
"
if empty(glob('~/.vim/autoload/plug.vim')) "Если vim-plug не стоит
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs "Создать директорию
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "И скачать его оттуда
  "А после прогнать команду PlugInstall, о которой мы сейчас поговорим
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"
call plug#begin('~/.vim/bundle') "Начать искать плагины в этой директории
"Тут будут описаны наши плагины
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'arcticicestudio/nord-vim'
Plug 'hashivim/vim-terraform'
call plug#end() "Перестать это делать
