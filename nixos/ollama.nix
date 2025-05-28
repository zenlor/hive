{ ... }: {
  services.ollama = {
    enable = true;
    loadModels = [ "qwen3:8b" "qwen3:4b" "deepseek-r1:7b" "deepseek-coder-v2:16b" ];
    acceleration = "cuda";
  };
}
