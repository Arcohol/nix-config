{ username, ... }:

{
  environment.persistence."/persist".users.${username} = import ./users/${username}/persist.nix;
}
