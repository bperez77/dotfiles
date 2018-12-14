"-----------------------------------------------------------------------------------------------------------------------
"
" XML Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Thursday, December 13, 2018 at 01:59:22 PM PST
"
" Description:
"   This file contains additional settings for the XML file type. This file is sourced after the other file type plugin
"   files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Disable the MatchUp plugin's word-based highlighting for XML files. This is a bit annoying because it highlights the
" entire parts of single-line tags.
let b:matchup_matchparen_enabled = 0
