package ;

/**
 * ...
 * @author ...
 */
class Iron extends Rock
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.iron__png, true, 16, 16);
		this.density = 1000;
		this.maxDensity = 1000;
		this.dropChance = 0;
	}
	
	override public function update():Void 
	{
		super.update();
		if (density / maxDensity < 0.5)
		{
			animation.frameIndex=1;
		}
		if (density / maxDensity < 0.25)
		{
			animation.frameIndex=2;
		}
	}
	
}