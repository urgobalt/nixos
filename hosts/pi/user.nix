{pkgs, ...}: {
  modules = {
  };

  home.packages = with pkgs; [
    lazydocker
  ];
}
