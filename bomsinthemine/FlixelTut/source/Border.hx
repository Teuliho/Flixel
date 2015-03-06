package ;

/**
 * ...
 * @author ...
 */
class Border extends Rock
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.iron2__png, true, 16, 16);
		this.density = 100;
		this.maxDensity = 100;
		this.dropChance = 0.05;
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