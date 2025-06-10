{delib, ...}:
delib.module {
  name = "sysctl";

  nixos.always = {
    boot.kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
      "fs.file-max" = 2147483642;
    };
  };
}
