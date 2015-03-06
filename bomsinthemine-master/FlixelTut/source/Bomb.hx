package ;
import flixel.FlxSprite;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class Bomb extends FlxSprite
{
	public var timer:Float = 0;
	public var damage:Float = 0;
	public var radius:Float = 0;
	public var exploded:Bool = false;
	
	public function new(X:Float = 0, Y:Float =0) 
	{
		super(X, Y);
		this.immovable = true;
	}
	
	override public function update():Void
	{
		super.update();
		if (timer > 0)
		{
			timer = timer - FlxG.elapsed;
		}
		else {
			exploded = true;
		}
	}
	
}