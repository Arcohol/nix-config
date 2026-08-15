{
  flake.modules.homeManager.development = { lib, pkgs, ... }: {
    programs.git = {
      enable = true;
      ignores = lib.optionals pkgs.stdenv.hostPlatform.isDarwin [ ".DS_Store" ];
      settings = {
        user.name = "Tiantian Li";
        user.email = "i@arcohol.com";
      };
      signing = {
        key = null;
        signByDefault = true;
      };
    };
  };
}
