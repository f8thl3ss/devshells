{
  description = "test";

  inputs = {
    nixpkgs-python.url = "github:cwp/nixpkgs/python-env-venv";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs-python, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs-python.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.sqlite ];
          packages = [
            (pkgs.python3.withPackages (p: with p; [ virtualenv ]))
          ];
        };
      });
}
