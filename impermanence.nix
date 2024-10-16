{ username, persist-path, ... }:

{
  environment.persistence."${
    persist-path
  }".users.${username} = import ./home/users/${username}/persist.nix;
}
