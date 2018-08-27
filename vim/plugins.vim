"-----------------------------------------------------------------------------------------------------------------------
"
" Vim Plugins
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, August 26, 2018 at 10:58:17 PM PDT
"
" This file contains all of all the pluging utilized by Vim. This file sets up the plugins to be loaded and also sets
" any settings for the plugin.
"
"-----------------------------------------------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------------------------------------------
" Vim-Plug Setup
"-----------------------------------------------------------------------------------------------------------------------

" If the Vim-Plug plugin manager is not installed, download it and install it.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

"-----------------------------------------------------------------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------------------------------------------------------------

" A plugins that extends matching delimiters to language keywords, usch as begin and end in SystemVerilog. This allows
" one to use the '%' key to jump between these keywords.
runtime! macros/matchit.vim

" This begins the start of installed plugins using Vim-Plug. Plugins come from Github, unless they have a
" fully-qualified URL or path.
call plug#begin('~/.vim/installed-plugins')

    " A plugin that acts as a terminal emulator for Vim. This allows for various REPLs/shells to be opened and
    " interacted with from Vim, such as a Bash shell, a Python REPL, etc., so commands can be run.
    Plug 'lrvick/Conque-Shell'

    " A plugin for adding support for C0 files to Vim, used for a class. This is a locally installed plugin.
    Plug '~/.vim/manual-plugins/c0.vim'

    " A plugin for adding support for ISPC (Intel SPMD Program Compiler) files to Vim.
    Plug 'jez/vim-ispc'

    " A plugin for adding support for Protocol Buffer files to Vim, used for a class. This is locally installed..
    Plug 'uarun/vim-protobuf'

    " A plugin for adding support for Windows PowerShell files to Vim.
    Plug 'PProvost/vim-ps1'

    " A plugin for adding support for Rust files to Vim.
    Plug 'rust-lang/rust.vim'

    " A plugin for adding support for Verilog and SystemVerilog files to Vim.
    Plug 'vhda/verilog_systemverilog.vim'

call plug#end()

"-----------------------------------------------------------------------------------------------------------------------
" ConqueTerm Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

" When entering a ConqueTerm buffer, automatically go into insert mode.
let g:ConqueTerm_InsertOnEnter = 1

" Allow the CTRL-W shortcut to navigate out of a ConqueTerm buffer, even in insert mode. Note, this overrides the shell
" shortcut CTRL-W, which deletes the previous word.
let g:ConqueTerm_CWInsert = 1

" Continue showing the output of any commands being run in ConqueTerm, even when the buffer is not being focused on
" (e.g. you're focused on another buffer).
let g:ConqueTerm_ReadUnfocused = 1

" Tell ConqueTerm to always use Python3. This suppresses a warning about the Python 2 interface being unavailable.
let g:ConqueTerm_PyVersion = 3

" Set the terminal ConqueTerm should be identified as. The xterm terminal has better features than the default (vt100).
let g:ConqueTerm_Term = 'xterm-256color'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SystemVerilog File Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable the default indenting behavior for assign statements, instead indenting by a fixed amount.
let g:verilog_indent_assign_fix = 1

" Disable the default indenting behavior for the clothing parenthesis of the modules, function, etc. are indented,
" instead adding no additional parenthesis to the closing parenthesis.
let g:verilog_disable_indent_lst = ['eos']
