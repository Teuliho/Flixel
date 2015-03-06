package ;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Rock extends FlxSprite
{
	
	public var density:Float = 10;
	public var maxDensity:Float = 10;
	public var dropChance:Float = 0.1;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		this.immovable = true;
	}
	
	public function damage(dam:Float=0):Void
	{
		
		density = density - dam;
		if (density < 0)
		{
			this.kill();
		}
	}
	
}