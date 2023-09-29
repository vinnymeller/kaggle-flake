{
  description = "Kaggle Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils/main";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          # if you need to use GPUs, uncomment these to enable CUDA support. note that this will
          # build from scratch since unfree isnt in the nix cache, and it may take forever.
          # allowUnfree = true;
          # cudaSupport = true;
        };

        python-pkgs = pkgs.python3.withPackages
          (ps: with ps; [
            graphviz
            ipykernel
            ipywidgets
            jupyterlab
            kaggle
            keras
            matplotlib
            optuna
            pandas
            polars
            scikit-learn
            # scikit-optimize     # TODO: build error
            seaborn
            skorch
            # tensorflow          # TODO: all of TF stack is broken on nix right now ?!
            # torch
            # torchaudio
            # torchvision
          ]);
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            python-pkgs
          ];
        };
      }
    );
}
