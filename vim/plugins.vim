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
" General Variables
"-----------------------------------------------------------------------------------------------------------------------

" The directory where plugins that come from online repository sources are installed.
let g:vim_plugin_directory          = g:vim_directory . '/installed-plugins'

" The directory where local plugins that are on the filesystem are located.
let g:vim_manual_plugin_directory   = g:vim_directory . '/manual-plugins'

"-----------------------------------------------------------------------------------------------------------------------
" Vim-Plug Setup
"-----------------------------------------------------------------------------------------------------------------------

" If the Vim-Plug plugin manager is not installed, download it and install it.
let s:vim_plug_path                 = g:vim_directory . '/autoload/plug.vim'
if empty(glob(s:vim_plug_path))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

"-----------------------------------------------------------------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------------------------------------------------------------

" This begins the start of installed plugins using Vim-Plug. Plugins come from GitHub, unless they have a
" fully-qualified URL or path.
call plug#begin(g:vim_plugin_directory)

    " Provides a nicer and prettier status and tabline for Vim. This is highly customizable and the default includes the
    " line number, git branch, what Vim mode you're currently in, etc.
    Plug 'vim-airline/vim-airline'

    " Adds support for C0 files to Vim, used for the 15-122 class. This is a locally installed plugin.
    Plug g:vim_manual_plugin_directory . '/c0.vim'

    " Adds commands for easily aligning text to Vim, such as algining a set of lines along an equals character.
    Plug 'junegunn/vim-easy-align'

    " Provides commands for interacting with Git and other version control software. This allows you do
    " things such as opening `git blame` for the current file. Used by the Vim Airline plugin to get branch names.
    Plug 'tpope/vim-fugitive'

    " Adds a fuzzy finder (FZF) to Vim, providing commands to perform fuzzy searches. A fuzzy finder is used to find
    " files based on partial strings. FZF is also command-line tool, the first Plug line installs this tool.
    Plug 'junegunn/fzf', { 'do': './install --all --no-update-rc' }
    Plug 'junegunn/fzf.vim'

    " Adds support for the ISPC (Intel SPMD Program Compiler) language to Vim.
    Plug 'jez/vim-ispc'

    " Serves as a replacement for Vim's standard MatchIt plugin, extending it with better behavior, and adds in
    " highlighting of matching keywords delimiters, similar to how Vim treats matching character delimiters.
    Plug 'andymass/vim-matchup'

    " Adds support for the PowerShell language to Vim.
    Plug 'PProvost/vim-ps1'

    " Adds support for the Rust language to Vim.
    Plug 'rust-lang/rust.vim'

    " Allows man pages to be viewed with Vim. This is already possible natively with Vim; this plugin sets up a 'Vman'
    " command that can used to do it from the terminal.
    Plug 'jez/vim-superman'

    " Adds a table mode to Vim that allows for the creation and formatting of nice tables in Vim, particularily for
    " Markdown tables.
    Plug 'dhruvasagar/vim-table-mode'

    " Adds better and more comprehensive support for the Verilog and SystemVerilog languages to Vim.
    Plug 'vhda/verilog_systemverilog.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use the fancier Powerline fonts for the tagline being displayed, instead of the default Unicode fonts. This is the
" font used when examples are given on line. Note, this requires the Powerline patched fonts to be installed.
let g:airline_powerline_fonts       = 1

" Don't display the language being used for spell checking when spell mode is displayed in the tagline.
let g:airline_detect_spelllang      = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Align Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use 'ga' as the key stroke shortcut for the easy align command. This creates shortcuts for normal and visual mode.
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

"-----------------------------------------------------------------------------------------------------------------------
" SystemVerilog Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

" Disable the default indenting behavior for assign statements, instead indenting by a fixed amount.
let g:verilog_indent_assign_fix     = 1

" Disable the default indenting behavior for the clothing parenthesis of the modules, function, etc. are indented,
" instead adding no additional parenthesis to the closing parenthesis.
let g:verilog_disable_indent_lst    = ['eos']

"-----------------------------------------------------------------------------------------------------------------------
" Table Mode Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

" Change the separators used at the corners of the table to a bar character, so it is Markdown compatible.
let g:table_mode_corner             = '|'

" Auto command that enable table mode. This enables table mode for the selected file types.
augroup TableModeEnable
    autocmd!
    autocmd FileType markdown silent TableModeEnable
augroup END
