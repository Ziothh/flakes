{ config, pkgs, user, ... }:
let 
in
{
  users.users = {
    ${user} = {
      name = "${user}";
      home = "/Users/${user}";
    };
  };
}
