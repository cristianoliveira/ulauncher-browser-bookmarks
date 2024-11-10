{ pkgs ? import <nixpkgs> {} }:
  with pkgs; stdenv.mkDerivation rec {
    name = "python-virtualenv-shell";
    env = buildEnv { name = name; paths = buildInputs; };
    buildInputs = [
      python3
      python3Packages.virtualenv
      # It is essential **not** to add `pip` here as
      # it would prevent proper virtualenv creation.
      inotify-tools
      ulauncher
      gtk3
    ];
    shellHook = ''
      # set SOURCE_DATE_EPOCH so that we can use python wheels
      SOURCE_DATE_EPOCH=$(date +%s)

      virtualenv venv

      source venv/bin/activate
    '';
  }
