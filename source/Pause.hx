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
	var loadbutton:FlxSprite;
	var settingsbutton:FlxSprite;
	var helpbutton:FlxSprite;
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
		logo.x = 226.35;
		logo.y = -448.5;

		menubar = new FlxSprite(0, 0).loadGraphic(Paths.imageui('menu-bar'));
		menubar.antialiasing = true;
		menubar.x = -575.5;
		menubar.y = -66.7;

		playbutton = new FlxSprite(61, 464);
		playbutton.frames = Paths.getSparrowUi('menu-buttons');
		playbutton.animation.addByPrefix('idle', 'play', 24, false);
		playbutton.animation.addByPrefix('enter', 'selectplay', 24, false);
		playbutton.animation.play('idle');
		playbutton.updateHitbox;
		playbutton.antialiasing = true;

		loadbutton = new FlxSprite(63, 564);
		loadbutton.frames = Paths.getSparrowUi('menu-buttons');
		loadbutton.animation.addByPrefix('idle', 'load', 24, false);
		loadbutton.animation.addByPrefix('enter', 'selectload', 24, false);
		loadbutton.animation.play('idle');
		loadbutton.updateHitbox;
		loadbutton.antialiasing = true;

		settingsbutton = new FlxSprite(57, 667);
		settingsbutton.frames = Paths.getSparrowUi('menu-buttons');
		settingsbutton.animation.addByPrefix('idle', 'settings', 24, false);
		settingsbutton.animation.addByPrefix('enter', 'selectsettings', 24, false);
		settingsbutton.animation.play('idle');
		settingsbutton.updateHitbox;
		settingsbutton.antialiasing = true;

		helpbutton = new FlxSprite(61, 770);
		helpbutton.frames = Paths.getSparrowUi('menu-buttons');
		helpbutton.animation.addByPrefix('idle', 'help', 24, false);
		helpbutton.animation.addByPrefix('enter', 'selecthelp', 24, false);
		helpbutton.animation.play('idle');
		helpbutton.updateHitbox;
		helpbutton.antialiasing = true;

		exit = new FlxSprite(60, 875);
		exit.frames = Paths.getSparrowUi('menu-buttons');
		exit.animation.addByPrefix('idle', 'exit', 24, false);
		exit.animation.addByPrefix('enter', 'selectexit', 24, false);
		exit.animation.play('idle');
		exit.updateHitbox;
		exit.antialiasing = true;

		FlxTween.tween(menubar, {x: -57.3, y: -66.7}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(logo, {x: 224.25, y: 42.15}, 0.9, {type: ONESHOT, ease: FlxEase.bounceOut, startDelay: 0});
		FlxTween.tween(bgdots, {x: 0, y: 0}, 120, {type: LOOPING});
		FlxTween.tween(whitebg, {alpha: 0.8}, 1, {startDelay: 0});
		FlxTween.tween(bgdots, {alpha: 0.8}, 1, {startDelay: 0});
		FlxTween.tween(playbutton, {alpha: 1}, 1, {startDelay: 0});
		FlxTween.tween(loadbutton, {alpha: 1}, 1, {startDelay: 0});
		FlxTween.tween(settingsbutton, {alpha: 1}, 1, {startDelay: 0});
		FlxTween.tween(helpbutton, {alpha: 1}, 1, {startDelay: 0});
		FlxTween.tween(exit, {alpha: 1}, 1, {startDelay: 0});

		add(whitebg);
		add(bgdots);
		add(menubar);
		add(logo);

		add(playbutton);
		add(loadbutton);
		add(settingsbutton);
		add(helpbutton);
		add(exit);

		new FlxTimer().start(0.1, fadeoutmusic);
	}

	function fadeout():Void
	{
		FlxTween.tween(menubar, {x: -575.5, y: -66.7}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(logo, {x: 226.35, y: -448.5}, 0.9, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		FlxTween.tween(whitebg, {alpha: 0}, 1, {startDelay: 0});
		FlxTween.tween(bgdots, {alpha: 0}, 1, {startDelay: 0});
		FlxTween.tween(playbutton, {alpha: 0}, 1, {startDelay: 0});
		FlxTween.tween(loadbutton, {alpha: 0}, 1, {startDelay: 0});
		FlxTween.tween(settingsbutton, {alpha: 0}, 1, {startDelay: 0});
		FlxTween.tween(helpbutton, {alpha: 0}, 1, {startDelay: 0});
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

	function loadgame()
	{
		fadeout();
		FlxG.camera.fade(FlxColor.WHITE, 2, false, function()
		{
			FlxG.switchState(new ScaryIntroState());
		});
	}

	function settingsgame()
	{
		fadeout();
		FlxG.camera.fade(FlxColor.WHITE, 2, false, function()
		{
			FlxG.switchState(new ScaryIntroState());
		});
	}

	function helpgame()
	{
		fadeout();
		FlxG.camera.fade(FlxColor.WHITE, 2, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}

	function quit()
	{
		fadeout();
		FlxG.camera.fade(FlxColor.WHITE, 2, false, function()
		{
			FlxG.switchState(new MainMenu());
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

		if (FlxG.mouse.overlaps(loadbutton))
		{
			loadbutton.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				loadgame();
			}
		}
		else
		{
			loadbutton.animation.play('idle');
		}

		if (FlxG.mouse.overlaps(settingsbutton))
		{
			settingsbutton.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				settingsgame();
			}
		}
		else
		{
			settingsbutton.animation.play('idle');
		}

		if (FlxG.mouse.overlaps(helpbutton))
		{
			helpbutton.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				helpgame();
			}
		}
		else
		{
			helpbutton.animation.play('idle');
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
