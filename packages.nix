{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
  [
    arp-scan
    audacity
    brasero
    cppcheck
    ddd
    filezilla
    gdb
    gdbgui
    git
    glab
    inetutils
    kdevelop
    libclang
    nmap
    mono
    openssl
    #python27
    wireshark-qt
    tcpdump
    tig
    traceroute
    unzip
    vimHugeX
    zlib
    zstd

    gcc
    gnumake
    pmccabe
    complexity
    binutils
    cflow
    ctags
    ltrace
    strace
    patchelf
    tcptrack
    pkgsCross.muslpi.buildPackages.gcc


    gnome.gedit

    vscodium
    #ghex

    #lint
    #gcov
    #arm gnu tools
    #qnx toolchains
  ];
}
