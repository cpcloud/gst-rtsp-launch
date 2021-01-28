let
  pkgs = import <nixpkgs> { };
  buildServer = pkgs.writeShellScriptBin "build_server" ''
    set -euo pipefail

    FLAGS=($(${pkgs.pkg-config}/bin/pkg-config \
      --cflags \
      --libs glib-2.0 gstreamer-rtsp-server-1.0 gstreamer-1.0 gstreamer-plugins-base-1.0))

    ${pkgs.clang_11}/bin/clang++ ''${FLAGS[@]} -O3 src/gst-rtsp-launch.cpp -o gst-rtsp-launch
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
    buildServer
  ];
}
