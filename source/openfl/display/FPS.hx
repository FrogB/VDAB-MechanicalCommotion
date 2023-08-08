package openfl.display;

import openfl.system.System;
import flixel.math.FlxMath;
import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash
import openfl.Lib;
#end

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FPS extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public static var fuckFps:Bool = false;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat(openfl.utils.Assets.getFont("assets/fonts/comic.ttf").fontName, 16, color);
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];
		maxChars = 6969;
		wordWrap = true;

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (currentFPS > ClientPrefs.framerate)
		{
			currentFPS = ClientPrefs.framerate;
		}

		if (currentCount != cacheCount /*&& visible*/)
		{
			if (fuckFps)
				text = "FPS: -" + (currentFPS * 10000) + " RVhQVU5HRUQgV0lMTCBUQUtFIE9WRVI= " + (currentFPS * 10000);
			else
				text = "FPS: " + currentFPS;
			#if openfl
			var memoryMegas:Float = 0;
			memoryMegas = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));
			if (memoryMegas > 1000)
			{
				var memoryGB = (memoryMegas / 1000);
				text += "\nMemory: \n" + FlxMath.roundDecimal(memoryGB, 2) + " GB";
			}
			else
			{
				text += "\nMemory: \n" + memoryMegas + " MB";
			}
			
			textColor = 0xFFFFFFFF;
			if (memoryMegas > 3000 || currentFPS <= ClientPrefs.framerate / 2)
			{
				textColor = 0xFFFF0000;
			}

			#end
			#if (gl_stats && !disable_cffi && (!html5 || !canvas))
			text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
			text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
			text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
			#end
		}

		cacheCount = currentCount;
	}
}
