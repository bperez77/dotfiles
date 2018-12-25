"-----------------------------------------------------------------------------------------------------------------------
"
" CUDA Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Thursday, November 08, 2018 at 07:49:12 PM PST
"
" Description:
"   This file contains additional settings for the CUDA file type. This file is sourced after the other file type plugin
"   files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Change the comment string to be C++-style comments instead of C-style comments.
setlocal commentstring=//%s

" Override the default text width for CUDA files to 120 characters.
setlocal textwidth=120
