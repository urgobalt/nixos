{user, ...}: {
  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key" "/home/${user}/.ssh/id_ed25519"];

  age.secrets.user-password.file = ./user-password.age;
  age.secrets.wifi-env.file = ./wifi-env.age;
}
