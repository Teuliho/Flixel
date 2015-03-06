package ;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;


class HUD extends FlxTypedGroup<FlxSprite>
{
		private var _sprBack:FlxSprite;
		private var _txtHealth:FlxText;
		private var _txtMoney:FlxText;
		private var _sprHealth:FlxSprite;
		private var _sprMoney:FlxSprite;
		private var _sprWeapons:FlxSprite;
		private var _txtWeapons:FlxText;
		
		private var _weapons:Int;
		
	public function new()
	{
		
		super();
		_sprBack = new FlxSprite().makeGraphic(FlxG.width, 25, FlxColor.BLACK);
		_sprBack.drawRect(0, 24, FlxG.width, 1, FlxColor.WHITE);
		
		_txtHealth = new FlxText(22, 2, 0, "100", 8);
		_txtHealth.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		
		_txtMoney = new FlxText(0, 2, 0, "0", 8);
		_txtMoney.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		
		_sprHealth = new FlxSprite(4, _txtHealth.y + (_txtHealth.height/2) - 4, AssetPaths.health__png);
		_sprMoney = new FlxSprite(FlxG.width - 20, _txtMoney.y + (_txtMoney.height / 2) - 4, AssetPaths.gold__png);
		
		_txtMoney.alignment = "right";
		_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
		
		
		_txtWeapons = new FlxText(FlxG.width / 2 + 5, 2 , 0, "ready", 8);
		_txtWeapons.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
		
		
		
		add(_sprBack);
		add(_sprHealth);
		add(_sprMoney);
		add(_txtHealth);
		add(_txtMoney);
		
		
		forEach(function(spr:FlxSprite) {
		spr.scrollFactor.set();
		});
		}
		
	

		public function updateHUD(Health:Float = 0, Money:Int = 0, Weapons:Int = 1, Ready:Int = 0):Void
		{
			
		var clear:String = "Ready";
		
		_txtHealth.text = Std.string(Health);
		_txtMoney.text = Std.string(Money);
		_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
		
		remove(_sprWeapons);
		
		switch(Weapons)
				{	
					case 1:
					
					_sprWeapons = new FlxSprite(FlxG.width / 2 - 16, 5, AssetPaths.Bomb__png);	
					add(_sprWeapons);	
					
					
					case 2:
					
					
					_sprWeapons = new FlxSprite(FlxG.width / 2 - 16, 5, AssetPaths.BigBomb__png);
					add(_sprWeapons);
					
				}
		
		
		
		

		
		switch(Ready)
				{
					case 0:
						clear = "Ready";
						
					case 1:
						clear = "0";
					
					case 2: 
						clear = "1";
						
					case 3:
						clear = "2";
						
					case 4:
						clear = "3";
						
					case 5:
						clear = "4";
						
					case 6:
						clear = "5";
						
					case 7:
						clear = "6";
						
					case 8:
						clear = "7";
						
					case 9:
						clear = "8";
						
					case 10:
						clear = "9";
				}
				
		_txtWeapons.text = Std.string(clear);
		add(_txtWeapons);
		}
}
