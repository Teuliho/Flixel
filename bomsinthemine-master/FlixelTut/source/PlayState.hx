package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxAngle;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import sys.db.Types.SId;
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _hud:HUD;
	private var _money:Int = 0;
	private var _health:Float = 100;
	private var _weapons:Int = 1;
	private var _ready:Int = 0;
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mGround:FlxTilemap;
	public var playerClass:Float = 0;
	public var _grpStones:FlxTypedGroup<Rock>;
	private var _grpGold:FlxTypedGroup<Gold>;
	public var _gridSize:Int = 16;
	public var _grid:Array<Array<Bool>>;
	
	/**----------------------------- Genesis -----------------------------*/
	
	/**---------------- first second and third day ----------------*/
	
	override public function create():Void
	{
		_map = new FlxOgmoLoader(AssetPaths.minelvl002__oel);
		_mGround = _map.loadTilemap(AssetPaths.Game_Template_Tiles_v1__png, _gridSize, _gridSize, "ground");
		
		_mGround.setTileProperties(1, FlxObject.NONE);
		_mGround.setTileProperties(2, FlxObject.ANY);
		_grid = [for (i in 0...60) [for (j in 0...40) false]]; 
		add(_mGround);
		_grpStones = new FlxTypedGroup<Rock>();
		_grpGold = new FlxTypedGroup<Gold>();
		add(_grpStones);
		add(_grpGold);
		switch(playerClass){
			case 0:
				_player = new Jim(0, 0, this, 0);
			case 1:
				_player = new Sid(0, 0, this, 1);
		}
		
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		add(_player.bombs);
		
		_hud = new HUD();
		add(_hud);
		
		super.create();
	
	}
	/**---------------- fifth and sixth day ----------------*/
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			_player.x = x;
			_player.y = y;
		}
		
		else if (entityName == "rocks")
			{
			addRock(new Stone(x, y));
			}
		else if (entityName == "gold")
			{
			addGold(new Gold(x, y));
			}
	}
	
	/**---------------- Reality and all its things ----------------*/
	
	override public function update():Void
	{
		super.update();
		FlxG.collide(_player, _grpStones);
		
		_weapons = _player.weapon;
		
		if (_player.bombTimer != 0)
		{
			
			_ready =Std.int(_player.bombTimer +1) ;
		}
		
		/**--- this sword is heavy---*/
		if (_player.attacked) {
			var obj:FlxObject;
			switch(_player.facing){
				case FlxObject.LEFT:
					obj= new FlxObject(_player.getMidpoint().x-_gridSize, _player.getMidpoint().y);
				case FlxObject.UP:
					obj= new FlxObject(_player.getMidpoint().x, _player.getMidpoint().y - _gridSize);
			
				case FlxObject.RIGHT:
					obj= new FlxObject(_player.getMidpoint().x+ _gridSize, _player.getMidpoint().y );

				case FlxObject.DOWN:
					obj= new FlxObject(_player.getMidpoint().x, _player.getMidpoint().y + _gridSize);
				default:
					obj= new FlxObject(_player.getMidpoint().x, _player.getMidpoint().y );
			}
			FlxG.overlap(obj, _grpStones, attackStone);
			obj.kill();
			_player.attacked = false;
			
		}
		/**---"First shalt thou take out the Holy Pin, then shalt thou count to three, no more, no less. 
		 * 	   Three shall be the number thou shalt count, and the number of the counting shall be three.
		 * 	   Four shalt thou not count, neither count thou two, excepting that thou then proceed to three. 
		 *     Five is right out. Once the number three, being the third number, be reached, 
		 *     then lobbest thou thy Holy Hand Grenade of Antioch towards thy foe, who being naughty in My sight, 
		 *     shall snuff it."---*/
		for (i in 0..._player.bombs.members.length)
		{
			var bob:Bomb = _player.bombs.members[i];
			if (bob.exploded)
			{
				for (j in 0..._grpStones.length)
				{	
					if(_grpStones.members[j].alive){
						var poin:FlxPoint = _grpStones.members[j].getMidpoint();
						
						var dist:Float = distance(poin, bob.getMidpoint());
						if (dist < bob.radius) {
							_grpStones.members[j].damage(bob.damage * (bob.radius - dist) / bob.radius);
							if (!_grpStones.members[j].alive)
								removeRock(_grpStones.members[j]);
						}
					}
				}
				
				var poin2:FlxPoint = _player.getMidpoint();
				var dist2:Float = distance(poin2, bob.getMidpoint());
				
				if (dist2 < bob.radius) {
					playerDamage(bob.damage * (bob.radius - dist2) / bob.radius);
				}
				bob.kill();
				bob.exploded = false;
				bob.destroy();
				
			}
		}
		FlxG.overlap(_player, _grpGold, pickGold);
		
		_hud.updateHUD(_health, _money, _weapons, _ready);
	}
	
	/**-----------------------Funktions Funktionen :P ------------------------*/
	
	public function ready(time:Int):Void
	{
		_ready = time;
	}
	
	public function playerDamage(dam:Float=0)
	{
		
		_health = (Math.round(_health - dam));
	
	}
	
	/**----- Uh how far away is this thing?-----*/
	public function distance(p1:FlxPoint, p2:FlxPoint):Float
	{
		var a = Math.abs(p1.x - p2.x);
		var b = Math.abs(p1.y - p2.y);
		return Math.sqrt(a * a + b * b);
	}
	/**----- Nice and Shiny -----*/
	public function pickGold(O:Player, G:Gold)
	{
		_money++;

		G.kill();
	}
	/**----- Take that you stupid Stone -----*/
	public function attackStone(O:FlxObject, S:Stone)
	{
		S.damage(_player.damage);
	}
	
		public function checkGrid(i:Float = 0, j:Float = 0):Bool {
		return _grid[Math.floor(i / 16)][Math.floor(j / 16)];
	}
	
	public function setGrid(i:Float = 0, j:Float = 0, bl:Bool=false):Void
	{
		_grid[Math.floor(i / 16)][Math.floor(j / 16)] = bl;
	}
	
	public function removeRock(R:Rock)
	{
		setGrid(R.x, R.y, false);
		if ((Math.random() < R.dropChance))
			addGold(new Gold(R.x, R.y));
		if ((Math.random() < (R.dropChance/10)))
			addGem(new Gem(R.x, R.y));
		R.destroy();
		R.kill();
	}
	
	public function addRock(R:Rock) {
		if (!checkGrid(R.x, R.y)) {
			setGrid(R.x, R.y, true);
			_grpStones.add(R);
		}
	}
	public function addGold(G:Gold) {
		if (!checkGrid(G.x, G.y)) {
			setGrid(G.x, G.y, true);
			_grpGold.add(G);
		}
	}
	
	public function addGem(C:Gem) {
		if (!checkGrid(C.x, C.y)) {
		setGrid(C.x, C.y, true);
		add(C);
		}
	}
	
	
	/**----------------------------- Armageddon -----------------------------*/
	/** (Function that is called when this state is destroyed - you might want to 
	 consider setting all objects this state uses to null to help garbage collection.)*/
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	
	
	
	
	
}