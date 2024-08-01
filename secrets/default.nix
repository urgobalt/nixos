{ssh, ...}: {
  secrix.defaultEncryptKeys = {
    wsl = [ssh.wsl];
    server = [ssh.server];
  };

  secrix.system.secrets.user-password.encrypted.file = ./user-password;
  # secrix.system.secrets.gpg.encrypted.file = ./gpg;
  secrix.services.wpa_supplicant.secrets.wifi-env.encrypted.file = ./wifi-env;
}
