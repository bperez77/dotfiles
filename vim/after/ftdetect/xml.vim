"-----------------------------------------------------------------------------------------------------------------------
"
" XML Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 02:26:02 PM PDT
"
" This file contains additional file associations for the XML file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate MSBuild project and configuration files with the XML file types, since they are XML-style files.
autocmd BufRead,BufNewFile *.*proj      setlocal filetype=xml
autocmd BufRead,BufNewFile *.props      setlocal filetype=xml
autocmd BufRead,BufNewFile *.targets    setlocal filetype=xml
