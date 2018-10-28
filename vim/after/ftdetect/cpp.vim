"-----------------------------------------------------------------------------------------------------------------------
"
" C++ Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 02:33:42 PM PDT
"
" This file contains additional file associations for the C++ file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate Microsoft Bond files with C++ files. No good syntax highlighters exist for this file type in Vim, but C++ is
" about the closest for syntax.
autocmd BufRead,BufNewFile *.bond setlocal filetype=cpp
