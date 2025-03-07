{
  description = "Home Manager configuration of andreasliljeqvist";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    suite_py.url = "suite_py";
    nixgl = { url = "github:guibou/nixgl"; };
  };

  outputs = { nixgl, nixpkgs, nixpkgs-unstable, home-manager, suite_py, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = [
          suite_py.overlays.default
          nixgl.overlay
          (self: super: {
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          })
          (self: super: {
            lib = super.lib // home-manager.lib // {
              hm = home-manager.lib.hm;
            };
          })
        ];
      };

    in {
      homeConfigurations."andreasliljeqvist" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./home.nix ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = {
            dotsPath = "/home/andreasliljeqvist/nix-dotfiles/";
          };
        };
    };
}
