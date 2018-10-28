"-----------------------------------------------------------------------------------------------------------------------
"
" Shell Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 02:47:15 PM PDT
"
" This file contains additional file associations for the Shell file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate the variants of the Bashrc file with the Shell file type, as they are shell files.
autocmd BufRead,BufNewFile bashrc_* setlocal filetype=sh
