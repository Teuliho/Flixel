package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;
using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var _btnJim:FlxButton;
	private var _btnSid:FlxButton;
	private var _sprJim:FlxSprite;
	private var _sprSid:FlxSprite;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		var title:FlxText;
		title = new FlxText(0, 16, FlxG.width, "Select your Hero!");
		title.setFormat (null, 16, 0xFFFFFFFF, "center");
		add(title);
		_btnJim = new FlxButton(64, 128, "Jim", clickJim);
		add(_btnJim);
		_btnSid = new FlxButton(64, 192, "Sid", clickSid);
		add(_btnSid);
		_sprJim = new FlxSprite(200, 100 , AssetPaths.Jim_Thumb_v1__png);
		add(_sprJim);
		_sprSid = new FlxSprite(200, 180 , AssetPaths.Sid_Thumb_v1__png);
		add(_sprSid);
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		_btnJim = FlxDestroyUtil.destroy(_btnJim);
		_btnSid = FlxDestroyUtil.destroy(_btnSid);
	}
	
	private function clickJim():Void
	{
		var state:PlayState = new PlayState();
		state.playerClass = 0;
		FlxG.switchState(state);
	}
	
	private function clickSid():Void
	{
		var state:PlayState = new PlayState();
		state.playerClass = 1;
		FlxG.switchState(state);
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}