package wx.clay;

class Container
{
   public var parent(get,null) : Container;
   public var manager(get,null) : Manager;
   public var shown(get,set) : Bool;
   public var rect(get,set) : wx.Rect;
   public var window(get,null) : wx.Window;
   public var minWidth(get,set) : Int;
   public var minHeight(get,set) : Int;

   public var wxHandle:Dynamic;
   function _wx_deleted() { wxHandle=null; }

   static var stBest = 0;
   static var stMin = 1;
   static var stMax = 2;
   static var stFloating = 3;
   static var stWideDock = 4;
   static var stTallDock = 5;
   
   
   function new() {}

   public function raise()
   {
   }

   public function addContainer(inContainer:Container, inWhere:AddPosition)
   {
   }

   public function addWindow(inWindow:wx.Window, inWhere:AddPosition, /* Icons */
                     inFlags:Int = 0 ) : Container
   {
       var container = new Container();
       container.wxHandle = wx_container_add_window(wxHandle, inWindow.wxHandle, container,
           Type.enumIndex(inWhere), inFlags );
       return container;
   }
   public function addToolbox(inToolbox:Toolbox, inWhere:AddPosition )
   {
       var container = new Container();
       container.wxHandle = wx_container_add_window(wxHandle, inToolbox.wxHandle, container,
           Type.enumIndex(inWhere), 0 );
       return container;
   }

   public function get_parent() : Container { return null; }
   public function get_manager() : Manager { return null; }

   public function get_shown() : Bool { return false; }
   public function set_shown(inShow:Bool) : Bool { return false; }

   public function get_rect() : wx.Rect { return null; }
   public function set_rect(inRect:wx.Rect) : wx.Rect { return null; }

   public function get_window() : wx.Window { return null; }

   function get_minWidth() : Int { return wx_container_get_width(wxHandle,stMin); }
   function set_minWidth(inW:Int) : Int { return wx_container_set_width(wxHandle,stMin,inW); return inW; }
   function get_minHeight() : Int { return wx_container_get_height(wxHandle,stMin); }
   function set_minHeight(inH:Int) : Int { return wx_container_set_height(wxHandle,stMin,inH); return inH; }


   public static function wxCreate() { return new Container(); }


    static var wx_container_add_window = Loader.load("wx_container_add_window",-1);
    static var wx_container_get_width = Loader.load("wx_container_get_width",2);
    static var wx_container_set_width = Loader.load("wx_container_set_width",3);
    static var wx_container_get_height = Loader.load("wx_container_get_height",2);
    static var wx_container_set_height = Loader.load("wx_container_set_height",3);
}



