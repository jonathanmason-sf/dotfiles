set nocompatible
execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=5000
set ruler    " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch    " do incremental searching

" new stuff
set wildmenu    " display completion matches in a status line
set display=truncate
set scrolloff=5

set noswapfile

" Put plugins and dictionaries in this dir (also on Windows)
let vim_dir = '$HOME/dotfiles/vim'
let &runtimepath.=','.vim_dir

let backup_dir = expand(vim_dir . '/backup')
" call system('mkdir ' . backup_dir)
let &backupdir = backup_dir
set backup

" this is new instead of just plain set backup above
if has('persistent_undo')
  let undo_dir = expand(vim_dir . '/undo')
  " call system('mkdir ' . undo_dir)
  let &undodir = undo_dir
  set undofile
endif

if has('syntax') && has('eval')
  packadd matchit
endif
" end of new stuff

"runtime macros/matchit.vim

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  "set background=dark
  colorscheme PaperColor
  "colorscheme gruvbox " bad light, weird yellow
  "colorscheme one-dark " okay, but no automatic light
  "colorscheme one " not great
  "colorscheme pencil " nice, similar to vividchalk in dark, but worse
  "colorscheme vividchalk
endif

set noerrorbells
set vb t_vb=
set ts=2
set sw=2
set autoindent
set expandtab

let mapleader = " "

" Show syntax highlighting groups for word under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <leader>s :call SynStack()<cr>

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

  autocmd Filetype python setlocal ts=4 sw=4 expandtab
  autocmd Filetype java setlocal ts=4 sw=4 expandtab
  autocmd Filetype go setlocal ts=4 sw=4 noexpandtab

  " Highlight white extra white spaces
  " autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  " autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|^\t\+/
  " highlight ExtraWhitespace ctermbg=red guibg=red
  " match ExtraWhitespace /\s\+$/
  " autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|^\t\+/
  " autocmd InsertLeave * match ExtraWhitespace /\s\+$\|^\t\+/
  " #autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  " autocmd BufWinLeave * call clearmatches()

endif " has("autocmd")

" alt

" Run a given vim command on the results of alt from a given path.
" See usage below.
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" Find the alternate file for the current path and open it
nnoremap <leader>t :w<cr>:call AltCommand(expand('%'), ':tabnew')<cr>
"nnoremap <c-j> :w<cr>:call AltCommand(expand('%'), ':tabnew')<cr>

" CTRL-P tweaks

" The Silver Searcher
if executable('ag')
  " Use ag for Ack
  let g:ackprg = 'ag --vimgrep'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"set wildignore+=*/vendor/** " if ctrl-P is slow this could help

let g:ctrlp_map = '<c-j>'

let g:omni_sql_no_default_maps = 1
" let g:ftplugin_sql_omni_key = '<Leader>sql'

map - ddp
map _ ddkP

let g:ale_lint_on_text_changed = 'never'

" let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_guide_size = 1

function! RSpecCommand(lines)
  let cmd = "! bundle exec rspec " . expand('%') .":" . a:lines
  echom cmd
  exec cmd
endfunction

command! -nargs=1 RSpec :call RSpecCommand(<args>)
nnoremap <leader>ft :execute "RSpec " . line('.')<cr>
nnoremap <leader>at :! bundle exec rspec %<cr>
