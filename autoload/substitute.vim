function! substitute#command(bang, args) abort
  let l:parsed_args = split(a:args)
  let l:substitute = substitute#parse#substitute(l:parsed_args[0])
  let l:grep = substitute#parse#grep(l:substitute.search, l:parsed_args[1:])

  " Load hits into the quickfix window
  execute 'silent grep! "' . l:grep.search . '" ' . l:grep.args

  " Apply substitute command to every hit
  execute 'cdo! ' . l:substitute.command
endfunction
