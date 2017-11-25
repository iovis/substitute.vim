" File: substitute.vim
" Author: David Marchante
" Description: Perform global substitutes
" Last Modified: November 18, 2017

" if exists('g:substitute_loaded') || &cp || v:version < 700
"   finish
" endif
" let g:substitute_loaded = 1

command! -nargs=+ -bang -bar S :call substitute#command(<bang>0, <q-args>)
