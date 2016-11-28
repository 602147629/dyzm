/**Created by the LayaAirIDE,do not modify.*/
package layaboxTest.bin-debug.res.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class fightUI extends View {

		public static var uiView:Object ={"type":"View","props":{"width":1280,"height":800}};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}