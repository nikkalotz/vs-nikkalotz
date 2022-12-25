package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

using StringTools;

#if desktop
import Discord.DiscordClient;
#end
class FreeplaySelector extends MusicBeatState
{
	static final freeplayStrings:Array<String> = ["story", "bonus", "crossover"];
	
	static var curSelected:Int = 0;
	
	var disableInput:Bool = false;

	var freeplayItems:FlxTypedGroup<FlxSprite>;

	var accepted:Bool = false;

	var allowTransit:Bool = false;

	override public function create()
	{
		super.create();

		persistentUpdate = true;

		FlxG.mouse.visible = false;

		DiscordClient.changePresence("In The Menus", null);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat', 'preload'));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		freeplayItems = new FlxTypedGroup<FlxSprite>();
		add(freeplayItems);

		generateButtons(332);
		changeSelection(curSelected);

		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			allowTransit = true;
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!FlxG.sound.music.playing)
			FlxG.sound.playMusic(Paths.music('freakyMenu'));

		if (!disableInput)
		{
			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

			if (gamepad != null)
			{
				if (gamepad.justPressed.DPAD_LEFT)
				{
					changeSelection(curSelected - 1);
				}
				if (gamepad.justPressed.DPAD_RIGHT)
				{
					changeSelection(curSelected + 1);
				}
			}

			if (controls.ACCEPT)
			{
				enterSelection();
			}

			if (controls.BACK)
			{
				backOut();
			}

			if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A)
			{
				changeSelection(curSelected - 1);
			}

			if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D)
			{
				changeSelection(curSelected + 1);
			}
		}
	}

	function backOut()
	{
		allowTransit = false;
		FlxG.sound.play(Paths.sound('cancelMenu'));
		MusicBeatState.switchState(new MainMenuState());
	}

	function generateButtons(sep:Float)
	{
		if (freeplayItems == null)
			return;

		if (freeplayItems.members != null && freeplayItems.members.length > 0)
			freeplayItems.forEach(function(_:FlxSprite) {freeplayItems.remove(_); _.destroy(); } );
		
		for (i in 0...freeplayStrings.length)
		{	
			var str:String = freeplayStrings[i];

			var freeplayItem:FlxSprite = new FlxSprite();
			freeplayItem.loadGraphic(Paths.image("freeplay_" + str, "preload"));
			freeplayItem.origin.set();
			freeplayItem.scale.set(0.8, 0.8);
			freeplayItem.updateHitbox();
			freeplayItem.alpha = 0.5;
			freeplayItem.setPosition(40 + (i * 400), 70);
			freeplayItem.antialiasing = ClientPrefs.globalAntialiasing;
			
			freeplayItems.add(freeplayItem);
		}
	}
	
	function changeSelection(selection:Int)
	{
		if (!accepted)
		{
			if (selection != curSelected)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (selection < 0)
				selection = freeplayStrings.length - 1;
			if (selection >= freeplayStrings.length)
				selection = 0;

			trace('selected ' + selection);

			for (i in 0...freeplayStrings.length)
			{
				var freeplayItem:FlxSprite = freeplayItems.members[i];
				if (i == selection)
					freeplayItem.alpha = 1.0;
				else
					freeplayItem.alpha = 0.5;
			}

			curSelected = selection;
		}
	}

	function enterSelection()
	{
		FlxG.sound.play(Paths.sound('confirmMenu'));
		FreeplayState.fromWeek = -1;
		FreeplayState.freeplayType = curSelected;

		for (i in 0...freeplayItems.members.length)
		{
			if (i != curSelected)
			{
				FlxTween.tween(freeplayItems.members[i], {alpha: 0}, 1, {ease: FlxEase.cubeOut});
				FlxFlicker.flicker(freeplayItems.members[curSelected], 1, 0.06, false, false);
			}
		}

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			MusicBeatState.switchState(new FreeplayState());
		});
	}
}
