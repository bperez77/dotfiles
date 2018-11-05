"-----------------------------------------------------------------------------------------------------------------------
"
" Diff Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Monday, November 05, 2018 at 03:27:01 PM PST
"
" This file contains additional settings for the Diff (patch) file type. This file is sourced after the other file type
" plugin files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Disable the cleaning up of whitespace. The diff may contain some of the whitespace patterns that would be cleaned up
" by the whitespace commands, so they need to be disabled.
let b:enable_whitespace_cleanup = 0
