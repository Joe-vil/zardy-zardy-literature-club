package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var watermarks = true;
	public static var fpsVar:FPS;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MainMenu));

		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		if (fpsVar != null)
		{
			fpsVar.visible = SettingsPrefs.showfps;
		}
		if (SettingsPrefs.fullscreen)
		{
			FlxG.fullscreen = true;
		}
	}

	#if (VIDEOS_ALLOWED && windows)
	override public function onFocus():Void
	{
		FlxVideo.onFocus();
		super.onFocus();
	}

	override public function onFocusLost():Void
	{
		FlxVideo.onFocusLost();
		super.onFocusLost();
	}
	#end
}
