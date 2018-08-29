"-----------------------------------------------------------------------------------------------------------------------
"
" Vim Plugins
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, August 26, 2018 at 10:58:17 PM PDT
"
" This file contains all of all the plugins utilized by Vim. This file sets up the plugins to be loaded and also sets
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

" This begins the start of installed plugins using Vim-Plug. Plugins come from GitHub, unless they have a
" fully-qualified URL or path.
call plug#begin('~/.vim/installed-plugins')

    " Provides a nicer and prettier status and tabline for Vim. This is highly customizable and the default includes the
    " line number, git branch, what Vim mode you're currently in, etc.
    Plug 'vim-airline/vim-airline'

    " Adds support for C0 files to Vim, used for the 15-122 class. This is a locally installed plugin.
    Plug '~/.vim/manual-plugins/c0.vim'

    " Provides commands for interacting with Git and other version control software. This allows you do
    " things such as opening `git blame` for the current file. Used by the Vim Airline plugin to get branch names.
    Plug 'tpope/vim-fugitive'

    " Adds a fuzzy finder (FZF) to Vim, providing commands to perform fuzzy searches. A fuzzy finder is used to find
    " files based on partial strings. FZF is also command-line tool, the first Plug line installs this tool.
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
    Plug 'junegunn/fzf.vim'

    " Adds support for the ISPC (Intel SPMD Program Compiler) language to Vim.
    Plug 'jez/vim-ispc'

    " Serves as a replacement for Vim's standard MatchIt plugin, extending it with better behavior, and adds in
    " highlighting of matching keywords delimiters, similar to how Vim treats matching character delimiters.
    Plug 'andymass/vim-matchup'

    " Adds support for Google's Protocol Buffer language to Vim.
    Plug 'PProvost/vim-ps1'

    " Adds support for the Rust language to Vim.
    Plug 'rust-lang/rust.vim'

    " Allows man pages to be viewed with Vim. This is already possible natively with Vim; this plugin sets up a 'Vman'
    " command that can used to do it from the terminal.
    Plug 'jez/vim-superman'

    " Adds better and more comprehensive support for the Verilog and SystemVerilog languages to Vim.
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
" SystemVerilog Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

" Disable the default indenting behavior for assign statements, instead indenting by a fixed amount.
let g:verilog_indent_assign_fix = 1

" Disable the default indenting behavior for the clothing parenthesis of the modules, function, etc. are indented,
" instead adding no additional parenthesis to the closing parenthesis.
let g:verilog_disable_indent_lst = ['eos']
