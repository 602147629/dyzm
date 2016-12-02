/**Created by the LayaAirIDE,do not modify.*/
package dyzm.view.base.ui {
	import laya.ui.*;
	import laya.display.*; 

	public class BaseSkillBerUI extends View {
		public var skill_1:Button;
		public var skill_2:Button;
		public var skill_3:Button;
		public var skill_4:Button;
		public var skill_5:Button;
		public var skill_6:Button;

		public static var uiView:Object ={"type":"View","props":{"width":1280,"mouseThrough":true,"mouseEnabled":true,"height":800},"child":[{"type":"Button","props":{"y":700,"x":20,"width":80,"var":"skill_1","skin":"ui/btn.png","sizeGrid":"4,4,4,4","selected":false,"name":"skill_1","mouseEnabled":true,"labelSize":32,"label":"label","height":80}},{"type":"Button","props":{"y":700,"x":120,"width":80,"var":"skill_2","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"skill_2","mouseEnabled":true,"labelSize":32,"label":"label","height":80}},{"type":"Button","props":{"y":699,"x":220,"width":80,"var":"skill_3","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"skill_3","mouseEnabled":true,"labelSize":32,"label":"label","height":80}},{"type":"Button","props":{"y":699,"x":320,"width":80,"var":"skill_4","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"skill_4","mouseEnabled":true,"labelSize":32,"label":"label","height":80}},{"type":"Button","props":{"y":700,"x":420,"width":80,"var":"skill_5","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"skill_5","mouseEnabled":true,"labelSize":32,"label":"label","height":80}},{"type":"Button","props":{"y":700,"x":520,"width":80,"var":"skill_6","skin":"ui/btn.png","sizeGrid":"4,4,4,4","name":"skill_6","mouseEnabled":true,"labelSize":32,"label":"label","height":80}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}