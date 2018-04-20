" Vimrc - Vim runcom (run commands)
"
" This file is executed when a new vim editing session is started up, and
" configures the settings and command aliases for the session
"
" Creation Date: Tuesday, September 03, 2013 at 4:54:31 PM EDT

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype detection and syntax hilighting
syntax on
filetype on
filetype indent on
filetype plugin on
filetype indent plugin on

" Ensure that we are in modern vim mode, not backwards-compatible vi mode
set nocompatible
set backspace=indent,eol,start

" Helpful information: cursor position in the bottom right, line numbers on the
" left, path name in the title, and command being typed in the bottom right
set ruler
set number
set title
set showcmd

" Ensure that the colorscheme is always the default from Ubuntu 14.04
colorscheme default

" Make tabs 4 spaces instead of a tab character
set tabstop=4
set shiftwidth=4
set expandtab

" Make vim highlight all instances of a search term
set hlsearch

" Set tab completion to scroll through available matches alphabetically, and
" enable the menu to display file matches
set wildmode=full
set wildmenu

" Highlight matching braces
set showmatch

" Open window splits below and to the right (as opposed to vim's unnatural default)
set splitbelow
set splitright

" Set the default shell to bash
set shell=bash

" When using ctags to search for identifiers, search for the tags file from
" the file's current directory, then all of its parent directories.
set tags=./tags;

" Use the peachpuff color scheme's color for highlighting searches. This looks
" much better for white text.
highlight Search term=reverse ctermbg=3 guibg=Gold2

" Overwrite Vim's awful colorscheme when using the vimdiff tool. This produces
" a much visually better looking diff.
highlight DiffAdd ctermfg=White ctermbg=DarkGreen guifg=White guibg=DarkGreen
highlight DiffDelete ctermfg=White ctermbg=DarkRed guifg=White guibg=DarkRed
highlight DiffChange ctermfg=White ctermbg=DarkMagenta guifg=White
        \ guibg=DarkMagenta
highlight DiffText ctermfg=White ctermbg=DarkBlue guifg=White guibg=DarkBlue

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Settings and Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip whitespace from the end of lines when writing files
augroup strip_whitespace
    autocmd!
    autocmd BufWritePre * SquashBlankLines | DeleteTrailingLines |
            \ StripWhitespace
augroup END

" Autocommands that associate non-standard extensions with filetype
augroup filetype_associations
    autocmd!

    " Associate 15-411 lab test files with the C0 filetype
    autocmd BufRead,BufNewFile *.l1 *.l2 *.l3 *.l4 *.l5 *.l6 set filetype=c0

    " Associate configuration files with their closest language
    autocmd BufRead,BufNewFile *.lalrpop set filetype=rust
    autocmd BufRead,BufNewFile *.json set filetype=javascript

    " Set Arduino files to have C++ syntax highlighting
    autocmd BufRead,BufNewFile *.ino set filetype=cpp

    " Set Kbuild files to have Makefile syntax highlighting
    autocmd BufRead,BufNewFile Kbuild set filetype=make
augroup END

" When the color column is enabled, color it blue
highlight ColorColumn ctermbg=DarkBlue ctermfg=white guibg=#592929

" Function to set the default textwidth if it is not already specified
function! SetDefaultTW()
    if &textwidth == 0 || &filetype == ""
        set textwidth=120
    endif
endfunction

" Function to set the OverLength to be 1 past the textwidth
function! SetOverLength()
    if &textwidth != 0
        execute 'match OverLength /\%' . (&textwidth + 1) . 'v.\+/'
    endif
endfunction

" Autocommands that deal with line length restrictions
augroup line_length
    autocmd!

    " By default, the textwidth is 120 if not specified.
    autocmd BufRead,BufNewFile * call SetDefaultTW()

    " For C-like file types, the line length restriction is 80 characters
    autocmd FileType c,cpp,python,rust,cuda,make,asm set textwidth=80

    " For ConqueTerm windows, there is no limit to the text width
    autocmd FileType conque_term set textwidth=0

    " Set OverLength to be one past the text width
    autocmd FileType * call SetOverLength()
