package dyzm.view.base.ui
{
	import laya.display.Sprite;
	import laya.ui.Clip;
	
	public class BaseNum extends Sprite
	{
		public var clipList:Array;
		/**
		 * @param max 最大显示几位数,默认3位数
		 */
		public function BaseNum(res:String, max:int = 3)
		{
			super();
			clipList = [];
			for (var i:int = 0; i < max; i++) 
			{
				var clip:Clip = new Clip(res, 10);
				this.addChild(clip);
				clip.visible = false;
				clipList.push(clip);
			}
		}
		
		public function setDmg(num:int):void
		{
			for (var j:int = 0; j < clipList.length; j++) 
			{
				clipList[j].visible = false;
			}
			
			var s:String = num.toString();
			var len:int = s.length;
			for (var i:int = 0; i < len; i++)
			{
				clipList[i].index = int(s.charAt(i));
				clipList[i].visible = true;
				clipList[i].x = (i - len + len/2) * clipList[i].width;
			}
		}
	}
}


