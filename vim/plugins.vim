"-----------------------------------------------------------------------------------------------------------------------
"
" Vim Plugins
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, August 26, 2018 at 10:58:17 PM PDT
"
" Description:
"   This file contains all of all the plugins utilized by Vim. This file sets up the plugins to be loaded and also sets
"   any settings for the plugin.
"
"-----------------------------------------------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------------------------------------------
" General Variables
"-----------------------------------------------------------------------------------------------------------------------

" The directory where plugins that come from online repository sources are installed.
let g:vim_plugin_directory          = g:vim_directory . '/installed_plugins'

" The directory where local plugins that are on the filesystem are located.
let g:vim_manual_plugin_directory   = g:vim_directory . '/manual_plugins'

"-----------------------------------------------------------------------------------------------------------------------
" Vim-Plug Setup
"-----------------------------------------------------------------------------------------------------------------------

" If the Vim-Plug plugin manager is not installed, download it and install it.
let s:vim_plug_path                 = g:vim_directory . '/autoload/plug.vim'
if empty(glob(s:vim_plug_path))
    execute 'silent !curl --fail --location --output ' . s:vim_plug_path .
            \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echomsg 'The Vim-Plug plugin manager has been installed. Relaunch Vim and run :PlugInstall to install the plugins.'
    finish
endif

"-----------------------------------------------------------------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------------------------------------------------------------

" This begins the start of installed plugins using Vim-Plug. Plugins come from GitHub, unless they have a
" fully-qualified URL or path. When possible, any plugins that create command-line programs have the programs and man
" pages placed in directory where user-local programs and related files are placed, so no new paths need added.
call plug#begin(g:vim_plugin_directory)

    " TODO
    " Plug 'peterrincker/vim-argumentative'
    " Plug 'jiangmiao/auto-pairs'
    " Plug 'ntpeters/vim-better-whitespace'
    " Plug 'octol/vim-cpp-enhanced-highlight'
    " Plug 'jpetrie/vim-counterpoint'
    " Plug 'easymotion/vim-easymotion' OR Plug 'justinmk/vim-sneak'
    " Plug 'apalmer1377/factorus'
    " Plug 'sjl/gundo.vim'
    " Plug 'Yggdroot/indentLine'
    " Plug 'terryma/vim-multiple-cursors'
    " Plug 'sheerun/vim-polyglot'
    " Plug 'luochen1990/rainbow'
    " Plug 'andrewradev/splitjoin.vim'
    " Plug 'godlygeek/tabular'
    " Plug 'majutsushi/tagbar'
    " Plug 'stmuk/taglist.vim'
    " Plug 'wellle/targets.vim'
    " Plug 'reedes/vim-wheel'

    " Provides a nicer and prettier status and tab line for Vim. This is highly customizable and the default includes the
    " line number, git branch, what Vim mode you're currently in, etc.
    Plug 'vim-airline/vim-airline'

    " Provides live linting on files while they are being edited, highlighting linting errors based on whatever linting
    " tool is used for that language via an Asynchronous Lint Engine (ALE).
    Plug 'dense-analysis/ale'

    " Provides a command for wrapping and unwrapping argument lists in function or doing the same for collections like
    " lists, dictionaries, etc. These turn inline lists into multiline ones and vice-versa.
    Plug 'FooSoft/vim-argwrap'

    " Adds commands for easily commenting out blocks of text to Vim.
    Plug 'tpope/vim-commentary'

    " Adds support for C0 files to Vim, used for the 15-122 class. This is a locally installed plugin.
    Plug g:vim_manual_plugin_directory . '/c0.vim'

    " Adds commands for easily aligning text to Vim, such as aligning a set of lines along an equals character.
    Plug 'junegunn/vim-easy-align'

    " Provides commands for interacting with Git and other version control software. This allows you do
    " things such as opening `git blame` for the current file. Used by the Vim Airline plugin to get branch names.
    Plug 'tpope/vim-fugitive'

    " Adds a fuzzy finder (FZF) to Vim, providing commands to perform fuzzy searches. A fuzzy finder is used to find
    " files based on partial strings. FZF is also command-line tool, the first Plug line installs this tool.
    Plug 'junegunn/fzf', {'do': './install --all --no-update-rc'}
    Plug 'junegunn/fzf.vim'

    " Adds Git status indicators into the sign column, which is next to the line numbers. This shows the status of each
    " line in the file, whether it is added, modified, or removed.
    Plug 'airblade/vim-gitgutter'

    " Adds a manager for Ctags files. This plugin automatically generates tags files for projects (typically defined by
    " repository boundaries) and incrementally updates the tags file as new changes are saved. This all also happens in
    " the background to be transparent to the user.
    Plug 'ludovicchabant/vim-gutentags'

    " Adds support for viewing and editing binary files to Vim. This plugin adds simple Hex editor features to Vim.
    Plug 'fidian/hexmode'

    " Adds support for the ISPC (Intel SPMD Program Compiler) language to Vim.
    Plug 'jez/vim-ispc'

    " Adds some reasonable options when editing very large files with Vim.  Disables syntax highlighting and other
    " options when the size of file exceeds a configurable minimum.
    Plug 'vim-scripts/LargeFile'

    " Serves as a replacement for Vim's standard MatchIt plugin, extending it with better behavior, and adds in
    " highlighting of matching keywords delimiters, similar to how Vim treats matching character delimiters.
    Plug 'andymass/vim-matchup'

    " Allows Vim to be used as a pager, adding a less mode to Vim. Additionally, the plugin includes Vim variants of
    " the Cat (Vimcat) and Less (Vimpager) command line tools that include syntax highlighting for the viewed files.
    Plug 'rkitover/vimpager', {'do': 'make PREFIX=${STOW_DIR}/vimpager install && stow vimpager'}

    " Adds support for the PowerShell language to Vim.
    Plug 'PProvost/vim-ps1'

    " Adds support for the Rust language to Vim.
    Plug 'rust-lang/rust.vim'

    " Adds support for the Shakespeare template language library for Haskell. This allows for inlining templated code
    " blocks for other languages (e.g. HTML, CSS, etc.) in Haskell. This plugin adds support for correctly highlighting
    " these templates.
    Plug 'pbrisbin/vim-syntax-shakespeare'

    " Allows man pages to be viewed with Vim. This is already possible natively with Vim; this plugin sets up a Vim
    " variant of the Man command that renders the Man pages more nicely.
    Plug 'jez/vim-superman', {'do': 'mkdir -p ${STOW_DIR}/vim-superman && cp -ar bin ${STOW_DIR}/vim-superman &&'
                                    \ . ' stow vim-superman'}

    " Adds commands for easily surrounding text with delimiters (e.g. quotes, parenthesis, etc.) to Vim.
    Plug 'tpope/vim-surround'

    " Adds a table mode to Vim that allows for the creation and formatting of nice tables in Vim, particularity for
    " Markdown tables.
    Plug 'dhruvasagar/vim-table-mode'

    " Adds better and more comprehensive support for the Verilog and SystemVerilog languages to Vim.
    Plug 'vhda/verilog_systemverilog.vim'

