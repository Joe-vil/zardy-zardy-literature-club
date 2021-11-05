package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class VideoTest extends FlxSpriteGroup
{
	var box:FlxSprite;

	var textEvents:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	var swagDialogue:FlxTypeText;
	var dropText:FlxText;

	public var finishThing:Void->Void;

	var house:FlxSprite;
	var toolshed:FlxSprite;
	var vines:FlxSprite;
	var maze:FlxSprite;
	var zardy:FlxSprite;

	var zardyicon:FlxSprite;
	var jackyicon:FlxSprite;
	var cablecrowicon:FlxSprite;

	var bgFade:FlxSprite;
	var whitebg:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		box = new FlxSprite(101, 479);

		var hasDialog = true;

		this.dialogueList = dialogueList;

		if (!hasDialog)
			return;

		box.frames = Paths.getSparrowUi('text-box');
		box.animation.addByPrefix('idle', 'text-box-idle', 24, false);
		box.animation.addByPrefix('cable', 'text-box-cable', 24, false);
		box.animation.addByPrefix('jacky', 'text-box-jacky', 24, false);
		box.animation.addByPrefix('zardy', 'text-box-zardy', 24, false);
		box.animation.addByPrefix('unknow', 'text-box-unknow', 24, false);
		box.animation.play('idle');
		box.antialiasing = true;

		whitebg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		whitebg.alpha = 0;

		house = new FlxSprite(0, 0).loadGraphic(Paths.stage('house'));
		house.antialiasing = true;
		house.alpha = 0;
		toolshed = new FlxSprite(0, 0).loadGraphic(Paths.stage('toolshed'));
		toolshed.antialiasing = true;
		toolshed.alpha = 0;
		vines = new FlxSprite(0, 0).loadGraphic(Paths.stage('vines'));
		vines.antialiasing = true;
		vines.alpha = 0;
		maze = new FlxSprite(0, 0).loadGraphic(Paths.stage('mazeintro'));
		maze.antialiasing = true;
		maze.alpha = 0;
		zardy = new FlxSprite(0, 0).loadGraphic(Paths.stage('introzardy'));
		zardy.antialiasing = true;
		zardy.alpha = 0;

		zardyicon = new FlxSprite(420, 11).loadGraphic(Paths.charecters('zardy-idle'));
		zardyicon.antialiasing = true;
		jackyicon = new FlxSprite(834, 17).loadGraphic(Paths.charecters('jacky-idle'));
		jackyicon.antialiasing = true;
		cablecrowicon = new FlxSprite(-106, 64).loadGraphic(Paths.charecters('cablecrow-idle'));
		cablecrowicon.antialiasing = true;

		dropText = new FlxText(130, 509, 1000, "", 50);
		dropText.font = 'Riffic';
		dropText.color = 0x7F7F7F;

		swagDialogue = new FlxTypeText(128, 507, 1000, "", 50);
		swagDialogue.font = 'Riffic';

		add(cablecrowicon);
		add(jackyicon);
		add(zardyicon);
		add(box);

		add(whitebg);

		add(house);
		add(toolshed);
		add(vines);
		add(maze);
		add(zardy);

		add(dropText);
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		dropText.text = swagDialogue.text;

		if (FlxG.keys.justPressed.ENTER)
		{
			dialogueOpened = true;
		}

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ENTER && dialogueStarted == true)
		{
			remove(dialogue);

			FlxG.sound.play(Paths.sound('enter'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						// finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}

		super.update(elapsed);
	}

	var isEnding:Bool = false;
	var iszoomedZ:Bool = false;
	var iszoomedJ:Bool = false;
	var iszoomedC:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (textEvents)
		{
			// intro stuff
			case 'bgintro':
				bgintro();
			case 'houseintro':
				houseintro();
			case 'shedintro':
				shedintro();
			case 'vinesintro':
				vinesintro();
			case 'mazeintro':
				mazeintro();
			case 'blackintro':
				blackintro();
			case 'zardyintro':
				zardyintro();
			case 'end':
				end();

			// player junk
			case 'player':
				remove(whitebg);
				idle();
			case 'unknown':
				unknow();
			case 'zardy':
				zardyplayer();
			case 'jacky':
				jacky();
			case 'cable':
				cable();
			case 'jackyleave':
				jackyleave();
			case 'jackyreturn':
				jackyreturn();
		}
	}

	function cleanDialog():Void
	{
		var splitStage:Array<String> = dialogueList[0].split(":");
		textEvents = splitStage[1];
		dialogueList[0] = dialogueList[0].substr(splitStage[1].length + 2).trim();
	}

	// players and ZARDY!

	function idle()
	{
		box.animation.play('idle');
		box.y = 479;
		if (iszoomedZ)
		{
			FlxTween.tween(zardyicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedZ = false;
		}
		if (iszoomedJ)
		{
			FlxTween.tween(jackyicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedJ = false;
		}
		if (iszoomedC)
		{
			FlxTween.tween(cablecrowicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedC = false;
		}
	}

	function zardyplayer()
	{
		box.animation.play('zardy');
		box.y = 417;
		FlxTween.tween(zardyicon.scale, {x: 1.05, y: 1.05}, 0.5);
		iszoomedZ = true;

		if (iszoomedJ)
		{
			FlxTween.tween(jackyicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedJ = false;
		}
		if (iszoomedC)
		{
			FlxTween.tween(cablecrowicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedC = false;
		}
	}

	function cable()
	{
		box.animation.play('cable');
		box.y = 417;
		FlxTween.tween(cablecrowicon.scale, {x: 1.05, y: 1.05}, 0.5);

		iszoomedC = true;

		if (iszoomedJ)
		{
			FlxTween.tween(jackyicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedJ = false;
		}
		if (iszoomedZ)
		{
			FlxTween.tween(zardyicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedZ = false;
		}
	}

	function jacky()
	{
		box.animation.play('jacky');
		box.y = 416;
		FlxTween.tween(jackyicon.scale, {x: 1.05, y: 1.05}, 0.5);

		iszoomedJ = true;

		if (iszoomedZ)
		{
			FlxTween.tween(zardyicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedZ = false;
		}
		if (iszoomedC)
		{
			FlxTween.tween(cablecrowicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedC = false;
		}
	}

	function unknow()
	{
		box.animation.play('unknow');
		box.y = 417;
		if (iszoomedZ)
		{
			FlxTween.tween(zardyicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedZ = false;
		}
		if (iszoomedJ)
		{
			FlxTween.tween(jackyicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedJ = false;
		}
		if (iszoomedC)
		{
			FlxTween.tween(cablecrowicon.scale, {x: 1, y: 1}, 0.5);
			iszoomedC = false;
		}
	}

	// npc leaving and coming back junkKKKKK

	function jackyreturn()
	{
		FlxTween.tween(jackyicon, {alpha: 1}, 0.7, {startDelay: 1});
		FlxTween.tween(cablecrowicon, {x: -106, y: 64}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut});
		FlxTween.tween(zardyicon, {x: 420, y: 11}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut});
	}

	function jackyleave()
	{
		FlxTween.tween(jackyicon, {alpha: 0}, 0.7, {startDelay: 0});
		FlxTween.tween(cablecrowicon, {x: 61, y: 64}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 1});
		FlxTween.tween(zardyicon, {x: 600, y: 11}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 1});
	}

	// scary intro stuff

	function bgintro()
	{
		whitebg.alpha = 1;
	}

	function houseintro()
	{
		FlxTween.tween(house, {alpha: 1}, 2);
	}

	function shedintro()
	{
		FlxTween.tween(toolshed, {alpha: 1}, 2);
	}

	function vinesintro()
	{
		FlxTween.tween(vines, {alpha: 1}, 2);
	}

	function mazeintro()
	{
		FlxTween.tween(maze, {alpha: 1}, 2);
	}

	function blackintro()
	{
		FlxTween.tween(maze, {alpha: 0}, 2);
		FlxTween.tween(vines, {alpha: 0}, 2);
		FlxTween.tween(toolshed, {alpha: 0}, 2);
		FlxTween.tween(house, {alpha: 0}, 2);
	}

	function zardyintro()
	{
		add(zardy);
		FlxTween.tween(zardy, {alpha: 1}, 2);
	}

	function end()
	{
		FlxG.sound.music.fadeOut(4);
		FlxG.camera.fade(FlxColor.BLACK, 5, false, function()
		{
			FlxG.switchState(new PlayState());
		});
	}
}
