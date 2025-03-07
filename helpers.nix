{ pkgs, lib, specialArgs, ... }:
let

  nixGLMesaWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${lib.getExe pkgs.nixgl.nixGLIntel} $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';

  nixGLVulkanWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${
         lib.getExe pkgs.nixgl.nixVulkanIntel
       } $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';

  nixGLVulkanMesaWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "${lib.getExe pkgs.nixgl.nixGLIntel} ${
         lib.getExe pkgs.nixgl.nixVulkanIntel
       } $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';

  mkOutOfStoreSymlink = path:
    let
      pathStr = toString path;
      name = pkgs.lib.hm.strings.storeFileName (baseNameOf pathStr);
    in pkgs.runCommandLocal name { }
    "ln -s ${pkgs.lib.escapeShellArg pathStr} $out";
  dotLink = path: mkOutOfStoreSymlink "${specialArgs.dotsPath}/${path}";

in {
  nixGLMesaWrap = nixGLMesaWrap;
  nixGLVulkanWrap = nixGLVulkanWrap;
  nixGLVulkanMesaWrap = nixGLVulkanMesaWrap;
  dotLink = dotLink;
}
