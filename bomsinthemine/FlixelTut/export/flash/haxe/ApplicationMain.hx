import lime.Assets;
#if !macro


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new openfl.display.Application ();
		app.create (config);
		
		var display = new flixel.system.FlxPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("assets/data/data-goes-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/Game.oep");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/minelvl002.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/minelvl003.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/room-001.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/images/BigBomb.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/Bomb.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/Game_Template_Miner_Sid.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/Game_Template_Miner_v1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/Game_Template_Miner_v2.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/Game_Template_Tiles_v1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/gem.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/gold.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/health.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/images-go-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/images/iron.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/iron2.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/Jim_Thumb_v1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/Sid_Thumb_v1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/stone.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/music/music-goes-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/sounds/sounds-go-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/sounds/beep.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/flixel.mp3");
		types.push (AssetType.MUSIC);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (0),
			borderless: false,
			depthBuffer: false,
			fps: Std.int (60),
			fullscreen: false,
			height: Std.int (960),
			orientation: "portrait",
			resizable: true,
			stencilBuffer: false,
			title: "FlixelTut",
			vsync: true,
			width: Std.int (1280),
			
		}
		
		#if js
		#if (munit || utest)
		flash.Lib.embed (null, 1280, 960, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
