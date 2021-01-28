let
  pkgs = import <nixpkgs> { };
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
  ];
}
