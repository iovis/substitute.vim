function! substitute#parse#substitute(command) abort
  let l:substitute = {}

  let l:substitute.command = 's' . a:command
  let l:substitute.separator = l:substitute.command[1]

  " '\\\@<!' => Match '/', but not '\/'
  let l:regexp = '\\\@<!'
  let l:parsed_command = split(l:substitute.command, l:regexp . l:substitute.separator, 1)

  let l:substitute.search  = l:parsed_command[1]
  let l:substitute.replace = get(l:parsed_command, 2, '')
  let l:substitute.args    = get(l:parsed_command, 3, '')

  " If 's//replace/args', use last search
  if l:substitute.search ==? ''
    let l:substitute.search = @/
  endif

  return l:substitute
endfunction
