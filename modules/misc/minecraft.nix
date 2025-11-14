{ inputs, ... }:
{
  flake.modules.nixos.minecraft =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
      nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

      services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        # servers.paper = {
        #   enable = true;
        #   package = pkgs.paper-server;
        #   jvmOpts = "-Xmx6G -Xms2G";
        # };
        servers.fabric = {
          enable = true;
          package = pkgs.fabric-server;
          jvmOpts = "-Xmx6G -Xms2G";
        };
      };

      preservation.preserveAt."/persist".directories = [
        {
          directory = "/srv/minecraft";
          user = "minecraft";
          group = "minecraft";
        }
      ];
    };
}
