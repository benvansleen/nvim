{ inputs, ... }:

{
  systems = inputs.nixpkgs.lib.systems.flakeExposed;

  perSystem =
    {
      lib,
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "copilot-language-server"
            "replace"
          ];

        overlays = [
          (
            final: prev:
            let
              lisetteSrc = final.fetchFromGitHub {
                owner = "ivov";
                repo = "lisette";
                rev = "95a48ce2ccbc6b376275427a885ee8a058d173b8";
                hash = "sha256-l5md6x/J7K0qXTvdiAeNvfvLor2lDtZoyVzb3thGcVQ=";
              };
            in
            {
              lisetteTreesitterGrammar = final.tree-sitter.buildGrammar {
                language = "lisette";
                version = "0.1.0";
                src = "${lisetteSrc}/editors/tree-sitter-lisette";
                generate = false;
              };

              vimPlugins = prev.vimPlugins // {
                lisette-nvim = final.vimUtils.buildVimPlugin {
                  pname = "lisette-nvim";
                  version = "0-unstable-2026-09-06";
                  src = lisetteSrc;
                };
                refer-nvim = final.vimUtils.buildVimPlugin {
                  pname = "refer.nvim";
                  version = "0-unstable-2026-08-19";

                  src = final.fetchFromGitHub {
                    owner = "juniorsundar";
                    repo = "refer.nvim";
                    rev = "7ab4781bc1343cfacc72cc46f6600b4d934d2485";
                    hash = "sha256-nQfea2GXytkoKVez/oLy9vG46t8vzedT3GI6hIjZkzA=";
                  };

                  patches = [
                    ./patches/refer-find-file.patch
                    ./patches/refer-hide-count.patch
                  ];
                };
              };
            }
          )
        ];
      };
    };
}
