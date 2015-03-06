package ;
import flixel.FlxG;
import flixel.FlxObject;
/**
 * ...
 * @author ...
 */
class Sid extends Player
{
	public var blinkTimer:Float = 0;
	public var blinkCD:Float = 3;
	public function new(X:Float=0, Y:Float=0, gam:PlayState,mod:Int) 
	{
		super(X, Y, gam, mod);
		
	}
	
	override public function update():Void
	{
		super.update();
		if (FlxG.keys.pressed.SPACE)
		{
			if(blinkTimer<=0){
				blink();
				blinkTimer = blinkCD;
			}
		}
		if (blinkTimer > 0) {
			blinkTimer -= FlxG.elapsed;
		}
	}
	
	public function blink():Void
	{
		var a:Int = 8;
		switch(facing) {
			case FlxObject.LEFT:
				while (game.checkGrid(x - game._gridSize * a, y))
					a = a - 1;
				x = x - game._gridSize*a;
			case FlxObject.UP:
				while (game.checkGrid(x , y- game._gridSize * a))
					a = a - 1;
				y = y -game._gridSize*a;
			case FlxObject.RIGHT:
				while (game.checkGrid(x + game._gridSize * a, y))
					a = a - 1;
				x = x +game._gridSize * a;
			case FlxObject.DOWN:
				while (game.checkGrid(x , y+ game._gridSize * a))
					a = a - 1;
				y = y + game._gridSize*a;
			default:
		}
	}
}