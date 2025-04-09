{
  description = "Janko keyboard";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    paulcores.url = "github:PaulStoffregen/cores";
    paulcores.flake = false;
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      paulcores,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      debug = true;
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        let
          foo = true;
          #teensy4-core = pkgs.stdenv.mkDerivation rec {
          #  name = "teensy4-core";
          #  buildInputs = [
          #    gnumake
          #    gcc-arm-embedded-13
          #  ];
          #  phases = ["unpackPhase" "buildPhase" "installPhase"];

          #  buildPhase =
          #};
        in
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [ ];
            buildInputs = with pkgs; [
              gcc
              gcc-arm-embedded-13
              teensy-loader-cli
              teensyduino
            ];
            # LD_LIBRARY_PATH = unstable.lib.makeLibraryPath devTools;
          };

          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          packages.default = pkgs.hello;
          apps = { };

        };
    };

}
