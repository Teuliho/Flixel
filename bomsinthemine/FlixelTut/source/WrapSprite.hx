package ;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class WrapSprite extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		
	}
	public function wrap():Void
	{
			if(x < -frameWidth + offset.x)
				x = FlxG.width + offset.x;
			else if(x > FlxG.width + offset.x)
				x = -frameWidth + offset.x;
			if(y < -frameHeight + offset.y)
				y = FlxG.height + offset.y;
			else if(y > FlxG.height + offset.y)
				y = -frameHeight + offset.y;
	}
	override public function update():Void
	{
		super.update();
		wrap();
	}
}