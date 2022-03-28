package;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

class LoadSavePrefs
{
	public static var save1:Int = 0;
	public static var save2:Int = 0;
	public static var save3:Int = 0;
	public static var save4:Int = 0;
	public static var save5:Int = 0;
	public static var save6:Int = 0;

	public static function saveSettings()
	{
		FlxG.save.data.save1 = save1;
		FlxG.save.data.save2 = save2;
		FlxG.save.data.save3 = save3;
		FlxG.save.data.save4 = save4;
		FlxG.save.data.save5 = save5;
		FlxG.save.data.save6 = save6;

		FlxG.save.flush();
	}

	public static function loadPrefs()
	{
		if (FlxG.save.data.save1 != null)
		{
			save1 = FlxG.save.data.save1;
		}

		if (FlxG.save.data.save2 != null)
		{
			save2 = FlxG.save.data.save2;
		}

		if (FlxG.save.data.save3 != null)
		{
			save3 = FlxG.save.data.save3;
		}

		if (FlxG.save.data.save4 != null)
		{
			save4 = FlxG.save.data.save4;
		}

		if (FlxG.save.data.save5 != null)
		{
			save5 = FlxG.save.data.save5;
		}

		if (FlxG.save.data.save6 != null)
		{
			save6 = FlxG.save.data.save6;
		}
	}
}
