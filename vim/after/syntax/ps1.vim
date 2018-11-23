"-----------------------------------------------------------------------------------------------------------------------
"
" PowerShell Additional Syntax Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Wednesday, November 07, 2018 at 07:59:19 PM PST
"
" Description:
"   This file contains syntax settings for the PowerShell file type. This file is sourced after the other file type
"   plugin files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Allow for spaces in PowerShell type declarations. The existing syntax file disallows any spaces, but these are
" permitted inside of type declarations (e.g. [tuple[int, string]] is legal).
syntax match ps1Type /\[[a-z_][a-z0-9_.,\[\] ]\+\]/
