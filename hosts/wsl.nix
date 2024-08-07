{
  user,
  agenix,
  ...
}: {
  networking.hostName = "wsl";
  environment.variables.BROWSER = "wslview";

  wsl.enable = true;
  wsl.defaultUser = user;

  environment.systemPackages = [agenix.packages.x86_64-linux.default];
}
