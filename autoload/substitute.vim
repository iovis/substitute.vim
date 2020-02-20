function! substitute#command(bang, args) abort
  let [l:substitute_args, l:grep_args] = substitute#parse#command(a:args)
  let l:substitute = substitute#parse#substitute(l:substitute_args)
  let l:grep = substitute#parse#grep(l:substitute.search, l:grep_args)

  " Load hits into the quickfix window
  execute 'silent grep! "' . l:grep.search . '" ' . l:grep.args

  " Apply substitute command to every file
  if a:bang
    call substitute#perl(l:grep, l:substitute)
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

function! substitute#perl(grep, substitute) abort
  " rg "search" --files-with-matches|xargs perl -pi -e "s/search/replace/g"
  let l:command  = '!rg "' . a:grep.search . '" --files-with-matches'
  let l:command .= '|'
  let l:command .= 'xargs perl -pi -e '
  let l:command .= '"s'
  let l:command .= a:substitute.separator
  let l:command .= a:substitute.search
  let l:command .= a:substitute.separator
  let l:command .= a:substitute.replace
  let l:command .= a:substitute.separator
  let l:command .= 'g"'

  execute l:command
endfunction
