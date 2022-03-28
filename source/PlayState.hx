package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.system.debug.watch.Watch;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
#if windows
import Discord.DiscordClient;
#end

class PlayState extends FlxState
{
	var dialogue:Array<String> = ['sexy sexy', 'coolswag'];
	var inCutscene:Bool = false;

	var swagDialoguefix:FlxText;
	var dropTextfix:FlxText;

	private var quickfix:Bool = true;
	var entersound:FlxSound;

	var maze:FlxSprite;

	override public function create()
	{
		#if windows
		DiscordClient.changePresence("Playing act: 1", null);
		#end

		FlxG.sound.playMusic(Paths.music('Dateintro'));
		entersound = FlxG.sound.load(Paths.sound('enter'));

		maze = new FlxSprite(0, 0).loadGraphic(Paths.stage('maze!'));
		maze.antialiasing = SettingsPrefs.antialiasing;

		// funny text fix
		dropTextfix = new FlxText(251, 795, 1400, "This field. . . is full of incredibly cute scarecrows?!", 55);
		dropTextfix.font = 'Riffic';
		dropTextfix.color = 0x7F7F7F;

		swagDialoguefix = new FlxText(249, 792, 1400, "This field. . . is full of incredibly cute scarecrows?!", 55);
		swagDialoguefix.font = 'Riffic';

		dialogue = CoolUtil.coolTextFile(Paths.txt('Dialogue-1'));
		var doof:VideoTest = new VideoTest(false, dialogue);

		add(maze);
		add(doof);
		add(dropTextfix);
		add(swagDialoguefix);

		FlxG.camera.fade(FlxColor.WHITE, 3, true);

		super.create();
	}

	function TextStart(?dialogueBox:VideoTest):Void
	{
		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			if (dialogueBox != null)
			{
				inCutscene = true;
				add(dialogueBox);
			}
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (quickfix)
		{
			if (FlxG.keys.justPressed.ENTER)
			{
				remove(dropTextfix);
				remove(swagDialoguefix);
				quickfix = false;
				trace("penis");
			}
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			openSubState(new Pause());
		}
	}

	override function openSubState(SubState:FlxSubState)
	{
		super.openSubState(SubState);
		#if windows
		DiscordClient.changePresence("Paused", null);
		#end
	}

	override function closeSubState()
	{
		super.closeSubState();
		#if windows
		DiscordClient.changePresence("Playing act: 1", null);
		#end
	}
}
