package dyzm.view.layer.fight.childLayer.bgLayer
{
	import dyzm.manager.Asset;
	
	import laya.display.Sprite;
	
	public class BaseBgItemOne extends Sprite
	{
		public function BaseBgItemOne()
		{
		}
		
		public function setInfo(info:Array, index:int):void
		{
			this.texture = Asset.getRes(info[0]);
			var startX:int = info[1];
			var startY:int = info[2];
			var interval:int = info[3];
			var alpha:Number = info[4];
			var scaleX:Number = info[5];
			var scaleY:Number = info[6];
			
			this.x = index * interval + startX;
			this.y = startY;
			this.alpha = alpha;
			this.scaleX = scaleX;
			this.scaleY = scaleY;
		}
		
	}
}