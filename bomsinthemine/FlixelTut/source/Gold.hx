package ;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Gold extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.gold__png, true, 16, 16);
	}
	
}