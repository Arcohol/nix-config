{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        enableDefaultPackages = false;
        packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji
          sarasa-gothic
          inter
        ];
        fontconfig = {
          defaultFonts = {
            emoji = [ "Noto Color Emoji" ];
            monospace = [
              "Sarasa Mono Slab SC"
              "Sarasa Mono Slab TC"
              "Sarasa Mono Slab J"
            ];
            sansSerif = [
              "Inter"
              "Noto Sans CJK SC"
              "Noto Sans CJK TC"
              "Noto Sans CJK JP"
            ];
            serif = [
              "Noto Serif"
              "Noto Serif CJK SC"
              "Noto Serif CJK TC"
              "Noto Serif CJK JP"
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

              <selectfont>
                <rejectfont>
                  <pattern>
                    <patelt name="family"><string>DejaVu Sans</string></patelt>
                  </pattern>
                </rejectfont>
              </selectfont>
            </fontconfig>
          '';
        };
      };
    };
}