augroup END

" Highlight any characters past the line length limit in red
highlight OverLength ctermbg=red ctermfg=white guibg=#592929

" Autocommands that deal with changing settings for comments
augroup comments
    autocmd!

    " Enable C style comments for C-like languages
    autocmd FileType rust,cuda,c0,verilog_systemverilog setlocal
        \ formatoptions+=croql

    " Disable automatic extension of '//' style comments
    autocmd FileType c,cpp,rust,cuda,c0,verilog_systemverilog setlocal
        \ comments-=:// comments+=f://
augroup END

" Autocommands that enable spellchecks for markdown and git commit files
augroup spellcheck
    autocmd!
    autocmd Filetype * setlocal spell spelllang=en_us
    autocmd Filetype matlab,text,conque_term,conf,cmake,gitconfig,asm,help,tcl,
        \sshconfig,bib,gitrebase setlocal spelllang=
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Remappings and Aliases
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets up the leader character to be a comma
let mapleader = ","
let g:mapleader = ","

" Allow for capital letters for common commands
command! WQ wq
command! Wq wq
command! W w
command! Q q

" A quick shortcut to duplicate a single line
nnoremap Y yyp

" Shortcuts for saving the file and closing the file from insert mode
inoremap <leader>w <ESC>:w<CR>i
inoremap <leader>q <ESC>:q<CR>
inoremap <leader>wq <ESC>:wq<CR>

" Provide versions of cut and delete in normal and visual modes that don't yank
" the elements. These disable yank by using the black hole register.
nnoremap <silent> <leader>d "_d
nnoremap <silent> <leader>D "_d
nnoremap <silent> <leader>c "_c
nnoremap <silent> <leader>C "_C
vnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>D "_D
vnoremap <silent> <leader>c "_c
vnoremap <silent> <leader>C "_C

" Override the default behavior of the <Del> key, and prevent it from
" automatically yanking the text it deletes.
noremap <silent> <Del> "_x

" Override the default behavior of the paste command in visual mode. Instead
" of yanking the selection that was pasted over, simply delete it.
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vnoremap <silent> <expr> p <sid>Repl()
vnoremap <silent> <expr> P <sid>Repl()

" Shortcuts to toggle paste mode and spellcheck
set pastetoggle=<F2>
noremap <F3> :setlocal spell! spelllang=en_us<CR>

" Quick shortcut to disable highlighting overlength lines
noremap <F8> :match none<CR>

" Window navigation shortcuts with Alt and the arrow keys
map <silent> <A-Up> :wincmd k<CR>
map <silent> <A-Down> :wincmd j<CR>
map <silent> <A-Left> :wincmd h<CR>
map <silent> <A-Right> :wincmd l<CR>

" Override the default Vexplore behavior to split right instead of left
command! Vex Vexplore!

" A command that allows a shell command to be executed silently. Normally, VIM
" puts itself in the background, then leaves you in the shell
command! -bar -nargs=* Sh execute ':silent !' . <q-args> | execute ':redraw!'

" Provide short aliases for spawning a BASH shell with ConqueTerm
command! -bar Sbash ConqueTermSplit bash
command! -bar Vbash ConqueTermVSplit bash
command! -bar Bash ConqueTerm bash

" Sets up a command to be run when the file is saved, and clears the command
command! -bar -nargs=* OnWrite autocmd BufWritePost * !<args>
command! -bar -nargs=* OnWriteSilent autocmd BufWritePost * Sh <args>
command! -bar OnWriteClear autocmd! BufWritePost

" Commands that remove trailing blank lines, collapse consecutive blank lines,
" and strip trailing whitespace.
command! -bar StripWhitespace execute 'normal! mz' | silent! %s/\s\+$//e | noh |
        \ normal! `z
command! -bar DeleteTrailingLines execute 'normal! mz' |
        \ silent! %s/\($\n\s*\)\+\%$//e | noh | silent! normal! `z
