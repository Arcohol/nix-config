{
  flake.modules.nixos.nvidia =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest.overrideAttrs (old: {
          passthru = old.passthru // {
            open = old.passthru.open.overrideAttrs (old': {
              patches =
                (old'.patches or [ ])
                ++ lib.singleton (
                  pkgs.fetchpatch {
                    url = "https://github.com/CachyOS/CachyOS-PKGBUILDS/raw/d5629d64ac1f9e298c503e407225b528760ffd37/nvidia/nvidia-utils/kernel-6.19.patch";
                    hash = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
                  }
                );
            });
          };
        });
      };
    };
}
