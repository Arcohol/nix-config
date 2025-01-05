{ pkgs, ... }:

{
  programs.mininet.enable = true;
  environment.systemPackages = with pkgs; [
    inetutils # telnet
    iperf2 # iperf
    wireshark
  ];
}
