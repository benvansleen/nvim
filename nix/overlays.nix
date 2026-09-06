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
      };
    };
}
