{ super, ... }:
{ ... }: {
  imports = [ super.gui.core super.gui.gnome super.network-manager ];
}
