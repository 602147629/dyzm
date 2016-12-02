/**Created by the LayaAirIDE,do not modify.*/
package dyzm.view.base.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class BaseDirBarUI extends View {
		public var rightBtn:Button;
		public var downBtn:Button;
		public var leftBtn:Button;
		public var upBtn:Button;

		public static var uiView:Object ={"type":"View","props":{"width":1280,"mouseThrough":true,"mouseEnabled":true,"height":800},"child":[{"type":"Button","props":{"y":700,"x":-100,"width":80,"var":"rightBtn","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"right","mouseEnabled":true,"labelSize":32,"label":"label","height":80}},{"type":"Button","props":{"y":700,"x":-200,"width":80,"var":"downBtn","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"down","mouseEnabled":true,"labelSize":32,"label":"label","height":80}},{"type":"Button","props":{"y":700,"x":-300,"width":80,"var":"leftBtn","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"left","mouseEnabled":true,"labelSize":32,"label":"label","height":80}},{"type":"Button","props":{"y":600,"x":-200,"width":80,"var":"upBtn","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"up","mouseEnabled":true,"labelSize":32,"label":"label","height":80}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}