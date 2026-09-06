{ self, ... }:

{
  perSystem =
    {
      self',
      pkgs,
      lib,
      ...
    }:
    {
      devShells.default =
        let
          devNeovim = self.wrappers.dev.config.wrap { inherit pkgs; };
        in
        pkgs.mkShell {
          packages = [ devNeovim ];
          inputsFrom = [ devNeovim ];
          buildInputs = lib.flatten [
            self'.checks.pre-commit-check.enabledPackages
          ];
          inherit (self'.checks.pre-commit-check) shellHook;
        };
    };
}
