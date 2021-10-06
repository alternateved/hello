{ nixpkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { } }:

let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;

  haskellDeps = ps: with ps; [ base protolude containers ];

  ghc = haskellPackages.ghcWithPackages haskellDeps;
  nixPackages = [ ghc pkgs.gdb haskellPackages.cabal-install ];

in pkgs.haskell.lib.buildStackProject {
  name = "helloEnv";
  buildInputs = nixPackages;
}

