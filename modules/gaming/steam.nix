{
  flake.modules.nixos.gaming = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        dwproton-bin
      ];
    };

    environment.systemPackages = with pkgs; [ mangohud ];
  };

  flake.modules.homeManager.gaming = {
    home.persist.directories = [
      ".steam"
      ".local/share/Steam"
      ".local/share/vulkan"
    ];
  };
}
