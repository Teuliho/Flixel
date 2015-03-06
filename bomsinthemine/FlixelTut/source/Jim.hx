package ;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.FlxObject;
/**
 * ...
 * @author ...
 */
class Jim extends Player
{
	public var barrierTimer:Float = 0;
	public var barrierCD:Float = 4;
	
	public function new(X:Float=0, Y:Float=0, game:PlayState, mod:Int) 
	{
		super(X, Y, game, mod);
		
	}
	
	public function barrier():Void
	{
		var point:FlxPoint; 
			switch(facing) {
				case FlxObject.LEFT:
					point = new FlxPoint(getMidpoint().x+game._gridSize, getMidpoint().y);
					point = snapToGrid(point);
					
					game.addRock(new Iron(point.x, point.y));	
					point.y = point.y + game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					point.y = point.y - 2*game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					
				case FlxObject.UP:
					point = new FlxPoint(getMidpoint().x, getMidpoint().y+game._gridSize);
					point = snapToGrid(point);
					game.addRock(new Iron(point.x, point.y));
					point.x = point.x + game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					point.x = point.x - 2*game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					
				case FlxObject.RIGHT:
					point = new FlxPoint(getMidpoint().x-game._gridSize, getMidpoint().y);
					point = snapToGrid(point);
					game.addRock(new Iron(point.x, point.y));
					point.y = point.y + game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					point.y = point.y - 2*game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					
				case FlxObject.DOWN:
					point = new FlxPoint(getMidpoint().x, getMidpoint().y-game._gridSize);
					point = snapToGrid(point);
					game.addRock(new Iron(point.x, point.y));
					point.x = point.x + game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					point.x = point.x - 2*game._gridSize;
					game.addRock(new Iron(point.x, point.y));
					
				default:
			}
	}
	
	override public function update():Void
	{
		super.update();
		if (FlxG.keys.pressed.SPACE)
		{
			if(barrierTimer<=0){
				barrier();
				barrierTimer = barrierCD;
			}
		}
		if (barrierTimer > 0) {
			barrierTimer -= FlxG.elapsed;
		}
	}
}