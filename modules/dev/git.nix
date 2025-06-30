{
  flake.modules.homeManager.dev = {
    programs.git = {
      enable = true;
      userName = "Tiantian Li";
      userEmail = "i@arcohol.com";
      signing = {
        key = null;
        signByDefault = true;
      };
    };
  };
}
