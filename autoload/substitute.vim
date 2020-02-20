function! substitute#command(bang, args) abort
  let [l:substitute_args, l:grep_args] = substitute#parse#command(a:args)
  let l:substitute = substitute#parse#substitute(l:substitute_args)
  let l:grep = substitute#parse#grep(l:substitute.search, l:grep_args)

  " Load hits into the quickfix window
  execute 'silent grep! "' . l:grep.search . '" ' . l:grep.args

  " Apply substitute command to every file
  if a:bang
  else
    call substitute#vim(l:substitute)
  endif
endfunction

function! substitute#vim(substitute) abort
  if a:substitute.global
    let l:command = 'cfdo! ' . a:substitute.command
  else
    let l:command = 'cdo! ' . a:substitute.command
  endif

  execute l:command
endfunction
endfunction
