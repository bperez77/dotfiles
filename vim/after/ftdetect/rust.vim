"-----------------------------------------------------------------------------------------------------------------------
"
" Rust Additional File Type Detection
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Sunday, October 28, 2018 at 10:53:12 AM PDT
"
" This file contains additional file associations for the Rust file type.
"
"-----------------------------------------------------------------------------------------------------------------------

" Associate LALRPOP configuration files with the Rust filetype. This is a LR(1) parser generator library for Rust.
autocmd BufRead,BufNewFile *.lalrpop setlocal filetype=rust
