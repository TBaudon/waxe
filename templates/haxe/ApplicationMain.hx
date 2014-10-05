import openfl.Assets;


#if macro


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				var method = macro { return flash.Lib.current.stage; }
				
				fields.push ({ name: "get_stage", access: [ APrivate, AOverride ], kind: FFun({ args: [], expr: method, params: [], ret: macro :flash.display.Stage }), pos: Context.currentPos () });
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#elseif waxe
import wx.OpenFLStage;

class ApplicationMain {
	
	
	public static var autoShowFrame:Bool = true;
	public static var frame:wx.Frame;
	#if openfl
	static public var stage:OpenFLStage;
	#end
	
	
	public static function main () {
		
		#if openfl
		openfl.Lib.setPackage ("::APP_COMPANY::", "::APP_FILE::", "::APP_PACKAGE::", "::APP_VERSION::");
		::if (sslCaCert != "")::openfl.net.URLLoader.initialize (openfl.Assets.getString ("::sslCaCert::"));::end::
		#end
		
		wx.App.boot (function () {
			
			::if (APP_FRAME != null)::
			frame = wx.::APP_FRAME::.create (null, null, "::APP_TITLE::", null, { width: ::WIN_WIDTH::, height: ::WIN_HEIGHT:: });
			::else::
			frame = wx.Frame.create (null, null, "::APP_TITLE::", null, { width: ::WIN_WIDTH::, height: ::WIN_HEIGHT:: });
			::end::
			
			#if openfl
			stage = OpenFLStage.create (frame, null, null, { width: ::WIN_WIDTH::, height: ::WIN_HEIGHT:: });
			#end
			
			var hasMain = false;
			for (methodName in Type.getClassFields (::APP_MAIN::)) {
				if (methodName == "main") {
					hasMain = true;
					break;
				}
			}
			
			if (hasMain) {
				Reflect.callMethod (::APP_MAIN::, Reflect.field (::APP_MAIN::, "main"), []);
			}else {
				var instance = Type.createInstance (::APP_MAIN::, []);
			}
			
			if (autoShowFrame) {
				wx.App.setTopWindow (frame);
				frame.shown = true;
			}
			
		});
		
	}
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		untyped $loader.path = $array (haxe.io.Path.directory (Sys.executablePath ()), $loader.path);
		untyped $loader.path = $array ("./", $loader.path);
		untyped $loader.path = $array ("@executable_path/", $loader.path);
		
	}
	#end
	
	
}


#else


import ::APP_MAIN::;

class ApplicationMain {
	
	
	public static function main () {
		
		
		
	}
	
	
}


#end
