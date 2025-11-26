{
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        arduino-ide
        arduino-cli
      ];
      home.persist = [
        ".arduino15"
        ".arduinoIDE"
        "Arduino"
      ];
    };
}
