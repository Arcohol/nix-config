{
  flake.modules.homeManager.development = { lib, pkgs, ... }: {
    programs.git = {
      enable = true;
      ignores = lib.optionals pkgs.stdenv.hostPlatform.isDarwin [ ".DS_Store" ];
      signing = {
        key = null;
        signByDefault = true;
      };
    };
  };
}
