let
  wsl = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSS+sRSnl0fuUJvQSuXjDSuxoLbAeY8MoApbfwGvVGf";
  pi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFAqiX2xokcBhY+BDl4yfSqI/M6mOOSgODyINQ2mi7f";
  lenovo-laptop-320 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQlHvosfQFeQGsV7EzBN39BBhf1Q3RzAE2qyRj5PtyU";
  stationary-home-computer = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJwXUMx7sohcQjhVYU1s61BjaJFtlyIw37xqEVrr0nU";
  asus-tuf-gaming-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeT85lN+faD0o47WhMX00ItN6cTD4Rgz8PzsQiGIAPq";
in {
  inherit wsl pi lenovo-laptop-320 stationary-home-computer asus-tuf-gaming-laptop;
  users = [wsl lenovo-laptop-320 stationary-home-computer asus-tuf-gaming-laptop];
  systems = [pi];
}
