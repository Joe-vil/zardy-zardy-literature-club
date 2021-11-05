package;

import VideoTest;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.system.System;

class MainMenu extends FlxState
{
	var bgdots:FlxBackdrop;

	private var mosueoverbuttionsshit:Bool = true;

	var hoversound:FlxSound;
	var entersound:FlxSound;

	var whitebg:FlxSprite;
	var menubar:FlxSprite;
	var creds:FlxSprite;
	var zARDY:FlxSprite;
	var logo:FlxSprite;

	var playbutton:FlxSprite;
	var exit:FlxSprite;

	var introActive:Bool = true;

	override public function create()
	{
		FlxG.sound.playMusic(Paths.music('zardy zardy'));

		hoversound = FlxG.sound.load(Paths.sound('hover'));
		entersound = FlxG.sound.load(Paths.sound('enter'));

		whitebg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);

		bgdots = new FlxBackdrop(Paths.imageui('bg-dots'), 0, 0, true, true, 100, 100);
		bgdots.x = 5120;
		bgdots.y = 2880;

		zARDY = new FlxSprite(0, 0);
		zARDY.frames = Paths.getSparrowUi('zardy-popup');
		zARDY.animation.addByPrefix('idle', 'zardy-popups', 24);
		zARDY.animation.play('idle');
		zARDY.antialiasing = true;
		zARDY.x = 355.55;
		zARDY.y = 728.35;

		creds = new FlxSprite(0, 0).loadGraphic(Paths.imageui('introcred'));
		creds.antialiasing = true;
		creds.x = 0;
		creds.y = -720;

		logo = new FlxSprite(0, 0).loadGraphic(Paths.imageui('ZARDY-ZARDY'));
		logo.antialiasing = true;
		logo.x = 135.1;
		logo.y = -305.9;

		menubar = new FlxSprite(0, 0).loadGraphic(Paths.imageui('menu-bar'));
		menubar.antialiasing = true;
		menubar.x = -382;
		menubar.y = -47;

		playbutton = new FlxSprite(80, 356.8);
		playbutton.frames = Paths.getSparrowUi('play');
		playbutton.animation.addByPrefix('idle', 'Play', 24, false);
		playbutton.animation.addByPrefix('enter', 'Select', 24, false);
		playbutton.animation.play('idle');
		playbutton.antialiasing = true;

		exit = new FlxSprite(80.05, 425);
		exit.frames = Paths.getSparrowUi('exit');
		exit.animation.addByPrefix('idle', 'exit', 24, false);
		exit.animation.addByPrefix('enter', 'Select', 24, false);
		exit.animation.play('idle');
		exit.antialiasing = true;

		FlxTween.tween(menubar, {x: -44, y: -47}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 8.5});
		FlxTween.tween(logo, {x: 135.1, y: 41.3}, 0.9, {type: ONESHOT, ease: FlxEase.bounceOut, startDelay: 8.5});
		FlxTween.tween(zARDY, {x: 355.55, y: 101.95}, 0.9, {type: ONESHOT, ease: FlxEase.bounceOut, startDelay: 8.5});
		FlxTween.tween(creds, {x: 0, y: 740}, 3, {type: ONESHOT, ease: FlxEase.smootherStepIn, startDelay: 6.5});
		FlxTween.tween(bgdots, {x: 0, y: 0}, 120, {type: LOOPING, startDelay: 0});

		add(whitebg);
		add(bgdots);
		add(menubar);
		add(logo);

		add(exit);
		add(playbutton);

		add(zARDY);
		add(creds);

		FlxG.camera.fade(FlxColor.WHITE, 3, true);

		new FlxTimer().start(9, introcheck);
		new FlxTimer().start(9, ghost);

		super.create();
	}

	function fadeout():Void
	{
		FlxTween.tween(menubar, {x: -382, y: -47}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(logo, {x: 135.1, y: -305.9}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(zARDY, {x: 355.55, y: 728.35}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxG.sound.music.fadeOut(2);
		entersound.play();
	}

	function playgame()
	{
		fadeout();
		FlxG.camera.fade(FlxColor.WHITE, 2, false, function()
		{
			FlxG.switchState(new ScaryIntroState());
		});
	}

	function quit()
	{
		fadeout();
		FlxG.camera.fade(FlxColor.WHITE, 2, false, function()
		{
			System.exit(0);
		});
	}

	function introcheck(timer:FlxTimer):Void
	{
		introActive = false;
	}

	function ghost(timer:FlxTimer):Void
	{
		if (FlxG.random.bool(5))
		{
			FlxG.switchState(new MainMenuGhost());
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (introActive)
		{
			if (FlxG.keys.justPressed.ENTER)
			{
				if (FlxG.random.bool(5))
				{
					FlxG.switchState(new MainMenuGhost());
				}
				else
				{
					menubar.x = -44;
					menubar.y = -47;
					logo.x = 135.1;
					logo.y = 41.3;
					zARDY.x = 355.55;
					zARDY.y = 101.95;
					creds.x = 0;
					creds.y = 740;
					introActive = false;
				}
			}
		}

		if (FlxG.mouse.overlaps(playbutton))
		{
			playbutton.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				playgame();
			}
		}
		else
		{
			playbutton.animation.play('idle');
		}

		if (FlxG.mouse.overlaps(exit))
		{
			exit.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				quit();
			}
		}
		else
		{
			exit.animation.play('idle');
		}
	}
}
