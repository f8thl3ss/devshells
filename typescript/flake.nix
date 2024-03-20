{
  # Override nixpkgs to use the latest set of node packages
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs_20
            # You can choose pnpm, yarn, or none (npm).
            pkgs.nodePackages_latest.pnpm
            # pkgs.yarn

            # Already installed
            #pkgs.nodePackages.typescript
            #pkgs.nodePackages.typescript-language-server
          ];
        };
      });
}
