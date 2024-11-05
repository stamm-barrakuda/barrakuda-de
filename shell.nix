
{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # build tools
    nativeBuildInputs = with pkgs; [
      hugo
    ];

    # libraries/dependencies
    buildInputs = with pkgs; [];
}
