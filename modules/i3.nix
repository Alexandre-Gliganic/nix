{ pkgs, lib, config, ... }:
let
  background = builtins.toString ../f1.png;
  gaps = {
    inner = 12;
    outer = -12;
  };
in
{

  enable = true;
  extraConfig = ''
    default_border pixel 0
    default_floating_border pixel 0
    for_window [class=".*"] border_radius 12
    exec i3-msg workspace 1
  '';
  config = {
    modifier = "Mod4";
    startup = [
      {
        command = "${pkgs.feh}/bin/feh --bg-fill ${background}";
        always = true;
      }
      {
        command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ${background}";
        always = true;
      }
    ];

    gaps = gaps;

    terminal = "kitty";

    keybindings =
      let modifier = config.xsession.windowManager.i3.config.modifier;
      in lib.mkOptionDefault {
        # screenshot
        "${modifier}+Shift+s" = "exec ${pkgs.flameshot}/bin/flameshot gui";
        "${modifier}+Shift+r" = "mode resize";
        "${modifier}+Ctrl+Shift+r" = "restart";

        "${modifier}+l" = "focus right";
        "${modifier}+k" = "focus up";
        "${modifier}+j" = "focus down";
        "${modifier}+h" = "focus left";

        "${modifier}+Shift+l" = "move right";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+h" = "move left";

        "${modifier}+Ctrl+Shift+l" = "move workspace to output right";
        "${modifier}+Ctrl+Shift+k" = "move workspace to output up";
        "${modifier}+Ctrl+Shift+j" = "move workspace to output down";
        "${modifier}+Ctrl+Shift+h" = "move workspace to output left";


        "${modifier}+Shift+x" = "exec ${pkgs.betterlockscreen}/bin/betterlockscreen -l blur --off 480";

        "${modifier}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'xfce4-session-logout'\"";
      };

    window.border = 0;
    window.commands = [
      # { command = "border pixel 1"; }
    ];

  };
}

