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

function! substitute#parse#grep(search, grep_args) abort
  let l:grep = {}
  let l:grep.args = escape(join(a:grep_args, ' '), '|#%')

  " translate vim regular expression to perl regular expression.
  let l:grep.very_magic = !empty(matchstr(a:search, '^\\v'))

  if l:grep.very_magic
    let l:grep.search = substitute(a:search, '^\\v', '', '')
  else
    let l:grep.search = substitute#parse#regex(a:search)
  endif

  return l:grep
endfunction

function! substitute#parse#regex(string) abort
  let l:escaped_regex = substitute(a:string, '\(\\<\|\\>\)', '\\b', 'g')
  let l:escaped_regex = substitute(l:escaped_regex, '\\(', '(', 'g')
  let l:escaped_regex = substitute(l:escaped_regex, '\\)', ')', 'g')
  let l:escaped_regex = substitute(l:escaped_regex, '\\|', '|', 'g')
  let l:escaped_regex = substitute(l:escaped_regex, '\\{', '{', 'g')
  let l:escaped_regex = substitute(l:escaped_regex, '\\}', '}', 'g')
  let l:escaped_regex = substitute(l:escaped_regex, '\\+', '+', 'g')
  let l:escaped_regex = substitute(l:escaped_regex, '\\?', '?', 'g')

  return l:escaped_regex
endfunction
