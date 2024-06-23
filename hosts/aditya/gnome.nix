{
  config,
  pkgs,
  ...
}: {
  environment = {
    sessionVariables = {
      NAUTILUS_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
    };

    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    systemPackages = with pkgs; [
      gnome-extension-manager
      nautilus-open-any-terminal
      morewaita-icon-theme
      bibata-cursors
      rubik
      lexend
      gnome.nautilus-python
      twitter-color-emoji
      cheese # webcam tool
      gnome.gnome-music
      gnome.epiphany # web browser
      gnome.geary # email reader
      gnome.evince # document viewer
      gnome.gnome-characters
      gnome.totem # video player
      gnome.hitori # sudoku game
      gnome.atomix # puzzle game
      gnome.yelp # Help view
      gnome.gnome-contacts
      gnome.gnome-initial-setup
      gnome.gnome-shell-extensions
      gnome.gnome-maps
      gnome.gnome-font-viewer
    ];

    gnome.excludePackages =
      (with pkgs; [
        gedit # text editor
        gnome-photos
        gnome-tour
        gnome-connections
        snapshot
      ])
      ++ (with pkgs.gnome; [
        
      ]);
  };
}
