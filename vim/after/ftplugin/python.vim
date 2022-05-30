"-----------------------------------------------------------------------------------------------------------------------
"
" Python Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Saturday, November 03, 2018 at 09:23:04 PM PDT
"
" Description:
"
"   This file contains additional settings for the Python file type. This file is sourced after the other file type
"   plugin files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Override the default text width for Python files to 120 characters.
setlocal textwidth=120

" When using ArgWrap always include a trailing comma when expanding a argument list out across multiple lines as Python
" permits this and it is the standard style.
let b:argwrap_tail_comma = 1
