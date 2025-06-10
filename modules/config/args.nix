{delib, ...}:
delib.module {
  name = "args";

  options.args = with delib; {
    shared = attrsLegacyOption {};
    nixos = attrsLegacyOption {};
    home = attrsLegacyOption {};
    darwin = attrsLegacyOption {};
  };

  nixos.always = {cfg, ...}: {
    imports = [
      {_module.args = cfg.shared;}
      {_module.args = cfg.nixos;}
    ];
  };
  home.always = {cfg, ...}: {
    imports = [
      {_module.args = cfg.shared;}
      {_module.args = cfg.home;}
    ];
  };
  darwin.always = {cfg, ...}: {
    imports = [
      {_module.args = cfg.shared;}
      {_module.args = cfg.darwin;}
    ];
  };
}
