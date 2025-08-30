{ super, ... }:
{ ... }: {
  imports = [
    super.gui.core
    super.gui.gnome
    super.gui.software
    super.network-manager
    super.gui.steam
  ];
}
