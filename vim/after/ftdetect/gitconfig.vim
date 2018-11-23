"-----------------------------------------------------------------------------------------------------------------------
"
" Git Config Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 02:24:40 PM PDT
"
" Description:
"   This file contains additional file associations for the Git config file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate variants of the main Git config file with the Git config file type, such as the file without a leading
" period and a local version of the file.
autocmd BufRead,BufNewFile gitconfig        setlocal filetype=gitconfig
autocmd BufRead,BufNewFile .gitconfig_local setlocal filetype=gitconfig
autocmd BufRead,BufNewFile gitconfig_local  setlocal filetype=gitconfig
