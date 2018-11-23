"-----------------------------------------------------------------------------------------------------------------------
"
" Python Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 02:24:50 PM PDT
"
" Description:
"   This file contains additional file associations for the Python file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate the Python startup and variants of the file with the Python file type, since they are Python files.
autocmd BufRead,BufNewFile .pythonstartup   setlocal filetype=python
autocmd BufRead,BufNewFile pythonstartup    setlocal filetype=python
autocmd BufRead,BufNewFile .pythonstartup_* setlocal filetype=python
autocmd BufRead,BufNewFile pythonstartup_*  setlocal filetype=python
