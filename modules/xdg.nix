{ config, lib, pkgs, ... }:
with lib;
let
  defaultApps = {
    browser = [ "zen-beta.desktop" ];
    text = [ "org.gnome.TextEditor.desktop" ];
    image = [ "imv-dir.desktop" ];
    audio = [ "mpv.desktop" ];
    video = [ "mpv.desktop" ];
    directory = [ "nemo.desktop" ];
    office = [ "libreoffice.desktop" ];
    pdf = [ "org.gnome.Evince.desktop" ];
    terminal = [ "foot.desktop" ];
    archive = [ "org.gnome.FileRoller.desktop" ];
    discord = [ "webcord.desktop" ];
    slack = [ "slack.desktop" ];
  };

  mimeMap = {
    text = [ "text/plain" ];
    image = [
      "image/bmp"
      "image/gif"
      "image/jpeg"
      "image/jpg"
      "image/png"
      "image/svg+xml"
      "image/tiff"
      "image/vnd.microsoft.icon"
      "image/webp"
    ];
    audio = [
      "audio/aac"
      "audio/mpeg"
      "audio/ogg"
      "audio/opus"
      "audio/wav"
      "audio/webm"
      "audio/x-matroska"
    ];
    video = [
      "video/mp2t"
      "video/mp4"
      "video/mpeg"
      "video/ogg"
      "video/webm"
      "video/x-flv"
      "video/x-matroska"
      "video/x-msvideo"
    ];
    directory = [ "inode/directory" ];
    browser = [
      "text/html"
      "x-scheme-handler/about"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/unknown"
    ];
    office = [
      "application/vnd.oasis.opendocument.text"
      "application/vnd.oasis.opendocument.spreadsheet"
      "application/vnd.oasis.opendocument.presentation"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "application/msword"
      "application/vnd.ms-excel"
      "application/vnd.ms-powerpoint"
      "application/rtf"
    ];
    pdf = [ "application/pdf" ];
    terminal = [ "terminal" ];
    archive = [
      "application/zip"
      "application/rar"
      "application/7z"
      "application/*tar"
    ];
    discord = [ "x-scheme-handler/discord" ];
    slack = [ "x-scheme-handler/slack" ];
  };

  associations =
    with lists;
    listToAttrs (
      flatten (
        mapAttrsToList
          (
            key: map (type: attrsets.nameValuePair type defaultApps."${key}")
          )
          mimeMap
      )
    );
in
{

  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.niri-unstable ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };


  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  home-manager.users.${config.var.username} = {
    xdg.configFile."mimeapps.list".force = true;
    xdg.mimeApps.enable = true;
    xdg.mimeApps.associations.added = associations;
    xdg.mimeApps.defaultApplications = associations;

    home.sessionVariables = {
      # prevent wine from creating file associations
      WINEDLLOVERRIDES = "winemenubuilder.exe=d";
    };
  };
}
