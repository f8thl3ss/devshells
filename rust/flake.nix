{
  description = "A Nix-flake-based Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , rust-overlay
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [ (import rust-overlay) ];
      pkgs = import nixpkgs { inherit system overlays; };
      rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          cargo-deny
          cargo-edit
          cargo-watch
          openssl
          pkg-config

          rustToolchain
        ];

        shellHook = ''
          export PATH=$PATH:~/.cargo/bin
          ${rustToolchain}/bin/cargo --version
        '';
      };
    });
}
