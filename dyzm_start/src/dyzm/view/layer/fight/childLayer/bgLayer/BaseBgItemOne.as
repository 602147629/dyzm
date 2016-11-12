package dyzm.view.layer.fight.childLayer.bgLayer
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import dyzm.manager.AssetManager;
	
	public class BaseBgItemOne extends Bitmap
	{
		public function BaseBgItemOne(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}
		
		public function setInfo(info:Array, index:int):void
		{
			this.bitmapData = AssetManager.imgPool[info[0]];
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