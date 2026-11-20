{
  flake.modules.nixos.gaming = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
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
