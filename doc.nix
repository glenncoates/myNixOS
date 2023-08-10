{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-minimal
        scheme-basic
        latexmk
        metafont
        pgf-umlsd
        listings
        preprint
        cleveref
        appendix
        pdflscape
        fancyvrb
        dirtree;
      })

      ispell
      aspellDicts.en
      aspellDicts.en-computers
      plantuml
      texmaker
      #mermaid
  ];
}

