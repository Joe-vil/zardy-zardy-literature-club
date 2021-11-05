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

class PlayState extends FlxState
{
	var dialogue:Array<String> = ['sexy sexy', 'coolswag'];
	var inCutscene:Bool = false;

	var swagDialoguefix:FlxText;
	var dropTextfix:FlxText;

	private var quickfix:Bool = true;
	var entersound:FlxSound;

	override public function create()
	{
		FlxG.sound.playMusic(Paths.music('Dateintro'));
		entersound = FlxG.sound.load(Paths.sound('enter'));

		// funny text fix
		dropTextfix = new FlxText(130, 509, 1000, "This field. . . is full of incredibly cute scarecrows?!", 50);
		dropTextfix.font = 'Riffic';
		dropTextfix.color = 0x7F7F7F;

		swagDialoguefix = new FlxText(128, 507, 1000, "This field. . . is full of incredibly cute scarecrows?!", 50);
		swagDialoguefix.font = 'Riffic';

		dialogue = CoolUtil.coolTextFile(Paths.txt('Dialogue-1'));
		var doof:VideoTest = new VideoTest(false, dialogue);

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
				entersound.play();
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
	}

	override function closeSubState()
	{
		super.closeSubState();
	}
}
