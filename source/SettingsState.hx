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
import flixel.util.FlxSave;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.system.System;
#if windows
import Discord.DiscordClient;
import Sys;
import sys.FileSystem;
#end
#if cpp
import sys.thread.Thread;
#end

class SettingsState extends FlxState
{
	private var mosueoverbuttionsshit:Bool = true;
	var bgdots:FlxBackdrop;

	var hoversound:FlxSound;
	var entersound:FlxSound;

	var whitebg:FlxSprite;
	var settingsMenu:FlxSprite;

	var logo:FlxSprite;

	var fullscreen:FlxSprite;
	var anti:FlxSprite;
	var lowqut:FlxSprite;
	var fpsbutt:FlxSprite;
	var back:FlxSprite;

	override public function create()
	{
		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			DiscordClient.shutdown();
		});

		DiscordClient.changePresence("In Settings", null);
		#end

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(Paths.music('zardy zardy'));
		}

		hoversound = FlxG.sound.load(Paths.sound('hover'));
		entersound = FlxG.sound.load(Paths.sound('enter'));

		whitebg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);

		bgdots = new FlxBackdrop(Paths.imageui('bg-dots'), 0, 0, true, true, 100, 100);
		bgdots.x = 5120;
		bgdots.y = 2880;
		FlxTween.tween(bgdots, {x: 0, y: 0}, 120, {type: LOOPING, startDelay: 0});

		settingsMenu = new FlxSprite(0, 0).loadGraphic(Paths.imageui('settings-menu'));
		settingsMenu.antialiasing = SettingsPrefs.antialiasing;

		logo = new FlxSprite(615.6, 47.25);
		logo.frames = Paths.getSparrowUi('settings-icon');
		logo.animation.addByPrefix('idle', 'settings logo', 24, true);
		logo.animation.play('idle');
		logo.antialiasing = SettingsPrefs.antialiasing;

		fullscreen = new FlxSprite(535.1, 447.95);
		fullscreen.frames = Paths.getSparrowUi('settings-true-false');
		fullscreen.animation.addByPrefix('true', 'true', 24, true);
		fullscreen.animation.addByPrefix('false', 'false', 24, true);
		fullscreen.updateHitbox;
		fullscreen.antialiasing = SettingsPrefs.antialiasing;

		anti = new FlxSprite(1431.05, 490.3);
		anti.frames = Paths.getSparrowUi('settings-true-false');
		anti.animation.addByPrefix('true', 'true', 24, true);
		anti.animation.addByPrefix('false', 'false', 24, true);
		anti.updateHitbox;
		anti.antialiasing = SettingsPrefs.antialiasing;

		lowqut = new FlxSprite(525.45, 829.8);
		lowqut.frames = Paths.getSparrowUi('settings-true-false');
		lowqut.animation.addByPrefix('true', 'true', 24, true);
		lowqut.animation.addByPrefix('false', 'false', 24, true);
		lowqut.updateHitbox;
		lowqut.antialiasing = SettingsPrefs.antialiasing;

		fpsbutt = new FlxSprite(1425.45, 798.2);
		fpsbutt.frames = Paths.getSparrowUi('settings-true-false');
		fpsbutt.animation.addByPrefix('true', 'true', 24, true);
		fpsbutt.animation.addByPrefix('false', 'false', 24, true);
		fpsbutt.updateHitbox;
		fpsbutt.antialiasing = SettingsPrefs.antialiasing;

		back = new FlxSprite(116, 896.9);
		back.frames = Paths.getSparrowUi('menu-buttons');
		back.animation.addByPrefix('idle', 'exit', 24, true);
		back.animation.addByPrefix('enter', 'selectexit', 24, true);
		back.updateHitbox;
		back.antialiasing = SettingsPrefs.antialiasing;

		add(whitebg);
		add(bgdots);
		add(settingsMenu);
		add(logo);

		add(fullscreen);
		add(anti);
		add(lowqut);
		add(fpsbutt);
		add(back);

		FlxG.camera.fade(FlxColor.WHITE, 0.3, true);

		super.create();
	}

	function selectedSetting(saveOption:String)
	{
		switch (saveOption)
		{
			case 'fullscreen':
				if (!SettingsPrefs.fullscreen)
				{
					SettingsPrefs.fullscreen = true;
					SettingsPrefs.saveSettings();
					FlxG.fullscreen = true;
					trace('fullscreen true');
				}
				else
				{
					SettingsPrefs.fullscreen = false;
					SettingsPrefs.saveSettings();
					FlxG.fullscreen = false;
					trace('fullscreen false');
				}
			case 'anti':
				if (!SettingsPrefs.antialiasing)
				{
					SettingsPrefs.antialiasing = true;
					SettingsPrefs.saveSettings();
					trace("antialiasing true");
				}
				else
				{
					SettingsPrefs.antialiasing = false;
					SettingsPrefs.saveSettings();
					trace("antialiasing false");
				}
			case 'low':
				if (!SettingsPrefs.lowquality)
				{
					SettingsPrefs.lowquality = true;
					SettingsPrefs.saveSettings();
					visableFPSCounter();
					trace("lowq true");
				}
				else
				{
					SettingsPrefs.lowquality = false;
					SettingsPrefs.saveSettings();
					visableFPSCounter();
					trace("lowq false");
				}
			case 'showFPS':
				if (!SettingsPrefs.showfps)
				{
					SettingsPrefs.showfps = true;
					SettingsPrefs.saveSettings();
					visableFPSCounter();
					trace("showfps true");
				}
				else
				{
					SettingsPrefs.showfps = false;
					SettingsPrefs.saveSettings();
					visableFPSCounter();
					trace("showfps false");
				}
			case 'back':
				FlxG.camera.fade(FlxColor.WHITE, 0.3, false, function()
				{
					FlxG.switchState(new MainMenu());
				});
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(fullscreen))
		{
			if (FlxG.mouse.justPressed)
			{
				entersound.play();
				selectedSetting('fullscreen');
			}
		}

		if (FlxG.mouse.overlaps(anti))
		{
			if (FlxG.mouse.justPressed)
			{
				entersound.play();
				selectedSetting('anti');
			}
		}

		if (FlxG.mouse.overlaps(lowqut))
		{
			if (FlxG.mouse.justPressed)
			{
				entersound.play();
				selectedSetting('low');
			}
		}

		if (FlxG.mouse.overlaps(fpsbutt))
		{
			if (FlxG.mouse.justPressed)
			{
				entersound.play();
				selectedSetting('showFPS');
			}
		}

		if (FlxG.mouse.overlaps(back))
		{
			back.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				entersound.play();
				selectedSetting('back');
			}
		}
		else
		{
			back.animation.play('idle');
		}

		// true or false animation junk
		if (SettingsPrefs.fullscreen)
		{
			fullscreen.animation.play('true');
		}
		else
		{
			fullscreen.animation.play('false');
		}

		if (SettingsPrefs.antialiasing)
		{
			anti.animation.play('true');
		}
		else
		{
			anti.animation.play('false');
		}

		if (SettingsPrefs.lowquality)
		{
			lowqut.animation.play('true');
		}
		else
		{
			lowqut.animation.play('false');
		}

		if (SettingsPrefs.showfps)
		{
			fpsbutt.animation.play('true');
		}
		else
		{
			fpsbutt.animation.play('false');
		}
	}

	function visableFPSCounter()
	{
		if (Main.fpsVar != null)
			Main.fpsVar.visible = SettingsPrefs.showfps;
	}
}
