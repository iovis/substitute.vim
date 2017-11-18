" File: substitute.vim
" Author: David Marchante
" Description: Perform global substitutes
" Last Modified: November 18, 2017

command! -nargs=+ -bang -bar S :call s:parse_substitute(<bang>0, <q-args>)

function! s:parse_substitute(bang, args)
  let l:parsed_args = split(a:args)
  let l:substitute = s:parse_substitute_command(l:parsed_args[0])
  let l:grep_args = join(l:parsed_args[1:])

  echo l:substitute
  echo l:grep_args
endfunction

function! s:parse_substitute_command(command)
  let l:substitute = {}

  let l:substitute.command = a:command
  let l:substitute.separator = l:substitute.command[0]

  " '\\\@<!' => Match '/', but not '\/'
  let l:parsed_command = split(l:substitute.command, '\\\@<!' . l:substitute.separator, 1)

  let l:substitute.search  = l:parsed_command[1]
  let l:substitute.replace = get(l:parsed_command, 2, '')
  let l:substitute.args    = get(l:parsed_command, 3, '')

  " If 's//replace/args', use last search
  if l:substitute.search ==? ''
    let l:substitute.search = @/
  endif

  return l:substitute
endfunction
