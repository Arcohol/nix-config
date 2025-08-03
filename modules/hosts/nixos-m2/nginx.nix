{
  flake.modules.nixos."hosts/nixos-m2" = {
    networking.firewall = {
      allowedTCPPorts = [
        80
        443
      ];
    };

    services.nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedProxySettings = true;
      virtualHosts."majsoul-stats.arcohol.com" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:3000";
        };
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "i@arcohol.com";
    };

    preservation.preserveAt."/persist".directories = [ "/var/lib/acme" ];
  };
}
