{
  flake.modules.homeManager.development = {
    programs.git = {
      enable = true;
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
