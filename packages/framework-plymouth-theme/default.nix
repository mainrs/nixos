{ config, lib, pkgs, ... }:

with lib;

pkgs.stdenvNoCC.mkDerivation {
  pname = "framework-plymouth";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "mainrs";
    repo = "framework-plymouth-theme";
    rev = "0539cadc7940ace3b3a1d5b9ffc0aa231fd8256d";
    sha256 = "sha256-DUH1S+t//GNJiPXma3fWqQgdAgQ7+hCJIOEK3yX/Xfo=";
  };

  installPhase = ''
    runHook preInstall

    # Replaces the /usr prefix with the output path.
    sed -i 's:\(^ImageDir=\)/usr:\1'"$out"':' framework.plymouth
    sed -i 's:\(^ScriptFile=\)/usr:\1'"$out"':' framework.plymouth

    mkdir -p $out/share/plymouth/themes/framework
    cp *.png framework.script framework.plymouth license readme.md $out/share/plymouth/themes/framework

    runHook postInstall
  '';

  meta = with lib; {
    description = "Plymouth theme for Framework laptops";
    homepage = "https://github.com/mainrs/framework-plymouth-theme";
    license = licenses.eupl12;
    platforms = platforms.linux;
  };
}
