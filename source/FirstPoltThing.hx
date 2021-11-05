package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class FirstPoltThing extends FlxSpriteGroup
{
	public var finishThing:Void->Void;

	var jacky:FlxSprite;
	var cable:FlxSprite;
	var box:FlxSprite;

	var check:FlxSprite;

	var entersound:FlxSound;

	public function new()
	{
		super();

		entersound = FlxG.sound.load(Paths.sound('enter'));

		box = new FlxSprite(0, 0).loadGraphic(Paths.imageui('who'));
		box.antialiasing = true;
		box.x = 401;
		box.y = 730;

		jacky = new FlxSprite(0, 0);
		jacky.frames = Paths.getSparrowUi('jacky');
		jacky.animation.addByPrefix('idle', 'jacky', 24, false);
		jacky.animation.addByPrefix('enter', 'selected jacky', 24, false);
		jacky.animation.play('idle');
		jacky.antialiasing = true;
		jacky.x = 473;
		jacky.y = 730;

		cable = new FlxSprite(0, 0);
		cable.frames = Paths.getSparrowUi('cable');
		cable.animation.addByPrefix('idle', 'cable', 24, false);
		cable.animation.addByPrefix('enter', 'selected cable', 24, false);
		cable.animation.play('idle');
		cable.antialiasing = true;
		cable.x = 721;
		cable.y = 730;

		FlxTween.tween(box, {x: 401, y: 174}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut});
		FlxTween.tween(jacky, {x: 453, y: 297}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.2});
		FlxTween.tween(cable, {x: 701, y: 297}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.2});

		add(box);
		add(jacky);
		add(cable);
	}

	function ifyes()
	{
		fadeoutquit();
		FlxG.camera.fade(FlxColor.WHITE, 3, false, function()
		{
			FlxG.switchState(new JackyState());
		});
	}

	function ifno()
	{
		fadeoutquit();
		FlxG.camera.fade(FlxColor.WHITE, 3, false, function()
		{
			FlxG.switchState(new CableState());
		});
	}

	function fadeoutquit():Void
	{
		FlxTween.tween(box, {x: 401, y: -300}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut});
		FlxTween.tween(jacky, {x: 473, y: -300}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.1});
		FlxTween.tween(cable, {x: 721, y: -300}, 0.7, {type: ONESHOT, ease: FlxEase.smootherStepInOut, startDelay: 0.1});
		FlxG.sound.music.fadeOut(2);
		entersound.play();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(jacky))
		{
			jacky.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				ifyes();
			}
		}
		else
		{
			jacky.animation.play('idle');
		}

		if (FlxG.mouse.overlaps(cable))
		{
			cable.animation.play('enter');
			if (FlxG.mouse.justPressed)
			{
				ifno();
			}
		}
		else
		{
			cable.animation.play('idle');
		}
	}
}
