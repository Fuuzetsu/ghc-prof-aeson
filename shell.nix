{ nixpkgs ? import ./nixpkgs.nix {}
, ghc ? nixpkgs.haskell.compiler.ghc822
}:

with nixpkgs;

haskell.lib.buildStackProject {
  name = "ghc-prof-aeson";
  buildInputs = [ ];
  inherit ghc;
  LANG = "en_US.utf8";
}
