{ lib, ... }:

with lib; rec {
  mkCopierTemplate = { name, src, dst, ... }:
    let
      srcPath = "${src}/${name}";
      dstPath = "${dst}/${name}";
    in
    {
      name = name;
      src = srcPath;
      dst = dstPath;
      copy = ''
        mkdir -p ${dst}
        cp -r ${src} ${dst}
      '';
    };
}
