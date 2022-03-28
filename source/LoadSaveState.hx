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

class LoadSaveState extends FlxState
{
	private var mosueoverbuttionsshit:Bool = true;
	var bgdots:FlxBackdrop;

	var hoversound:FlxSound;
	var entersound:FlxSound;

	var whitebg:FlxSprite;
	var settingsMenu:FlxSprite;

	var logo:FlxSprite;

	var saveFileOne:FlxSprite;
	var back:FlxSprite;

	override public function create()
	{
		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			DiscordClient.shutdown();
		});

		DiscordClient.changePresence("Loading Save...", null);
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

		settingsMenu = new FlxSprite(0, 0).loadGraphic(Paths.imageui('load-save-menu'));
		settingsMenu.antialiasing = SettingsPrefs.antialiasing;

		logo = new FlxSprite(602.95, 47.95);
		logo.frames = Paths.getSparrowUi('load-saves-icon');
		logo.animation.addByPrefix('idle', 'load save logo', 24, true);
		logo.animation.play('idle');
		logo.antialiasing = SettingsPrefs.antialiasing;

		saveFileOne = new FlxSprite(193.45, 339.35);
		saveFileOne.frames = Paths.getSparrowUi('saveFileIcons');
		saveFileOne.animation.addByPrefix('no-save-file', 'NoSave', 24, true);
		saveFileOne.animation.addByPrefix('1', '1', 24, true);
		saveFileOne.animation.addByPrefix('2', '2', 24, true);
		saveFileOne.animation.addByPrefix('3', '3', 24, true);
		saveFileOne.animation.addByPrefix('4', '4', 24, true);
		saveFileOne.animation.addByPrefix('5', '5', 24, true);
		saveFileOne.animation.addByPrefix('6', '6', 24, true);
		saveFileOne.updateHitbox;
		saveFileOne.antialiasing = SettingsPrefs.antialiasing;

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

		add(saveFileOne);
		add(back);

		FlxG.camera.fade(FlxColor.WHITE, 0.3, true);

		super.create();
	}

	function selectedSave(saveOption:String)
	{
		switch (saveOption)
		{
			case 'save 1':
				if (LoadSavePrefs.save1 == 0)
				{
					creatNewSave();
					trace('save made!');
				}
				else if (LoadSavePrefs.save1 > 0)
				{
					trace('existing save!');
				}
			case 'back':
				FlxG.camera.fade(FlxColor.WHITE, 0.3, false, function()
				{
					FlxG.switchState(new MainMenu());
				});
		}
	}

	public static var saveState:Int = 0;

	function creatNewSave()
	{
		LoadSavePrefs.save1 = 1;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (LoadSavePrefs.save1 == 0)
		{
			saveFileOne.animation.play('NoSave');
		}
		else if (LoadSavePrefs.save1 > 0)
		{
			if (LoadSavePrefs.save1 == 1)
			{
				saveFileOne.animation.play('1');
			}
			if (LoadSavePrefs.save1 == 2)
			{
				saveFileOne.animation.play('2');
			}
			if (LoadSavePrefs.save1 == 3)
			{
				saveFileOne.animation.play('3');
			}
			if (LoadSavePrefs.save1 == 4)
			{
				saveFileOne.animation.play('4');
			}
			if (LoadSavePrefs.save1 == 5)
			{
				saveFileOne.animation.play('5');
			}
			if (LoadSavePrefs.save1 == 6)
			{
				saveFileOne.animation.play('6');
			}
		}

		if (FlxG.mouse.overlaps(saveFileOne))
		{
			if (FlxG.mouse.justPressed)
			{
				selectedSave('save 1');
			}
		}

		if (FlxG.mouse.overlaps(back))
		{
			back.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				entersound.play();
				selectedSave('back');
			}
		}
		else
		{
			back.animation.play('idle');
		}
	}

	function visableFPSCounter()
	{
		if (Main.fpsVar != null)
			Main.fpsVar.visible = SettingsPrefs.showfps;
	}
}
