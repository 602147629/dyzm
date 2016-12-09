/**Created by the LayaAirIDE,do not modify.*/
package dyzm.view.layer.fight.childLayer.uiLayer.base {
	import laya.ui.*;
	import laya.display.*; 

	public class BaseFightUI extends View {
		public var ani1:FrameClip;

		public static var uiView:Object ={"type":"View","props":{"width":1280,"height":800},"child":[{"type":"Image","props":{"y":108,"x":67,"width":361,"skin":"ui/headDi.png","pivotY":102,"pivotX":62,"height":94}},{"type":"Image","props":{"y":15,"x":25,"skin":"ui/head.png"}}],"animations":[{"nodes":[{"target":5,"keyframes":{"name":[{"value":"btn1","tweenMethod":"linearNone","tween":false,"target":5,"key":"name","index":0}]}}],"name":"ani1","id":1,"frameRate":24,"action":0}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}