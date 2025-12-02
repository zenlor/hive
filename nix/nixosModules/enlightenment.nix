{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    enlightenment.enlightenment
    enlightenment.econnman
    enlightenment.ecricre
    enlightenment.efl
    enlightenment.evisum
    enlightenment.rage
    enlightenment.terminology
  ];
}
