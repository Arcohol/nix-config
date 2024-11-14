{ username, ... }:

{
  environment.persistence."/persist".users.${username} = import ./home/users/${username}/persist.nix;
}
