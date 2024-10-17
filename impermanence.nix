{ username, persistPath, ... }:

{
  environment.persistence."${
    persistPath
  }".users.${username} = import ./home/users/${username}/persist.nix;
}