command! -bar SquashBlankLines execute 'normal! mz' |
        \ silent! %s/\(\s*\n\s*\n\)\(\s*\n\)\+/\1/e | noh | silent! normal! `z

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Expansions (Macros)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Shortcuts to insert dates, timestamps, and human-readable timestamps
iabbrev <expr> _dts strftime("%c")
iabbrev <expr> _hdts strftime("%A, %B %d, %Y at %r %Z")
iabbrev <expr> _ds strftime("%b %d, %Y")

" Shortcut to insert a header gaurd
function! Header_Gaurd()
    let basename = toupper(fnamemodify(bufname("%"), ":t:r"))
    let extension = toupper(fnamemodify(bufname("%"), ":e"))
    let gaurd = basename . "_" . extension . "_"
    return  "#ifndef " . gaurd . "" .
           \"#define " . gaurd . "" .
           \"" .
           \"#endif /* " . gaurd . " */"
endfunction
iabbrev <expr> _hdgd Header_Gaurd()

" Shortcut to insert a generic comment header for various languages
iabbrev <expr> _hd "" .
    \"/*----------------------------------------------------------------------------<CR>" .
    \"<CR>" .
    \"<BS>----------------------------------------------------------------------------*/<CR>"
iabbrev <expr> _shhd "" .
    \"#-------------------------------------------------------------------------------<CR>" .
    \"#<CR>" .
    \"#-------------------------------------------------------------------------------<CR>"
iabbrev <expr> _shhd_bold "" .
    \ "################################################################################<CR>" .
    \ "#<CR>" .
    \ "################################################################################<CR>"

" Shortcut to insert Doxygen doc string in a file
iabbrev <expr> _dxhd "" .
    \"/**<CR>" .
    \"@file " . fnamemodify(bufname("%"), ":t") . "<CR>" .
    \"@author Brandon Perez <bmperez@alumni.cmu.edu><CR>" .
    \"@date " . strftime("%A, %B %d, %Y at %r %Z") . "<CR>" .
    \"<CR>" .
    \"FIXME: Insert a short description here<CR>" .
    \"<CR>" .
    \"FIXME: Insert a longer description here<CR>" .
    \"<BS>*/"

" Shortcut to insert a Doxygen doc string for functions
iabbrev <expr> _dxf "" .
    \"/**<CR>" .
    \"FIXME: Insert a brief description here.<CR>" .
    \"<CR>" .
    \"FIXME: Insert a longer description here.<CR>" .
    \"<CR>" .
    \"@param[in] var_name FIXME: Description of input parameter `var_name`<CR>" .
    \"<CR>" .
    \"@param[out] var_name FIXME: Description of output parameter `var_name`<CR>" .
    \"<CR>" .
    \"@return FIXME: Description of function's return value<CR>" .
    \"<BS>*/"

" Shortcut to insert a Sphinx documentation string in a file
iabbrev <expr> _sxhd "" .
    \"\"\"\"<CR>" .
    \fnamemodify(bufname("%"), ":t") . "<CR>" .
    \".. module:: " . fnamemodify(bufname("%"), ":t:r") . "<CR>" .
    \"<CR>" .
    \".. moduleauthor:: Brandon Perez <bmperez@alumni.cmu.edu><CR>" .
    \".. date:: " . strftime("%A, %B %d, %Y at %r %Z") . "<CR>" .
    \"<CR>" .
    \"FIXME: Insert Brief Description Here<CR>" .
    \"<CR>" .
    \"FIXME: Insert Longer Description Here<CR>" .
    \"\"\"\"<CR>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" External Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ConqueTerm is a program that allows you to run shells and REPL's inside vim
" When entering a shell buffer, automatically go to insert mode, allow for
" CTRL-W to switch out of a ConqueTerm instance, and continue text output even
" when the focus is not on the ConqueTerm buffer
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_ReadUnfocused = 1
