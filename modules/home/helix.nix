{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    languages = {
      language-server = {
        haskell-language-server.command = "haskell-language-server";
        haskell-language-server.config.haskell = {
          formattingProvider = "fourmolu";
          plugin.fourmolu.config.external = true;
        };
        nil.command = "nixd";
      };
    };
    settings = {
      theme = "mytheme";
      editor = {
        auto-format = false;
        auto-save = true;
        bufferline = "multiple";
        color-modes = true;
        completion-timeout = 5;
        cursorline = true;
      };
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.indent-guides = {
        render = true;
        skip-levels = 1;
      };
      editor.lsp = {
        display-messages = true;
        display-inlay-hints = true;
      };
      keys.normal = {
        "esc" = [
          "collapse_selection"
          "keep_primary_selection"
        ];
        "S-h" = ":buffer-previous";
        "S-l" = ":buffer-next";
        "}" = "goto_next_paragraph";
        "{" = "goto_prev_paragraph";
      };
    };
    themes = {
      mytheme = {
        inherits = "horizon-dark";
        comment = {
          modifiers = [ "dim" ];
        };
        diagnostic.error.underline = {
          style = "curl";
          color = "red";
        };
      };
    };
    extraPackages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];
  };
}
