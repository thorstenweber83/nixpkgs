/*
  build with:

  nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=./sd-image_ready-with-wifi-and-sshd.nix --argstr system aarch64-linux

*/
{lib, ...}:
{
   imports = [
    # <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-raspberrypi4.nix>
    ./sd-image-raspberrypi4.nix
  ];
  # put your own configuration here, for example ssh keys:
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICtlSYdFwf1WAzCeQNH3MmKBX3JpcTYiPaAUf1QG/qFB cpt.chaos83@googlemail.com-2019-06-20"
  ];

  networking = {
    wireless.enable = true;
    wireless.networks.wifi = {
      psk = "<wifi password goes here>";
    };

    useDHCP = true;
  };

  # make sure wifi comes up automatically
  systemd.services.wpa_supplicant.wantedBy = lib.mkForce [ "multi-user.target" ];
  
  # make sure sshd comes up
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
}
