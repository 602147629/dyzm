/**Created by the LayaAirIDE,do not modify.*/
package dyzm.view.layer.index.childLayer.skillLayer {
	import laya.ui.*;
	import laya.display.*; 

	public class BaseSkillLayerUI extends View {
		public var img1:Image;
		public var skillList:List;
		public var img2:Image;
		public var closeBtn:Button;
		public var mainBtn:Button;
		public var upBtn:Button;
		public var upInfo:Label;
		public var up2Btn:Button;
		public var up2Open:Label;
		public var selected2Img:Image;
		public var skillInfo:Label;
		public var up1Btn:Button;
		public var up1Open:Label;
		public var selected1Img:Image;

		public static var uiView:Object ={"type":"View","props":{"width":1280,"text":"升级介绍","height":800},"child":[{"type":"Image","props":{"y":80,"x":75,"width":550,"var":"img1","skin":"ui/bg.png","height":600,"sizeGrid":"30,10,10,10"},"child":[{"type":"List","props":{"y":30,"x":5,"width":540,"var":"skillList","vScrollBarSkin":"ui/vscroll.png","spaceY":5,"spaceX":0,"repeatY":10,"repeatX":1,"height":560}}]},{"type":"Image","props":{"y":80,"x":663,"width":550,"var":"img2","skin":"ui/bg.png","height":600,"sizeGrid":"30,10,10,10"},"child":[{"type":"Button","props":{"y":3,"x":521,"var":"closeBtn","skin":"ui/btn_close.png"}},{"type":"Button","props":{"y":28,"x":28,"width":496,"var":"mainBtn","skin":"ui/btn.png","labelSize":32,"label":"技能","height":84,"sizeGrid":"3,3,3,3"}},{"type":"Button","props":{"y":509,"x":168,"var":"upBtn","skin":"ui/btn.png","labelSize":32,"label":"升级","sizeGrid":"3,3,3,3"}},{"type":"Label","props":{"y":319,"x":13,"width":524,"var":"upInfo","text":"升级介绍","mouseEnabled":false,"height":187,"fontSize":24,"align":"left"}},{"type":"Button","props":{"y":220,"x":304,"var":"up2Btn","skin":"ui/btn.png","labelSize":32,"label":"升级2","sizeGrid":"3,3,3,3"},"child":[{"type":"Label","props":{"y":3,"x":148,"width":53,"var":"up2Open","text":"已开启","mouseEnabled":false,"height":17,"fontSize":18}},{"type":"Image","props":{"y":-4,"x":-11,"width":224,"var":"selected2Img","skin":"ui/linkbutton.png","sizeGrid":"5,5,5,5","mouseEnabled":false,"height":93}}]},{"type":"Label","props":{"y":118,"x":14,"wordWrap":true,"width":524,"var":"skillInfo","text":"技能介绍","overflow":"hidden","height":91,"fontSize":24,"align":"left"}},{"type":"Button","props":{"y":223,"x":26,"var":"up1Btn","skin":"ui/btn.png","labelSize":32,"label":"升级1","sizeGrid":"3,3,3,3"},"child":[{"type":"Label","props":{"y":3,"x":148,"width":53,"var":"up1Open","text":"已开启","mouseEnabled":false,"height":17,"fontSize":18}},{"type":"Image","props":{"y":-4,"x":-8,"width":224,"var":"selected1Img","skin":"ui/linkbutton.png","sizeGrid":"5,5,5,5","mouseEnabled":false,"height":93}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}