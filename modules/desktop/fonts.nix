{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        (iosevka.override {
          set = "Custom";
          privateBuildPlan = {
            family = "Iosevka Custom";
            spacing = "fontconfig-mono";
            serifs = "slab";
            noCvSs = true;
            exportGlyphNames = true;
          };
        })
        sarasa-gothic
        hack-font
        inter
        ibm-plex
      ];

      fonts.fontconfig = {
        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          monospace = [
            "Iosevka Custom"
            "Hack"
            "IBM Plex Mono"
          ];
          sansSerif = [
            "Inter"
            "Noto Sans CJK SC"
            "Noto Sans CJK TC"
          ];
          serif = [
            "Noto Serif"
            "Noto Serif CJK SC"
            "Noto Serif CJK TC"
          ];
        };
        localConf = ''
          <fontconfig>
          <match target="pattern">
            <test qual="any" name="family"><string>Arial</string></test>
            <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family"><string>PingFang SC</string></test>
            <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family"><string>Microsoft Sans Serif</string></test>
            <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
          </match>
          <match>
            <test compare="contains" name="lang">
            <string>zh_CN</string>
            </test>
            <edit mode="prepend" name="family">
            <string>Noto Sans CJK SC</string>
            </edit>
          </match>
          </fontconfig>
        '';
      };
    };

  flake.modules.homeManager.desktop = {
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Iosevka Custom"
          "Hack"
          "IBM Plex Mono"
        ];
        sansSerif = [
          "Inter"
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
        ];
        serif = [
          "Noto Serif"
          "Noto Serif CJK SC"
          "Noto Serif CJK TC"
        ];
      };
    };
  };
}
