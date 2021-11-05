package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.system.System;

class Pause extends FlxSubState
{
	var bgdots:FlxBackdrop;
	private var mosueoverbuttionsshit:Bool = true;

	var hoversound:FlxSound;
	var entersound:FlxSound;

	var whitebg:FlxSprite;
	var menubar:FlxSprite;
	var logo:FlxSprite;

	var playbutton:FlxSprite;
	var exit:FlxSprite;
	var pauseMusic:FlxSound;

	public var isPersistent:Bool = false;

	var leavingMusic:Bool = false;

	public function new()
	{
		super();

		pauseMusic = new FlxSound().loadEmbedded(Paths.music('pause'), true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		hoversound = FlxG.sound.load(Paths.sound('hover'));
		entersound = FlxG.sound.load(Paths.sound('enter'));

		whitebg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		whitebg.alpha = 0;

		bgdots = new FlxBackdrop(Paths.imageui('bg-dots'), 0, 0, true, true, 100, 100);
		bgdots.alpha = 0;
		bgdots.x = 5120;
		bgdots.y = 2880;

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
		playbutton.alpha = 0;

		exit = new FlxSprite(80.05, 425);
		exit.frames = Paths.getSparrowUi('exit');
		exit.animation.addByPrefix('idle', 'exit', 24, false);
		exit.animation.addByPrefix('enter', 'Select', 24, false);
		exit.animation.play('idle');
		exit.antialiasing = true;
		exit.alpha = 0;

		FlxTween.tween(menubar, {x: -44, y: -47}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut});
		FlxTween.tween(logo, {x: 135.1, y: 41.3}, 0.9, {type: ONESHOT, ease: FlxEase.bounceOut});
		FlxTween.tween(bgdots, {x: 0, y: 0}, 120, {type: LOOPING});
		FlxTween.tween(whitebg, {alpha: 0.8}, 1, {startDelay: 0});
		FlxTween.tween(bgdots, {alpha: 0.8}, 1, {startDelay: 0});
		FlxTween.tween(playbutton, {alpha: 0.8}, 1, {startDelay: 0});
		FlxTween.tween(exit, {alpha: 0.8}, 1, {startDelay: 0});

		add(whitebg);
		add(bgdots);
		add(menubar);
		add(logo);

		add(exit);
		add(playbutton);

		new FlxTimer().start(0.1, fadeoutmusic);
	}

	function fadeout():Void
	{
		FlxTween.tween(menubar, {x: -382, y: -47}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(logo, {x: 135.1, y: -305.9}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(whitebg, {alpha: 0}, 1, {startDelay: 0});
		FlxTween.tween(bgdots, {alpha: 0}, 1, {startDelay: 0});
		FlxTween.tween(playbutton, {alpha: 0}, 1, {startDelay: 0});
		FlxTween.tween(exit, {alpha: 0}, 1, {startDelay: 0});
		leavingMusic = true;
		fadeinmusic();
	}

	function resume()
	{
		fadeout();
		new FlxTimer().start(2, resumefinish);
	}

	function resumefinish(timer:FlxTimer):Void
	{
		close();
	}

	function fadeoutmusic(timer:FlxTimer):Void
	{
		FlxG.sound.music.fadeOut(2);
	}

	function fadeinmusic()
	{
		FlxG.sound.music.fadeIn(2);
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
			System.pause();
		});
	}

	override public function update(elapsed:Float)
	{
		if (leavingMusic)
		{
			if (pauseMusic.volume > 0)
				pauseMusic.volume -= 0.2 * elapsed;
		}
		else
		{
			if (pauseMusic.volume < 0.5)
				pauseMusic.volume += 0.05 * elapsed;
		}

		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			resume();
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

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}
}
