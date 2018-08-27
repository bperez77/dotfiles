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

    " A plugin for adding support for Rust files to Vim.
    Plug 'rust-lang/rust.vim'

    " A plugin for adding support for Verilog and SystemVerilog files to Vim.
    Plug 'vhda/verilog_systemverilog.vim', {'for': 'verilog_systemverilog'}

call plug#end()
