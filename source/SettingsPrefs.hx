package;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

class SettingsPrefs
{
	public static var antialiasing:Bool = true;
	public static var fullscreen:Bool = false;
	public static var showfps:Bool = false;
	public static var lowquality:Bool = false;

	public static function saveSettings()
	{
		FlxG.save.data.antialiasing = antialiasing;
		FlxG.save.data.fullscreen = fullscreen;
		FlxG.save.data.showfps = showfps;
		FlxG.save.data.showfps = lowquality;

		FlxG.save.flush();
	}

	public static function loadPrefs()
	{
		if (FlxG.save.data.antialiasing != null)
		{
			antialiasing = FlxG.save.data.antialiasing;
		}

		if (FlxG.save.data.fullscreen != null)
		{
			fullscreen = FlxG.save.data.fullscreen;
		}

		if (FlxG.save.data.showfps != null)
		{
			showfps = FlxG.save.data.showfps;
		}

		if (FlxG.save.data.lowquality != null)
		{
			showfps = FlxG.save.data.showfps;
		}

		if (FlxG.save.data.volume != null)
		{
			FlxG.sound.volume = FlxG.save.data.volume;
		}

		if (FlxG.save.data.mute != null)
		{
			FlxG.sound.muted = FlxG.save.data.mute;
		}
	}
}
