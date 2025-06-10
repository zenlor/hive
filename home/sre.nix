{ ... }: { pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2 # the worst official aws cli
    pre-commit # overengineered frameworks for simple things :facepalm:
    saml2aws # samling on aws over and over
    terraform-docs # documentation for terraform things
    terraform-ls # lsp for terraformation

    # kubernetes
    kubetui
    kubectl
    kubelogin-oidc
  ];

  programs.k9s = {
    enable = true;    
    settings = {
      k9s = {
        skin = "default";
        ui = {
          enableMouse = true;
          headless = true;
          logoless = true;
        };
        skipLatestRevCheck = true;
        
      };
    };
  };
}
