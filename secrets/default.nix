{...}: {
  secrix.defaultEncryptKeys = {
    wsl = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSS+sRSnl0fuUJvQSuXjDSuxoLbAeY8MoApbfwGvVGf lukecastellan165@gmail.com"];
  };

  secrix.system.secrets.user-password.encrypted.file = ./user-password;
  # secrix.system.secrets.gpg.encrypted.file = ./gpg;
}
