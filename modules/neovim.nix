{ config, lib, pkgs, inputs, ... }:
let
  utils = inputs.nixCats.utils;
  luaPath = ./../dots/nvim/.;
in
{
  config = {
    nixCats = {
      enable = true;
      addOverlays = [
        (utils.standardPluginOverlay inputs)
      ];

      luaPath = luaPath;

      packageNames = [ "VimCats" ];


      categoryDefinitions.replace = ({ pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            lazygit
            universal-ctags
            ripgrep
            fd
            tree-sitter
          ];
          lua = with pkgs; [
            lua-language-server
            stylua
          ];
          nix = with pkgs; [
            nixd
            nixfmt
          ];
          rust = with pkgs; [
            rust-analyzer
            cargo
            rustfmt
            clippy
            lldb
          ];
        };

        startupPlugins = {
          general = with pkgs.vimPlugins; {
            always = [
              lze
              lzextras
              gruvbox-material-nvim
              plenary-nvim
              oil-nvim
            ];
            extra = [
              nvim-web-devicons
            ];
          };
        };

        optionalPlugins = {

          general = with pkgs.vimPlugins; [
            nvim-lspconfig
            nvim-treesitter.withAllGrammars
            nvim-treesitter-textobjects
            telescope-fzf-native-nvim
            telescope-ui-select-nvim
            telescope-nvim
            lualine-nvim
            which-key-nvim
            blink-cmp
          ];

          lua = with pkgs.vimPlugins; [
            lazydev-nvim
          ];

          rust = with pkgs.vimPlugins; [
          ];

        };
      });

      packageDefinitions.replace = {
        # These are the names of your packages
        # you can include as many as you wish.
        VimCats = { pkgs, name, ... }: {

          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = true;
            configDirName = "nixCats-nvim";
            aliases = [ "vim" "vimcat" "vi" ];
          };

          categories = {
            general = true;
            lua = true;
            nix = true;
            rust = true;
          };
          extra = {
            nixdExtras.nixpkgs = ''import ${pkgs.path} {}'';
          };
        };
      };
    };
  };
}
