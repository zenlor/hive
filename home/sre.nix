{ ... }:
{ pkgs, ... }: {
  packages = with pkgs; [
    awscli2 # the worst official aws cli
    k9s # nicer kubectl
    pre-commit # overengineered frameworks for simple things :facepalm:
    saml2aws # samling on aws over and over
    terraform-docs # documentation for terraform things
    terraform-ls # lsp for terraformation
  ];
}