call plug#end()

"-----------------------------------------------------------------------------------------------------------------------
" Airline Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

" Use the fancier Powerline fonts for the tag line being displayed, instead of the default Unicode fonts. This is the
" font used when examples are given on line. Note, this requires the Powerline patched fonts to be installed.
let g:airline_powerline_fonts       = 1

" Don't display the language being used for spell checking when spell mode is displayed in the tag line.
let g:airline_detect_spelllang      = 0

"-----------------------------------------------------------------------------------------------------------------------
" Easy Align Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

" Change the default behavior used for aligning delimiters of different lengths from right-aligning to left-aligning.
" This is important when aligning operators that may have different lengths (e.g. '=' and '+=').
let g:easy_align_delimiter_align    = 'ld'

" Add additional delimiters that can be used by Easy Align for alignment. This adds support for backslashes.
let g:easy_align_delimiters         = {
        \ '\': {'pattern': '\\', 'right_margin': 0},
\ }

"-----------------------------------------------------------------------------------------------------------------------
" Hexmode Settings
"-----------------------------------------------------------------------------------------------------------------------

" Define the file patterns (via their extensions) that will trigger starting with with Hex mode enabled. These define
" files with extensions that are expected to always be binary.
let g:hexmode_patterns = '*.bin,*.exe,*.dat'

"-----------------------------------------------------------------------------------------------------------------------
" GitGutter Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

highlight clear SignColumn
highlight GitGutterAdd      ctermfg=DarkGreen   ctermbg=NONE
highlight GitGutterDelete   ctermfg=DarkRed     ctermbg=NONE
highlight GitGutterChange   ctermfg=DarkYellow  ctermbg=NONE

"-----------------------------------------------------------------------------------------------------------------------
" Gutentags Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

" Define the directory where created tags files are placed. Tags are placed here rather than at the root of projects.
let g:gutentags_cache_dir                   = g:vim_directory . '/editor_files/tags_files'

" The list of extra arguments to pass to the Ctags program when invoking it.
let g:gutentags_ctags_extra_args            = ['--recurse', '--extras=+q', '--fields=+i']

" Generate tags file even if there is no buffer open, as long as the current working directory is inside a project.
let g:gutentags_generate_on_empty_buffer    = 1

"-----------------------------------------------------------------------------------------------------------------------
" Large File Plugin Settings
"-----------------------------------------------------------------------------------------------------------------------

" The minimum size a file must be in MB to activate the Large File plugin. Files above this size will have various
" settings that will slow down editing disabled.
let g:LargeFile                     = 1

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
