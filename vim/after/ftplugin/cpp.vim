"-----------------------------------------------------------------------------------------------------------------------
"
" C++ Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Tuesday, November 06, 2018 at 05:26:15 PM PST
"
" Description:
"   This file contains additional settings for the C++ file type. This file is sourced after the other file type plugin
"   files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Change the comment string to be C++-style comments instead of C-style comments.
setlocal commentstring=//%s

" Override the default text width for C++ files to 120 characters.
setlocal textwidth=120
