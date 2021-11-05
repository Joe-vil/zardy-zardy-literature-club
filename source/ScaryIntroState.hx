package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.text.FlxTypeText;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.system.debug.watch.Watch;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class ScaryIntroState extends FlxState
{
	var dialogue:Array<String> = ['sexy sexy', 'coolswag'];
	var swagDialoguefix:FlxText;
	var dropTextfix:FlxText;

	private var quickfix:Bool = true;
	var entersound:FlxSound;

	var inCutscene:Bool = false;
	var whitebg:FlxSprite;

	var pause:Pause;

	override public function create()
	{
		FlxG.sound.playMusic(Paths.music('scary'));
		FlxG.sound.music.fadeIn(2);

		entersound = FlxG.sound.load(Paths.sound('enter'));

		// funny text fix
		dropTextfix = new FlxText(130, 509, 1000, "I feel my eyes slowly open.", 50);
		dropTextfix.font = 'Riffic';
		dropTextfix.color = 0x7F7F7F;

		swagDialoguefix = new FlxText(128, 507, 1000, "I feel my eyes slowly open.", 50);
		swagDialoguefix.font = 'Riffic';

		dialogue = CoolUtil.coolTextFile(Paths.txt('IntroText'));
		var doof:VideoTest = new VideoTest(false, dialogue);

		whitebg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);

		pause = new Pause();

		add(doof);
		add(whitebg);
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

		if (FlxG.keys.justPressed.ENTER)
		{
			remove(whitebg);
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
