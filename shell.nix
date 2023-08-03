
{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # build tools
    nativeBuildInputs = with pkgs; [
      netlify-cli
      git-lfs
      hugo
    ];

    # libraries/dependencies
    buildInputs = with pkgs; [];
}
