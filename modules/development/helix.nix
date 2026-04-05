{
  flake.modules.homeManager.development =
    { inputs, pkgs, ... }:
    {
      programs.helix = {
        enable = true;
        package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.default;
        settings = {
          theme = "catppuccin_mocha";
          editor = {
            auto-save = {
              after-delay.enable = true;
              after-delay.timeout = 1000;
            };
          };
          keys.normal = {
            "C-S-i" = ":format";
          };
        };
      };
    };
}
