package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;





/** Variablen */

class Player extends FlxSprite
{
	
	public var speed:Float = 200;
	
	public var bombTimer:Float = 0;
	public var bombCooldown:Float = 10;
	
	public var attSpeed:Float = 1;
	public var attTimer:Float = 0;
	public var attacked:Bool = false;
	
	public var damage:Float = 10;
	
	public var bombs:FlxTypedGroup<Bomb> = new FlxTypedGroup<Bomb>();
	
	public var weapon:Int = 1;
	
	public var game:PlayState;
	
	public var model:Int;
	
	
	
	
	/**------ Its alive ------*/
	public function new(X:Float=0, Y:Float=0, gam:PlayState, mod:Int)  
	{
		super(X, Y);
		game = gam;
		model = mod;
		switch(model){
			case 0:
				loadGraphic(AssetPaths.Game_Template_Miner_v2__png, false, 16, 16);
			case 1:
				loadGraphic(AssetPaths.Game_Template_Miner_Sid__png, false, 16, 16);
		}
		
	
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add("d", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("lr", [0, 1, 0, 2], 6, false);
		
		animation.add("da", [3, 11, 3, 12], 6, false);
		animation.add("ua", [6, 13, 6, 14], 6, false);
		animation.add("lra", [0, 9, 10, 9], 6, false);
		drag.x = drag.y = 16000;
		setSize(8, 14);
		offset.set(4, 2);		
	}
	
	
	
	/**------ and it can do stuff ------*/
	
	
	override public function update():Void 
	{
		movement();
		super.update();
		
		if (FlxG.keys.pressed.C)
		{
			attack();
		}
		maxVelocity = new FlxPoint(100, 100);
		if (attTimer > 0) {
			attTimer = attTimer -FlxG.elapsed;
		}
		if (FlxG.keys.pressed.V)
		{
			setBomb();
		}
		if (FlxG.keys.anyJustPressed(["X"]))
		{
			changeWeapons();
		}
		if (bombTimer > 0)
		{
			bombTimer = bombTimer -FlxG.elapsed;
				
		}
	}
	
	
	
	
	/**------ it can move ------*/
	
	private function movement():Void
	{
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		_up = FlxG.keys.anyPressed(["UP", "W"]);
		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		
		if (_up || _down || _left || _right) {
			
			if (_up && _down)
				_up = _down = false;
				
			if (_left && _right)
				_left = _right = false;
				
			var mA:Float = 0; 
			if (_up)  
			{
				mA = -90; 
				if (_left)
					mA -= 45; 
				else if (_right)
					mA += 45; 
				facing = FlxObject.UP; 
			}
			else if (_down) 
			{
				mA = 90;
				if (_left)
					mA += 45; 
				else if (_right)
					mA -= 45; 
				facing = FlxObject.DOWN; 
			}
			else if (_left) 
			{
				mA = 180; 
				facing = FlxObject.LEFT; 
			}
			else if (_right) 
			{
				mA = 0; 
				facing = FlxObject.RIGHT; 
			}
			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity); 
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) 
			{
				switch(facing)
				{
					case FlxObject.LEFT:
						animation.play("lr");
						
						
					case FlxObject.RIGHT:
						animation.play("lr");
						
						
					case FlxObject.UP:
						animation.play("u");
						
						
					case FlxObject.DOWN:
						animation.play("d");
						
				}
			}
		}
	}
	
	
	
	/**------ it hits pretty hard ------*/
	
	public function attack():Void {
		if (attTimer <= 0)
		{
			attacked = true;
			attTimer = attSpeed;
		}
						switch(facing)
				{
					case FlxObject.LEFT:
						animation.play("lra");
						
						
					case FlxObject.RIGHT:
						animation.play("lra");
						
						
					case FlxObject.UP:
						animation.play("ua");
						
						
					case FlxObject.DOWN:
						animation.play("da");
						
				}
	}
	
	/**------ it like stuff that goes boom ------*/
	
	public function setBomb():Void
	{
		if (bombTimer <= 0)
		{
			
			
			var point:FlxPoint = new FlxPoint(getMidpoint().x, getMidpoint().y);
			point = snapToGrid(point);
			
			
			switch(weapon)
				{
					case 1:
						bombs.add(new SmallBomb (point.x, point.y));
						bombTimer = bombCooldown;
						
						
					case 2:
						bombs.add(new BigBomb (point.x, point.y));
						bombTimer = bombCooldown;
				}
		}
	}
	
	/**------ these bombs behave strange ------*/
	
	public function snapToGrid(pt:FlxPoint ):FlxPoint
	{
		var pnt:FlxPoint = new FlxPoint((Math.floor(pt.x/16) * 16), Math.floor(pt.y / 16) * 16);
		return pnt;
	}
	
	public function changeWeapons():Void
	{
		if (weapon == 1)
		{
			weapon++;
		}
		else
		{
			weapon--;
		}
	}
	
	
}