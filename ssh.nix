let
  wsl = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSS+sRSnl0fuUJvQSuXjDSuxoLbAeY8MoApbfwGvVGf";
  pi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFAqiX2xokcBhY+BDl4yfSqI/M6mOOSgODyINQ2mi7f";
  lenovo-laptop-320 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQlHvosfQFeQGsV7EzBN39BBhf1Q3RzAE2qyRj5PtyU";
in {
  inherit wsl pi lenovo-laptop-320;
  users = [wsl lenovo-laptop-320];
  systems = [pi];
}
