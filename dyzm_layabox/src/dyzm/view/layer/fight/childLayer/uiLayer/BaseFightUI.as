/**Created by the LayaAirIDE,do not modify.*/
package dyzm.view.layer.fight.childLayer.uiLayer {
	import laya.ui.*;
	import laya.display.*; 

	public class BaseFightUI extends View {
		public var btn1:Button;

		public static var uiView:Object ={"type":"View","props":{"width":1280,"height":800},"child":[{"type":"Button","props":{"y":479,"x":244,"var":"btn1","stateNum":"3","skin":"ui/btn.png","sizeGrid":"6,6,6,6","name":"bbb","label":"label"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}