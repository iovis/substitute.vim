function! substitute#command(bang, args) abort
  let [l:substitute_args, l:grep_args] = substitute#parse#command(a:args)
  let l:substitute = substitute#parse#substitute(l:substitute_args)
  let l:grep = substitute#parse#grep(l:substitute.search, l:grep_args)

  " Load hits into the quickfix window
  execute 'silent grep! "' . l:grep.search . '" ' . l:grep.args

  " Apply substitute command to every hit
  let l:cdo_command = 'silent cdo! ' . l:substitute.command

  if a:bang
    let l:cdo_command .= ' | update'
  endif

  execute l:cdo_command
endfunction
