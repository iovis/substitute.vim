# Substitute.vim
Perform project wide substitutions

## Installation ##

Use your preferred installation method for Vim plugins.

With [vim-plug](https://github.com/junegunn/vim-plug) that would mean to add
the following to your vimrc:

```vim
Plug 'iovis9/subsitute.vim'
```

## Usage ##

Use 'substitute' as you'd use the regular `substitute` command and append any
optional arguments you need for `grep` after `--`.

```vim
:S[!]/{pattern}/{string}/[flags] [-- [grep_arguments]]

  For each line matched with grep for {pattern}, apply
  the corresponding substitute command.

  [grep_arguments] will be passed along to your 'grepprg' of
  choice.

  With [!] it will save the results of the change on every
  file.
```

## Grep Program ##

With the default `:grep` program you'll need to specify the glob pattern for
grep to know where to look for your {pattern}:

```vim
:S/pattern/replacement -- **/*.rb
```

```vim
:S/pattern/replacement -- -R .
```

You can change the program vim uses for grep with `grepprg`:

```vim
if executable('ag')
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif
```

With [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
(recommended) you don't need to specify a folder because it'll do a recursive
search by default.

## Patterns ##

If you use normal vim patterns they will get converted to their equivalent
perl patterns for compatibility with grep.

Example: Changing `before :each do` to `before(:each) do` inside the _spec/_
folder. First with vim's regular expressions:
```vim
:S/\(before\)\s\+\(:\w\+\)\s\+/\1(\2) / -- --ruby
```

And with 'very magic' mode:
```vim
:S/\v(before)\s+(:\w+)\s+/\1(\2) / -- --ruby
```

## Examples ##

Upgrade from 'FactoryGirl' to 'FactoryBot' and save (default grep):
```vim
:S!/FactoryGirl/FactoryBot -- **/*.rb
```

Upgrade from 'FactoryGirl' to 'FactoryBot' and save (with ag):
```vim
:S!/FactoryGirl/FactoryBot -- --ruby
```

The following examples will assume 'ag' is installed and `grepprg` was changed
to use it.

Change every instance of the last search and ask for confirmation:
```vim
/foo
:S//bar/gc
```
Do a literal search (don't apply {pattern} to ag):
```vim
:S/foo()/bar() -- -Q
```
Include VCS ignored files:
```vim
:S/foo/bar -- -U
```
Include hidden files:
```vim
:S/foo/bar -- --hidden
```
Limit the search to the folder of the current file:
```vim
:S/foo/bar -- %:h
```

## Known Issues ##

Matching '\' at the end of your pattern will fail as it'll think it's escaping
the separator character.
```vim
This won't work:
:S/foo\\/bar
```

## Bugs ##

Report any issues to https://github.com/iovis9/substitute.vim/issues

## Changelog ##

Version 1.0: 2017-11-26
- Initial release
