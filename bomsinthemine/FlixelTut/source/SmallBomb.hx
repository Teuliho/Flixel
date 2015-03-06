package ;

/**
 * ...
 * @author ...
 */
class SmallBomb extends Bomb
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		damage = 150;
		radius = 72;
		timer = 4;
		loadGraphic(AssetPaths.Bomb__png, true, 16, 16);
	}
	override public function update():Void 
	{
		super.update();
		if (timer <= 0)
		{
			animation.frameIndex = 1;
		}
	}
	
}