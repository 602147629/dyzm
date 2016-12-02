/**Created by the LayaAirIDE,do not modify.*/
package dyzm.view.layer.fight.childLayer.uiLayer.base {
	import laya.ui.*;
	import laya.display.*; 

	public class BaseFightUI extends View {
		public var ani1:FrameClip;
		public var hpBar:ProgressBar;
		public var armorBar:ProgressBar;

		public static var uiView:Object ={"type":"View","props":{"width":1280,"height":800},"child":[{"type":"ProgressBar","props":{"y":40,"x":60,"width":400,"var":"hpBar","value":100,"skin":"ui/playerHpbar.png","name":"hpBar","height":20,"sizeGrid":"3,3,3,3"}},{"type":"ProgressBar","props":{"y":20,"x":60,"width":400,"var":"armorBar","value":100,"skin":"ui/playerArmorBar.png","name":"armorBar","height":20,"sizeGrid":"3,3,3,3"}}],"animations":[{"nodes":[{"target":5,"keyframes":{"name":[{"value":"btn1","tweenMethod":"linearNone","tween":false,"target":5,"key":"name","index":0}]}}],"name":"ani1","id":1,"frameRate":24,"action":0}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}