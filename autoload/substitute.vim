function! substitute#command(bang, args) abort
  let l:parsed_args = split(a:args)
  let l:substitute = substitute#parse#substitute(l:parsed_args[0])
  let l:grep_args = join(l:parsed_args[1:])

  " Load hits into the quickfix window
  execute 'silent grep! ' . shellescape(l:substitute.search) . ' ' . l:grep_args

  " Apply substitute command to every hit
  execute 'cdo s' . l:substitute.command
endfunction
