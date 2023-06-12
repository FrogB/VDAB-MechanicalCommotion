//a slightly modified version of the vd&b 3.0 subtitles source code.
package;

import flixel.util.FlxAxes;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.text.FlxText;

typedef SubtitleProperties =
{
	var ?x:Float;
   var ?y:Float;
   var ?subtitleSize:Int;
   var ?typeSpeed:Float;
   var ?centerScreen:Bool;
   var ?screenCenter:FlxAxes;
   var ?sounds:Array<FlxSound>;
}

class Subtitle extends FlxTypeText
{
   public var manager:SubtitleManager;
   public var onSubComplete:Void->Void;
   public function new(text:String, ?typeSpeed, showTime:Float, properties:SubtitleProperties, onComplete:Void->Void)
   {
      properties = init(properties);

      super(properties.x, properties.y, FlxG.width, text, 36);
      sounds = properties.sounds;
      onSubComplete = onComplete;
	  
      setFormat("Comic Sans MS Bold", properties.subtitleSize, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
      antialiasing = true;
      borderSize = 2;

      if (properties.centerScreen)
      {
         screenCenter(properties.screenCenter);
      }
	  
      start(properties.typeSpeed, false, false, [], function()
      {
         new FlxTimer().start(showTime, function(timer:FlxTimer)
         {
            FlxTween.tween(this, {alpha: 0}, 0.5, {onComplete: function(tween:FlxTween)
            {
               finish();
            }});
         });
      });
   }
   public function finish()
   {
		if (onSubComplete != null)
		{
			onSubComplete();
			manager.onSubtitleComplete(this);
		}
		else
		{
			manager.onSubtitleComplete(this);
		}
   }
   function init(properties:SubtitleProperties):SubtitleProperties
	{
      if (properties == null) properties = {};
      
      if (properties.x == null) properties.x = 0;
      if (properties.y == null) properties.y = 157.5; //would've been 157.5 but they dont accept decimal numbers lmao
      if (properties.subtitleSize == null) properties.subtitleSize = 36;
      if (properties.typeSpeed == null) properties.typeSpeed = 0.02;
      if (properties.centerScreen == null) properties.centerScreen = false;
      if (properties.screenCenter == null) properties.screenCenter = FlxAxes.XY;
      if (properties.sounds == null) properties.sounds = null;
      return properties;
   }
}