{ config, lib, pkgs, utils, ... }:
with lib;

let
  availablePatches = import ../../../livepatches/availablePatches.nix;

  kernel = pkgs.callPackage (import ../../../packages/linux/default.nix) {};

  buildLivePatch = { patchName, stdenv }:
    stdenv.mkDerivation rec {
      pname = "livepatch-${kernel.modDirVersion}-${patchName}";
      version = "1";
      src = ../../../livepatches;

      configurePhase = ''
        echo configurePhase; pwd; ls; pwd; echo;
        mkdir ${patchName}
        cp $src/${patchName}.c ${patchName}/livepatch-${patchName}.c
        echo 'obj-m += livepatch-${patchName}.o' > ${patchName}/Makefile
      '';
      buildPhase = ''
        echo buildPhase; pwd; ls; pwd;
        cd ${patchName}
        make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
          -j$NIX_BUILD_CORES M=$(pwd) modules
      '';

      installPhase = ''
        make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build  \
          INSTALL_MOD_PATH=$out M=$(pwd) modules_install
      '';
    };

  insmodLineGen = patchName:
    let
      dirName = builtins.replaceStrings ["-"] ["_"] patchName;

      patch = pkgs.callPackage buildLivePatch {
        patchName = patchName;
        kernel = kernel;
      };

      ko = "${patch}/lib/modules/${kernel.modDirVersion}/extra/livepatch-${patchName}.ko";
    in "[ -d /sys/kernel/livepatch/${dirName} ] || insmod ${ko}.*";
in
{
  options = {
    enabled = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable/disable Live Patching
      '';
    };
  };
  config = {
    runit.services.livepatches = {
      run = concatMapStringsSep "\n" insmodLineGen availablePatches;
      oneShot = true;
      runlevels = [ "default" ];
    };
  };
}

