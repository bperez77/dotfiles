"-----------------------------------------------------------------------------------------------------------------------
"
" Markdown Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 12:09:08 PM PDT
"
" This file contains additional settings for the Markdown file type. This file is sourced after the other file type
" plugin files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Enable spell checking (US English) for Markdown files.
setlocal spell spelllang=en_us

" Enable the Vim Table Mode plugin, which allows for easy alignment of tables.
silent TableModeEnable

" Disable soft text wrapping for Markdown files. Since Markdown's tables can't be split over multiple lines, it's
" cleaner to let the lines overflow the screen and horizontally scroll to read them.
set nowrap
