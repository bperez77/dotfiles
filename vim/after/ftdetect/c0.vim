"-----------------------------------------------------------------------------------------------------------------------
"
" C0 Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 11:27:34 AM PDT
"
" Description:
"   This file contains additional file associations for the C0 file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate 15-411 lab test files with the C0 file type, since they are C0 files. Each l* indicates the lab number.
autocmd BufRead,BufNewFile *.l1 *.l2 *.l3 *.l4 *.l5 *.l6 setlocal filetype=c0
