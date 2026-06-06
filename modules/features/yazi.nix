{ config, pkgs, ... }:
{
  flake.nixosModules.yazi = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      yazi
      ffmpegthumbnailer
      unar
      jq
      poppler
      fd
      ripgrep
      zoxide
    ];

    programs.zsh.shellInit = ''
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        cwd="$(cat "$tmp")"

        if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
          cd "$cwd"
        fi

        rm -f "$tmp"
      }
    '';

    hjem.users.gmelika.files.".config/yazi".source = ../../dots/.config/yazi;
  };
}
