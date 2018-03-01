# ghc-prof-aeson [![Build Status][travisbadge]][travisurl] [![Build Status][appbadge]][appurl]

Somewhere along the way in GHC 8.2.x it became possible to output
[profiling output in JSON
form](https://downloads.haskell.org/~ghc/8.2.2/docs/html/users_guide/profiling.html#json-profile-format).
This is much more friendly for tooling as usual profiling format
differs based the exact flags, identifier names, nesting, heap
profiling flags and phase of the moon. More than once have we fallen
to a [parse failure in
ghc-prof-flamegraph](https://github.com/fpco/ghc-prof-flamegraph/issues/10).

This is a very simple package that parses the profiling JSON output
and gives you a Haskell data structure to work with instead. This
should completely remove random parse failures due to weird formatting
or at the very least, provide better error messages.

[travisbadge]: https://travis-ci.org/Fuuzetsu/ghc-prof-aeson.svg?branch=master
[travisurl]: https://travis-ci.org/Fuuzetsu/ghc-prof-aeson
[appbadge]: https://ci.appveyor.com/api/projects/status/github/gruntjs/grunt?branch=master&svg=true
[appurl]: https://ci.appveyor.com/project/Fuuzetsu/ghc-prof-aeson
