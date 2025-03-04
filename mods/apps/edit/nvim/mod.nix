{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    neovim.enable = lib.mkEnableOption "enables neovim";
  };

  config = {
    # enable neovim by default
    neovim.enable = lib.mkDefault true;

    # don't download packages if neovim is disabled
    home.packages = lib.mkIf config.neovim.enable (with pkgs; [
      alejandra
      nixd
      lua-language-server
    ]);

    # don't enable neovim if it's disaled
    programs.neovim = lib.mkIf config.neovim.enable (let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
      enable = true;

      extraPackages = with pkgs; [
        xclip
        wl-clipboard
      ];

      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./ext/lsp.lua;
        }

        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\").setup()";
        }

        {
          plugin = gruvbox-nvim;
          config = "colorscheme gruvbox";
        }

        neodev-nvim
        nvim-cmp
        {
          plugin = nvim-cmp;
          config = toLuaFile ./ext/cmp.lua;
        }

        {
          plugin = telescope-nvim;
          config = toLuaFile ./ext/tele.lua;
        }

        telescope-fzf-native-nvim
        cmp_luasnip
        cmp-nvim-lsp
        luasnip
        friendly-snippets
        lualine-nvim
        nvim-web-devicons

        {
          plugin = nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
          ]);
          config = toLuaFile ./ext/ts.lua;
        }

        vim-nix
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./opts.lua}
      '';

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    });
  };
}
