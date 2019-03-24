"-----------------------------------------------------------------------------------------------------------------------
"
" XML Indent Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Thursday, December 13, 2018 at 01:59:22 PM PST
"
" Description:
"
"   This file contains indent settings for the XML file type. This file is source before all other indent files, so it
"   can set values to control how the standard XML indent settings operate.
"
"-----------------------------------------------------------------------------------------------------------------------

" Disable syntax-based automatic indentation for XML files. This is annoying because it indents too aggressively.
let b:did_indent = 1
