let
  ssh = import ../ssh.nix;
  default = ssh.users ++ ssh.systems;
in
  with ssh; {
    "user-password.age".publicKeys = default;
    "wifi-env.age".publicKeys = default;
    "nix-access-tokens.age".publicKeys = default;
    "eduroam-pem.age".publicKeys = default;

    # Email
    "personal-email.age".publicKeys = ssh.users;
    "professional-email.age".publicKeys = ssh.users;
    # "nygren-email.age".publicKeys = ssh.users;
  }
