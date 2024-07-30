{pkgs, ...}: {
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "se";
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FantasqueSansMono"];})
    ];

    fontconfig.defaultFonts = {
      serif = [
        "FantasqueSansM Nerd Font"
      ];
      sansSerif = [
        "FantasqueSansM Nerd Font"
      ];
      monospace = [
        "FantasqueSansM Nerd Font Mono"
      ];
    };
  };
}
