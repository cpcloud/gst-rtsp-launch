let
  pkgs = import <nixpkgs> { };
  getFlags = pkgs.writeShellScriptBin "get_flags" ''
    set -euo pipefail

    ${pkgs.pkg-config}/bin/pkg-config \
      --cflags \
      --libs glib-2.0 gstreamer-rtsp-server-1.0 gstreamer-1.0 gstreamer-plugins-base-1.0
  '';
in
pkgs.mkShell {
  name = "gst-rtsp-server-shell";
  buildInputs = with pkgs; with gst_all_1; [
    gst-devtools
    gst-rtsp-server
    gstreamer
    gstreamer.dev
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-plugins-base
    pkg-config
    cmake
    clang
    getFlags
  ];
}
