# template

[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

Templating on your terminal

## Install

With [fisherman]

```
fisher Markcial/template
```

## Usage

```fish
template -h
# Out : usage docs
```

Set environment variables and then call the command with double curly brackets
for templating those variables.

```fish
set spam "eggs and bacon"
template "I like {{spam}} for breakfast"
# Out: I like eggs and bacon for breakfast
```

You can use your already defined environment variables

```fish
template "I am using fish shell {{FISH_VERSION}}"
# Out: I am using fish shell 2.5.0
```

If you want to write some code documenting twig you have scape tags too

```fish
set escaped rendered
template "I will be {{escaped}} {@escape}but me {{not}}{@/escape}"
# Out: I will be rendered but me {{not}}
```

You can even use some native executable fish code

```fish
template "Copyright since 2016 until {= date '+%Y'}"
# Out: Copyright since 2016 until 2017
```

or

```fish
template "Currently at: {= hostname} on {= date +%Z}"
# Out: Currently at: Air-de-Markcial on CEST
```

You can use files for templating too

```text
This is a txt file
located in {{PWD}}

{@escape}i am {{safe}} here{@/escape}

Whoami? I am {= whoami}
```

```fish
template -f "template.txt"
# Out: This is a txt file
located in /Users/username/Projects/template

i am {{safe}} here

Whoami? I am username
```

[travis-link]: https://travis-ci.org/Markcial/template
[travis-badge]: https://img.shields.io/travis/Markcial/template.svg
[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[fisherman]: https://github.com/fisherman/fisherman
