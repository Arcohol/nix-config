{
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ arduino-cli ];
      home.persist = [
        ".arduino15"
        "Arduino"
      ];
    };
}
