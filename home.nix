{ config, pkgs, lib, specialArgs, ... }:
let
  helpers = import ./helpers.nix {
    inherit pkgs;
    inherit lib;
    inherit config;
    inherit specialArgs;
  };

in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andreasliljeqvist";
  home.homeDirectory = "/home/andreasliljeqvist";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nixfmt-classic
    ripgrep
    du-dust
    bat
    pkgs.unstable.nixd
    nixpkgs-fmt
    lld
    nil
    (helpers.nixGLMesaWrap pkgs.wezterm)
    dbeaver-bin
    hyperfine
    gnucash
    mysql-client
    openssh
    devenv
    jq
    postgresql
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    fzf
    (helpers.nixGLMesaWrap pkgs.kitty)
    wl-clipboard
    tmux
    tmuxinator
    sesh
    zoxide
    entr
    vault
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  xdg.configFile."nvim".source = helpers.dotLink "nvim";
  xdg.configFile."tmux".source = helpers.dotLink "tmux";
  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/andreasliljeqvist/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    aliases = { "st" = "status"; };

  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.rofi = { enable = true; };
  programs.yazi.enable = true;
  programs.lazygit.enable = true;
  programs.neovim = {
    enable = true;
    vimAlias = true;
    package = pkgs.unstable.neovim-unwrapped;
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      suite-py = "nix shell suite_py -c suite-py";
      vault = "VAULT_ADDR=https://vault.helloprima.com:8200 command vault";
    };
    plugins = [{
      name = "zoxide";
      src = pkgs.fetchFromGitHub {
        owner = "ajeetdsouza";
        repo = "zoxide";
        rev = "d74bce3b7418ed965f5056297db8bb081a29121c";
        sha256 = "sha256-+QZpLMlHOZdbKLFYOUOIRZHvIsbMDdstj9oGzyEGVxk=";
      };
    }

      ];
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.bottom = { enable = true; };
  programs.helix = { enable = true; };
}
