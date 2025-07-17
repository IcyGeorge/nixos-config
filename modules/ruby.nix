{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ruby
      bundler
  libffi
  libyaml
  zlib
  openssl
  pkg-config
  gcc
  gnumake
  ];
}
