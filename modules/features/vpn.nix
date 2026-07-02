{
  # Generic OpenVPN client that tunnels through a local Shadowsocks SOCKS5
  # proxy (to get past networks that DPI-block plain OpenVPN).
  #
  # All connection details (remote, certs, proxy target, password) live in
  # untracked runtime files — nothing sensitive is committed here:
  #   ~/.config/openvpn/work.ovpn        (self-contained profile + options)
  #   ~/.config/shadowsocks/work.json    (proxy config, mode 600)
  #
  # Both units autoStart off — bring them up on demand, proxy first:
  #   sudo systemctl start shadowsocks-proxy openvpn-work
  #   sudo systemctl stop  openvpn-work shadowsocks-proxy
  #   journalctl -u openvpn-work -f
  flake.nixosModules.vpn = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.openvpn pkgs.shadowsocks-rust ];

    # Local Shadowsocks SOCKS5 proxy. Runs as root so it can read the mode-600
    # config in the user's home.
    systemd.services.shadowsocks-proxy = {
      description = "Shadowsocks SOCKS5 proxy";
      wantedBy = [ ];
      serviceConfig = {
        ExecStart = "${pkgs.shadowsocks-rust}/bin/sslocal -c /home/gmelika/.config/shadowsocks/work.json";
        Restart = "on-failure";
        RestartSec = 2;
      };
    };

    services.openvpn.servers.work = {
      config = "config /home/gmelika/.config/openvpn/work.ovpn";
      autoStart = false;
    };

    # OpenVPN needs the proxy up first (its config references socks-proxy).
    systemd.services.openvpn-work = {
      after = [ "shadowsocks-proxy.service" ];
      requires = [ "shadowsocks-proxy.service" ];
    };
  };
}
