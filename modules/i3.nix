{ pkgs, lib, config, ... }:
let
  background = "${../resources/sf-2024-1.png}";
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
      # Set background for current session and lockscreen
      {
        command = "${pkgs.feh}/bin/feh --bg-fill ${background}";
        always = true;
      }
      {
        command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ${background} --fx blur";
        always = true;
      }

      # XFCE power manager and screensaver
      {
        command = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/logind-handle-lid-switch -s true";
        always = false;
      }
      {
        command = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xfce4-screensaver -p /lock/enabled -s false";
        always = false;
      }
      {
        command = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xfce4-screensaver -p /saver/enabled -s false";
        always = false;
      }
      {
        command = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-enabled -s false";
        always = false;
      }
      {
        command = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lock-screen-suspend-hibernate -s false";
        always = false;
      }

      {
        command = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/general-notification -s true";
        always = false;
      }
      {
        command = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/show-tray-icon -s true";
        always = false;
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

        "${modifier}+v" = "split v";
        "${modifier}+g" = "split h";

        # Lockscreen with suspend after 10 minutes
        "${modifier}+Shift+x" = "exec ${pkgs.xautolock}/bin/xautolock -locknow";

        # Lockscreen with immediate suspend
        "${modifier}+Shift+semicolon" = "exec ${pkgs.betterlockscreen}/bin/betterlockscreen -l blur & sleep 5 && ${pkgs.systemd}/bin/systemctl suspend";

        # Logout with XFCE
        "${modifier}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' '${pkgs.xfce.xfce4-session}/bin/xfce4-session-logout'\"";
      };

    window.border = 0;
    window.commands = [
      # { command = "border pixel 1"; }
    ];

  };
}

