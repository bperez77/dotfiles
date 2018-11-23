"-----------------------------------------------------------------------------------------------------------------------
"
" Vim Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Saturday, November 03, 2018 at 11:06:40 PM PDT
"
" Description:
"   This file contains additional settings for the Vim file type. This file is sourced after the other file type plugin
"   files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Enable spell checking (US English) for Vim files.
setlocal spell spelllang=en_us

" Override the default text width for Vim files to 120 characters.
setlocal textwidth=120
