"-----------------------------------------------------------------------------------------------------------------------
"
" Verilog/SystemVerilog Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Thursday, November 08, 2018 at 07:43:01 PM PST
"
" This file contains additional settings for the Verilog/SystemVerilog file type. This file is sourced after the other
" file type plugin files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Change the comment string to be C++-style comments instead of C-style comments.
setlocal commentstring=//\ %s

" Override the default text width for Verilog and SystemVerilog files to 120 characters.
setlocal textwidth=120
