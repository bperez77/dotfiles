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

" This begins the start of installed plugins using Vim-Plug. Plugins come from Github, unless they have a
" fully-qualified URL or path.
call plug#begin('~/.vim/installed-plugins')

    " A plugin that provides a nicer and prettier status and tabline for Vim. This is highly customizable and the
    " default includes the line number, git branch, what Vim mode you're currently in, etc.
    Plug 'vim-airline/vim-airline'

    " A plugin that acts as a terminal emulator for Vim. This allows for various REPLs/shells to be opened and
    " interacted with from Vim, such as a Bash shell, a Python REPL, etc., so commands can be run.
    Plug 'lrvick/Conque-Shell'

    " A plugin for adding support for C0 files to Vim, used for a class. This is a locally installed plugin.
    Plug '~/.vim/manual-plugins/c0.vim'

    " A plugin that provides commands for interacting with Git and other version control software. This allows you do
    " things such as opening `git blame` for the current file. Used by the Vim Airline plugin to get branch names.
    Plug 'tpope/vim-fugitive'

    " A plugin for adding support for ISPC (Intel SPMD Program Compiler) files to Vim.
    Plug 'jez/vim-ispc'

    " A plugin that serves as a replacement for Vim's standard MatchIt plugin, extending it with better behavior, and
    " adds in highlighting of matching keywords delimiters, similar to how Vim treats matching character delimiters.
    Plug 'andymass/vim-matchup'

    " A plugin for adding support for Protocol Buffer files to Vim, used for a class. This is locally installed..
    Plug 'uarun/vim-protobuf'

    " A plugin for adding support for Windows PowerShell files to Vim.
    Plug 'PProvost/vim-ps1'

    " A plugin for adding support for Rust files to Vim.
    Plug 'rust-lang/rust.vim'

    " A plugin that allows man pages to be viewed from Vim. This is already possible natively with Vim; this plugin sets
    " up a 'vman' command that can used to do it from the terminal.
    Plug 'jez/vim-superman'

    " A plugin for adding support for Verilog and SystemVerilog files to Vim.
    Plug 'vhda/verilog_systemverilog.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use the fancier Powerline fonts for the tagline being displayed, instead of the default Unicode fonts. This is the
" font used when examples are given on line. Note, this requires the Powerline patched fonts to be installed.
let g:airline_powerline_fonts = 1

" Don't display the language being used for spell checking when spell mode is displayed in the tagline.
let g:airline_detect_spelllang = 0

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
" Highlight MatchIt Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable highlighting MatchIt keywords by default. This ensures that the plugin is unconditionally enabled when Vim
" starts up.
let g:hl_matchit_enable_on_vim_startup = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SystemVerilog Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable the default indenting behavior for assign statements, instead indenting by a fixed amount.
let g:verilog_indent_assign_fix = 1

" Disable the default indenting behavior for the clothing parenthesis of the modules, function, etc. are indented,
" instead adding no additional parenthesis to the closing parenthesis.
let g:verilog_disable_indent_lst = ['eos']
