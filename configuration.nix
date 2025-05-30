# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disko.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ];

        hardware.nvidia.prime = {
                # Make sure to use the correct Bus ID values for your system!
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
                # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
                    sync.enable = true;
     };



              nixpkgs.config.permittedInsecurePackages = [
                "electron-27.3.11"
              ];




  services.i2pd = {
enable = true;
websocket.enable = true;


};

programs.neovim = {
  enable = true;
  defaultEditor = true;
};


  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

 
        #sunshine
      services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    
  };


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


  # Enable bluetooth

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
   
  # Set your time zone.
  time.timeZone = "Asia/Yakutsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;

  #kde
  
#  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gleb = {
    isNormalUser = true;
    description = "gleb";
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd"  ];
    packages = with pkgs; [   
 ];
  };

  # Install firefox.
  programs.firefox.enable = false;

 programs.steam = {
enable = true;
remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
}; 
 programs.git = {
        enable = true;
};

  #unfree packages
  nixpkgs.config.allowUnfree = true;



programs.virt-manager.enable = true;

users.groups.libvirtd.members = ["gleb"];

virtualisation.libvirtd.enable = true;

virtualisation.spiceUSBRedirection.enable = true;





  # List packages installed in system profile. To search, run:
  # $ nix search wget #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  


  environment.systemPackages = with pkgs; [
          telegram-desktop
          fastfetch
          btop
          nekoray
          gnumeric 
          usbutils
          legcord
          hyfetch
          gnupg
          pciutils
          unrar
          p7zip
          unp
          gcdemu
          wineWowPackages.waylandFull
          asciiquarium
          qbittorrent
          qdirstat
          gimp
          bottles
          krita  
          powertop
          monero-cli
          i2pd
          floorp
          gcc
          texlive.combined.scheme-full
          orca-c
          alsa-utils
          fluidsynth
          obs-studio
          ffmpeg
          yabridge
          reaper
          micro
          SDL2
          uxn
          onlyoffice-desktopeditors
          ghostty
          logseq
          obsidian
          mars-mips
          openjdk
          qtspim
          xspim   
                             ]; 
  #tailscale
  services.tailscale = {
  enable = true;
  };

  #otd
  hardware.opentabletdriver.enable = true;
  

  #gvfs
  services.gvfs.enable = true;


   virtualisation.virtualbox.host.enable = true;
   virtualisation.virtualbox.host.enableExtensionPack = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}


