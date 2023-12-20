{
  description = "Excessive ffmpeg command wrapper";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = {
        default = pkgs.stdenvNoCC.mkDerivation rec {
          name = "quick-mark";
          src = ./.;
          buildInputs = with pkgs; [nushell makeBinaryWrapper ffmpeg];
          installPhase = ''
            mkdir -p $out/nushell
            mkdir -p $out/bin

            cp ./${name}.nu $out/nushell/${name}.nu

            makeBinaryWrapper ${pkgs.nushell}/bin/nu $out/bin/${name} \
              --add-flags $out/nushell/${name}.nu
          '';
        };
      };
      formatter = pkgs.alejandra;
    });
}
