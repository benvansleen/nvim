{ inputs, self, ... }:

{
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem =
    {
      self',
      config,
      pkgs,
      ...
    }:
    {
      overlayAttrs = {
        inherit (config.packages) neovim;
      };

      packages = {
        neovim = self.wrappers.neovim.config.wrap { inherit pkgs; };
        default = self'.packages.neovim;
      };
    };
}
