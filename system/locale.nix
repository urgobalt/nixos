{
  pkgs,
  lib,
  ...
}: {
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
    keyMap = "sv-latin1";
  };

  time.timeZone = lib.mkDefault "Europe/Stockholm";

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["SourceCodePro"];})
    ];

    fontconfig.defaultFonts = {
      serif = [
        "SourceCodePro Nerd Font"
      ];
      sansSerif = [
        "SauceCodePro Nerd Font"
      ];
      monospace = [
        "SauceCodePro Nerd Font"
      ];
    };
  };
}
