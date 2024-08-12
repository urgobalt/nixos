{
  user,
  agenix,
  pkgs,
  ...
}: {
  networking.hostName = "wsl";
  environment.variables.BROWSER = "wslview";

  wsl.enable = true;
  wsl.defaultUser = user;

  environment.systemPackages = with pkgs; [
    agenix.packages.x86_64-linux.default
    wslu
    wsl-open
  ];
}
