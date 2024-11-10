{
  description = "Janko keyboard";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      unstable,
      flake-parts,
      smoServer,
      agenix,
      agenix-rekey,
    #devshell,
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
        {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.
          #devshells.default = {

          #};
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [ ];
            buildInputs = with pkgs; [
              gcc
              gcc-arm-embedded-4_7
              teensy-loader-cli
            ];
            # LD_LIBRARY_PATH = unstable.lib.makeLibraryPath devTools;
          };

          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          packages.default = pkgs.hello;
          apps = { };

        };
    };

}
