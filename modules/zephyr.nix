{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    openocd
    saleae-logic-2
  ];
  environment.systemPackages = with pkgs; [
    saleae-logic-2
  ];
}
