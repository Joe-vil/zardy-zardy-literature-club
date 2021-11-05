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

class MainMenuGhost extends FlxState
{
	var whitebg:FlxSprite;
	var blackbg:FlxSprite;
	var text:FlxText;
	var zARDY:FlxSprite;
	var zoomer:FlxSprite;

	var ERROR:FlxSound;

	override public function create()
	{
		FlxG.sound.playMusic(Paths.music('DokiDoki-ghost'));

		ERROR = FlxG.sound.load(Paths.sound('itsOver'));

		whitebg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);

		blackbg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

		zARDY = new FlxSprite(0, 0);
		zARDY.frames = Paths.getSparrowUi('zardy-popup-ghost');
		zARDY.animation.addByPrefix('idle', 'zardy-popups', 24);
		zARDY.antialiasing = true;
		zARDY.x = 355.55;
		zARDY.y = 728.35;

		zoomer = new FlxSprite(0, 0).loadGraphic(Paths.imageui('ZOMMER'));
		zoomer.antialiasing = true;

		text = new FlxText(0, 0, 0, "END", 50);
		text.screenCenter();

		FlxTween.tween(zARDY, {x: 355.55, y: 101.95}, 0.9, {type: ONESHOT, ease: FlxEase.circInOut, startDelay: 8.5});

		add(whitebg);
		add(zARDY);
		add(blackbg);
		add(text);

		new FlxTimer().start(7.5, end);
		new FlxTimer().start(19.5, zoom);
		new FlxTimer().start(20, quit);

		FlxG.camera.fade(FlxColor.BLACK, 3, true);

		super.create();
	}

	function quit(timer:FlxTimer):Void
	{
		System.exit(0);
	}

	function zoom(timer:FlxTimer):Void
	{
		remove(zARDY);
		add(zoomer);
		ERROR.play();
	}

	function end(timer:FlxTimer):Void
	{
		remove(blackbg);
		remove(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
