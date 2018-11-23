"-----------------------------------------------------------------------------------------------------------------------
"
" Makefile Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 11:23:38 AM PDT
"
" Description:
"   This file contains additional file associations for the Makefile file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate Kernel build (Kbuild) files with the Makefile file type, as these are Makefiles.
autocmd BufRead,BufNewFile Kbuild setlocal filetype=make
