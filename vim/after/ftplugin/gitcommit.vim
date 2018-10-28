"-----------------------------------------------------------------------------------------------------------------------
"
" Git Commit Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 12:09:08 PM PDT
"
" This file contains additional settings for the Git commit file type. This file is sourced after the other file type
" plugin files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Disable the changing of the current working directory to the directory of the file being edited. This is not very
" useful for Git commit files, since it will nest you inside the .git directory.
setlocal noautochdir

" Enable spell checking (US English) for Git commit files.
setlocal spell spelllang=en_us
