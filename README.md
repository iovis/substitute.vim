# Substitute.vim [![Build Status](https://travis-ci.org/iovis/substitute.vim.svg?branch=master)](https://travis-ci.org/iovis/substitute.vim)
Perform project wide substitutions

## Installation ##

Use your preferred installation method for Vim plugins.

With [vim-plug](https://github.com/junegunn/vim-plug) that would mean to add
the following to your vimrc:

```vim
Plug 'iovis/substitute.vim'
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

  With [!] it will try to leverage 'perl' to perform the
  substitution from outside vim (EXPERIMENTAL)
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
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
```

With [Ripgrep](https://github.com/BurntSushi/ripgrep) (recommended) you don't
need to specify a folder because it'll do a recursive search by default.

## Patterns ##

If you use normal vim patterns they will get converted to their equivalent
perl patterns for compatibility with grep.

Example: Changing `before :each do` to `before(:each) do` inside the _spec/_
folder. First with vim's regular expressions:
```vim
:S/\(before\)\s\+\(:\w\+\)\s\+/\1(\2) / -- --type ruby
```

And with 'very magic' mode:
```vim
:S/\v(before)\s+(:\w+)\s+/\1(\2) / -- --type ruby
```

## Examples ##

Upgrade from 'FactoryGirl' to 'FactoryBot' and save (default grep):
```vim
:S/FactoryGirl/FactoryBot -- **/*.rb | update
```

Upgrade from 'FactoryGirl' to 'FactoryBot' and save (with rg):
```vim
:S/FactoryGirl/FactoryBot -- --type ruby | update
```

The following examples will assume 'rg' is installed and `grepprg` was changed
to use it.

Change every instance of the last search and ask for confirmation:
```vim
/foo
:S//bar/gc
```
Do a literal search (don't apply {pattern} to rg):
```vim
:S/foo()/bar() -- -F
```
Include VCS ignored files:
```vim
:S/foo/bar -- -u
```
Include hidden files:
```vim
:S/foo/bar -- -uu
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

Report any issues to https://github.com/iovis/substitute.vim/issues

## Changelog ##

Version 2.0: 2020-02-20
  - Smarter substitution (choosing |cdo| or |cfdo|)
  - Experimental perl support

Version 1.0: 2017-11-26
  - Initial release
