{ username, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ username ];
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
}
