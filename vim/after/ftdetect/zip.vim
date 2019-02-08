"-----------------------------------------------------------------------------------------------------------------------
"
" ZIP Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Friday, February 08, 2019 at 11:00:47 AM PST
"
" Description:
"   This file contains additional file associations for the ZIP file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate NuGet package files with the ZIP file type. These are just simple wrappers around ZIP files. As opposed to
" the type file type detection, call the ZIP extension's browse function is called instead.
autocmd BufReadCmd *.nupkg call zip#Browse(expand('<amatch>'))
