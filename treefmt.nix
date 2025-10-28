{
  projectRootFile = "flake.nix";
  settings.global.excludes = [
    ".envrc"
  ];

  programs = {
    beautysh.enable = true;
    fnlfmt = {
      enable = true;
      includes = [ "[^config].fnl" ];
    };
    jsonfmt.enable = true;
    nixfmt.enable = false; # currently failing
    statix.enable = true;
    stylua.enable = true;
  };

  # List of formatters available at https://github.com/numtide/treefmt-nix?tab=readme-ov-file#supported-programs
}
