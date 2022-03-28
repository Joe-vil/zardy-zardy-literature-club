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
import sys.io.File;
#end
#if cpp
import sys.thread.Thread;
#end

class MainMenu extends FlxState
{
	private var mosueoverbuttionsshit:Bool = true;
	var bgdots:FlxBackdrop;

	var hoversound:FlxSound;
	var entersound:FlxSound;

	var whitebg:FlxSprite;
	var menubar:FlxSprite;
	var creds:FlxSprite;
	var zARDY:FlxSprite;
	var logo:FlxSprite;

	var playbutton:FlxSprite;
	var loadbutton:FlxSprite;
	var settingsbutton:FlxSprite;
	var helpbutton:FlxSprite;
	var exit:FlxSprite;

	var introActive:Bool = true;
	var updates:Bool = true;

	var sidebar:FlxTween;
	var zzlcLogo:FlxTween;
	var zardypopup:FlxTween;
	var joelmao:FlxTween;
	var scrolldots:FlxTween;

	override public function create()
	{
		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			DiscordClient.shutdown();
		});

		DiscordClient.changePresence("In the Menus", null);
		#end

		if (updates)
		{
			trace('checking for update');
			var http = new haxe.Http("https://raw.githubusercontent.com/ShadowMario/FNF-PsychEngine/main/gitVersion.txt");

			http.onData = function(data:String)
			{
				updateVersion = data.split('\n')[0].trim();
				var curVersion:String = MainMenuState.psychEngineVersion.trim();
				trace('version online: ' + updateVersion + ', your version: ' + curVersion);
				if (updateVersion != curVersion)
				{
					trace('versions arent matching!');
					mustUpdate = true;
				}
			}

			http.onError = function(error)
			{
				trace('error: $error');
			}

			http.request();
		}

		FlxG.save.bind('JoeVil', 'Zardy Zardy literature club!');
		SettingsPrefs.loadPrefs();

		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(Paths.music('zardy zardy'));
		}

		hoversound = FlxG.sound.load(Paths.sound('hover'));
		entersound = FlxG.sound.load(Paths.sound('enter'));

		whitebg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);

		bgdots = new FlxBackdrop(Paths.imageui('bg-dots'), 0, 0, true, true, 100, 100);
		bgdots.antialiasing = SettingsPrefs.antialiasing;
		bgdots.x = 5120;
		bgdots.y = 2880;

		zARDY = new FlxSprite(0, 0);
		zARDY.frames = Paths.getSparrowUi('zardy-popup');
		zARDY.animation.addByPrefix('idle', 'zardy-bop', 24);
		zARDY.animation.play('idle');
		zARDY.antialiasing = SettingsPrefs.antialiasing;
		zARDY.x = 536;
		zARDY.y = 1089;

		creds = new FlxSprite(0, 0).loadGraphic(Paths.imageui('introcred'));
		creds.antialiasing = SettingsPrefs.antialiasing;
		creds.x = 0;
		creds.y = -1079;

		logo = new FlxSprite(0, 0).loadGraphic(Paths.imageui('ZARDY-ZARDY'));
		logo.antialiasing = SettingsPrefs.antialiasing;
		logo.x = 226.35;
		logo.y = -448.5;

		menubar = new FlxSprite(0, 0).loadGraphic(Paths.imageui('menu-bar'));
		menubar.antialiasing = SettingsPrefs.antialiasing;
		menubar.x = -575.5;
		menubar.y = -66.7;

		playbutton = new FlxSprite(61, 464);
		playbutton.frames = Paths.getSparrowUi('menu-buttons');
		playbutton.animation.addByPrefix('idle', 'play', 24, false);
		playbutton.animation.addByPrefix('enter', 'selectplay', 24, false);
		playbutton.animation.play('idle');
		playbutton.updateHitbox;
		playbutton.antialiasing = SettingsPrefs.antialiasing;

		loadbutton = new FlxSprite(63, 564);
		loadbutton.frames = Paths.getSparrowUi('menu-buttons');
		loadbutton.animation.addByPrefix('idle', 'load', 24, false);
		loadbutton.animation.addByPrefix('enter', 'selectload', 24, false);
		loadbutton.animation.play('idle');
		loadbutton.updateHitbox;
		loadbutton.antialiasing = SettingsPrefs.antialiasing;

		settingsbutton = new FlxSprite(57, 667);
		settingsbutton.frames = Paths.getSparrowUi('menu-buttons');
		settingsbutton.animation.addByPrefix('idle', 'settings', 24, false);
		settingsbutton.animation.addByPrefix('enter', 'selectsettings', 24, false);
		settingsbutton.animation.play('idle');
		settingsbutton.updateHitbox;
		settingsbutton.antialiasing = SettingsPrefs.antialiasing;

		helpbutton = new FlxSprite(61, 770);
		helpbutton.frames = Paths.getSparrowUi('menu-buttons');
		helpbutton.animation.addByPrefix('idle', 'help', 24, false);
		helpbutton.animation.addByPrefix('enter', 'selecthelp', 24, false);
		helpbutton.animation.play('idle');
		helpbutton.updateHitbox;
		helpbutton.antialiasing = SettingsPrefs.antialiasing;

		exit = new FlxSprite(60, 875);
		exit.frames = Paths.getSparrowUi('menu-buttons');
		exit.animation.addByPrefix('idle', 'exit', 24, false);
		exit.animation.addByPrefix('enter', 'selectexit', 24, false);
		exit.animation.play('idle');
		exit.updateHitbox;
		exit.antialiasing = SettingsPrefs.antialiasing;

		var version:FlxText = new FlxText(5, FlxG.height - 18, 0, "v" + Application.current.meta.get('version'), 12);
		version.scrollFactor.set();
		version.setFormat("Riffic", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		add(whitebg);
		add(bgdots);
		add(menubar);
		add(logo);

		add(version);

		add(playbutton);
		add(loadbutton);
		add(settingsbutton);
		add(helpbutton);
		add(exit);

		add(zARDY);
		add(creds);

		tweenIn();

		super.create();
	}

	public static var introSTOP:Bool = false;

	function tweenIn()
	{
		if (!introSTOP)
		{
			sidebar = FlxTween.tween(menubar, {x: -57.3, y: -66.7}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 8});
			zzlcLogo = FlxTween.tween(logo, {x: 224.25, y: 42.15}, 0.9, {type: ONESHOT, ease: FlxEase.bounceOut, startDelay: 8});
			zardypopup = FlxTween.tween(zARDY, {x: 536, y: 198}, 0.9, {type: ONESHOT, ease: FlxEase.bounceOut, startDelay: 8});
			joelmao = FlxTween.tween(creds, {x: 0, y: 1085}, 3, {type: ONESHOT, ease: FlxEase.smootherStepIn, startDelay: 6});
			scrolldots = FlxTween.tween(bgdots, {x: 0, y: 0}, 120, {type: LOOPING, startDelay: 0});
			FlxG.camera.fade(FlxColor.WHITE, 3, true);
			new FlxTimer().start(10, removeExtraStuff);
			new FlxTimer().start(7.5, introcheck);
			new FlxTimer().start(9, ghost);
		}
		else
		{
			canceltween();
			introActive = false;
			FlxG.camera.fade(FlxColor.WHITE, 1, true);
			scrolldots = FlxTween.tween(bgdots, {x: 0, y: 0}, 120, {type: LOOPING, startDelay: 0});
		}
	}

	function tweenOut(barTime:Float, logoTime:Float, groupTime:Float)
	{
		sidebar = FlxTween.tween(menubar, {x: -575.5, y: -66.7}, barTime, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		zzlcLogo = FlxTween.tween(logo, {x: 226.35, y: -448.5}, logoTime, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
		zardypopup = FlxTween.tween(zARDY, {x: 536, y: 1089}, groupTime, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0});
	}

	function selectedButton(timeFade:Float, musicFade:Float, state:String)
	{
		switch (state)
		{
			case 'playgame':
				tweenOut(0.7, 0.9, 0.9);
				introSTOP = true;
				FlxG.sound.music.fadeOut(musicFade);
				FlxG.camera.fade(FlxColor.WHITE, timeFade, false, function()
				{
					FlxG.switchState(new ScaryIntroState());
				});
			case 'load':
				tweenOut(0.3, 0.5, 0.5);
				introSTOP = true;
				FlxG.camera.fade(FlxColor.WHITE, timeFade, false, function()
				{
					FlxG.switchState(new LoadSaveState());
				});
			case 'settings':
				tweenOut(0.3, 0.5, 0.5);
				introSTOP = true;
				FlxG.camera.fade(FlxColor.WHITE, timeFade, false, function()
				{
					FlxG.switchState(new SettingsState());
				});
			case 'help':
				UrlOpener.browserLoad('https://www.youtube.com/watch?v=qj0v0bJiZ18&ab_channel=Xploshi');
			case 'quit':
				tweenOut(0.7, 0.9, 0.9);
				introSTOP = true;
				FlxG.sound.music.fadeOut(musicFade);
				FlxG.camera.fade(FlxColor.WHITE, timeFade, false, function()
				{
					System.exit(0);
				});
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!introActive && FlxG.mouse.overlaps(playbutton))
		{
			playbutton.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				selectedButton(2, 2, 'playgame');
				entersound.play();
			}
		}
		else
		{
			playbutton.animation.play('idle');
		}

		if (!introActive && FlxG.mouse.overlaps(loadbutton))
		{
			loadbutton.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				selectedButton(0.5, 0, 'load');
				entersound.play();
			}
		}
		else
		{
			loadbutton.animation.play('idle');
		}

		if (!introActive && FlxG.mouse.overlaps(settingsbutton))
		{
			settingsbutton.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				selectedButton(0.5, 0, 'settings');
				entersound.play();
			}
		}
		else
		{
			settingsbutton.animation.play('idle');
		}

		if (!introActive && FlxG.mouse.overlaps(helpbutton))
		{
			helpbutton.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				selectedButton(0, 0, 'help');
				entersound.play();
			}
		}
		else
		{
			helpbutton.animation.play('idle');
		}

		if (!introActive && FlxG.mouse.overlaps(exit))
		{
			exit.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				selectedButton(2, 2, 'quit');
				entersound.play();
			}
		}
		else
		{
			exit.animation.play('idle');
		}

		if (introActive && FlxG.keys.justPressed.ENTER)
		{
			if (FlxG.random.bool(0.5))
			{
				FlxG.switchState(new MainMenuGhost());
			}
			else
			{
				canceltween();
				introActive = false;
				trace("peepee?");
			}
		}
	}

	function canceltween()
	{
		if (!introSTOP)
		{
			sidebar.cancel();
			zzlcLogo.cancel();
			zardypopup.cancel();
			joelmao.cancel();
		}
		menubar.x = -57.3;
		menubar.y = -66.7;
		logo.x = 224.25;
		logo.y = 42.15;
		zARDY.x = 536;
		zARDY.y = 198;
		creds.x = 0;
		creds.y = 1085;
	}

	function introcheck(timer:FlxTimer):Void
	{
		introActive = false;
	}

	function removeExtraStuff(timer:FlxTimer):Void
	{
		remove(creds);
	}

	function ghost(timer:FlxTimer):Void
	{
		if (FlxG.random.bool(5))
		{
			FlxG.switchState(new MainMenuGhost());
		}
	}
}
