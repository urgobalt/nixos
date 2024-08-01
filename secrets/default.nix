{...}: {
  secrix.defaultEncryptKeys = {
    wsl = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKMxqQpPWIpQ2eKzoSeGw27tHBB8Yt/cWrpvhs9AB7EB root@wsl"];
    server = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFAqiX2xokcBhY+BDl4yfSqI/M6mOOSgODyINQ2mi7f root@server"];
  };

  secrix.system.secrets.user-password.encrypted.file = ./user-password;
  # secrix.system.secrets.gpg.encrypted.file = ./gpg;
}
