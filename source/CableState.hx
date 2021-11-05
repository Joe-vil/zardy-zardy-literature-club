package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.system.System;

class CableState extends FlxState
{
	var zoomer:FlxSprite;

	override public function create()
	{
		FlxG.sound.playMusic(Paths.music('Sayo-nara'));

		zoomer = new FlxSprite(0, 0).loadGraphic(Paths.endings('cableending'));
		zoomer.antialiasing = true;

		add(zoomer);

		FlxG.camera.fade(FlxColor.WHITE, 3, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.camera.fade(FlxColor.WHITE, 1, false, function()
			{
				FlxG.switchState(new MainMenu());
			});
		}
	}
}
