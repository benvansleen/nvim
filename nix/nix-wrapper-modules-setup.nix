inputs:
{
  config,
  wlib,
  lib,
  ...
}:
{
  imports = [
    wlib.wrapperModules.neovim
  ];

  options = {
    settings.cats = lib.mkOption {
      readOnly = true;
      type = lib.types.attrsOf lib.types.bool;
      default = builtins.mapAttrs (_: v: v.enable) config.specs;
    };

    nvim-lib = {
      neovimPlugins = lib.mkOption {
        readOnly = true;
        type = lib.types.attrsOf wlib.types.stringable;
        default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
      };

      pluginsFromPrefix = lib.mkOption {
        type = lib.types.raw;
        readOnly = true;
        default =
          prefix: inputs:
          lib.pipe inputs [
            builtins.attrNames
            (builtins.filter (s: lib.hasPrefix prefix s))
            (map (
              input:
              let
                name = lib.removePrefix prefix input;
              in
              {
                inherit name;
                value = config.nvim-lib.mkPlugin name inputs.${input};
              }
            ))
            builtins.listToAttrs
          ];
      };
    };
  };

  config = {
    specMods =
      {
        parentSpec ? null,
        parentOpts ? null,
        parentName ? null,
        config,
        ...
      }:
      {
        options.runtimePkgs = lib.mkOption {
          type = lib.types.listOf wlib.types.stringable;
          default = [ ];
          description = "a runtimePkgs spec field to put packages to suffix to the PATH";
        };
      };
    runtimePkgs = config.specCollect (acc: v: acc ++ (v.runtimePkgs or [ ])) [ ];

  };
}
