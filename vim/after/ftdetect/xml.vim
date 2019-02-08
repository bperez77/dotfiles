"-----------------------------------------------------------------------------------------------------------------------
"
" XML Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 02:26:02 PM PDT
"
" Description:
"   This file contains additional file associations for the XML file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate MSBuild project and configuration files with the XML file type, since they are XML-style files.
autocmd BufRead,BufNewFile *.*proj                      setlocal filetype=xml
autocmd BufRead,BufNewFile *.props                      setlocal filetype=xml
autocmd BufRead,BufNewFile *.targets                    setlocal filetype=xml

" Associate NuGet and Core XT configuration files with XML file type.
autocmd BufRead,BufNewFile corext.config                setlocal filetype=xml
autocmd BufRead,BufNewFile NuGet.config,nuget.config    setlocal filetype=xml
autocmd BufRead,BufNewFile nuget.config                 setlocal filetype=xml

" Associate NuGet specification files with the XML file type.
autocmd BufRead,BufNewFile *.nuspec                     setlocal filetype=xml
