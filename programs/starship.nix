{...}: {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        format = "$username$directory$character";
	right_format = "$time";

	username = {
	  disabled = false;
	  show_always = true;
	  format = "[$user]($style) ";
	};

	directory = {
	  disabled = false;
	  read_only = " ";
	  home_symbol=" ";
	};

	time = {
	  disabled = false;
	  format = "[$time]($style)";
	};
      };
    };
}
