"-----------------------------------------------------------------------------------------------------------------------
"
" Python Additional File Type Plugin Settings
"
" Author:           Brandon Perez <bmperez@alumni.cmu.edu>
" Creation Date:    Saturday, November 03, 2018 at 09:23:04 PM PDT
"
" Description:
"
"   This file contains additional settings for the Python file type. This file is sourced after the other file type
"   plugin files, so it adds to and/or overwrites the existing settings.
"
"-----------------------------------------------------------------------------------------------------------------------

" Override the default text width for Python files to 120 characters.
setlocal textwidth=120

" When using ArgWrap always include a trailing comma when expanding a argument list out across multiple lines as Python
" permits this and it is the standard style.
let b:argwrap_tail_comma = 1

" Restrict the linters used by the ALE plugin to Flake8 and Mypy only.
let b:ale_linters = [
    \ 'flake8',
    \ 'mypy',
\ ]

" Add an option for explicitly specifying the user's Flake8 configuration file when running the Flake8 linter. The
" linting warnings NQA102 (<code> has not matching violations) is currently ignored because the flake8-noqa plugin and
" ALE Vim plugin interact poorly to cause false positives for this linting warning.
let b:ale_python_flake8_options = '--config "$HOME/.flake8" --extend-ignore NQA102'
