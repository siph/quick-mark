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
      packages = with pkgs; {
        default = stdenvNoCC.mkDerivation rec {
          name = "quick-mark";
          src = ./.;
          nativeBuildInputs = [makeBinaryWrapper];
          buildInputs = with pkgs; [nushell makeBinaryWrapper ffmpeg];
          installPhase = ''
            mkdir -p $out/bin
            mkdir -p $out/share/${name}
            cp ./${name}.nu $out/share/${name}
            makeWrapper ${nushell}/bin/nu $out/bin/${name} \
              --add-flags "$out/share/${name}/${name}.nu"
          '';
        };
      };
      formatter = pkgs.alejandra;
    });
}
