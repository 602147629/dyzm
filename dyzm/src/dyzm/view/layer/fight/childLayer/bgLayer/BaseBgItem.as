package dyzm.view.layer.fight.childLayer.bgLayer
{
	import flash.display.Sprite;
	
	import dyzm.manager.GameConfig;
	
	public class BaseBgItem extends Sprite
	{
		public var list:Array;
		public var w:int;
		public var interval:int;
		public var moveX:Number;
		public var startY:Number;
		public var moveY:Number;
		public var moveZ:Number;
		public var sZ:Number;
		public function BaseBgItem()
		{
			super();
		}
		
		public function setInfo(info:Array):void
		{
			var startX:int = info[1];
			interval = info[3];
			moveX = info[7];
			startY = info[8];
			moveY = info[9];
			moveZ = info[10];
			sZ = info[11];
			
			var num:int = Math.ceil(GameConfig.w / interval) + 1;
			w = num * interval + startX;
			list = [];
			
			var bg:BaseBgItemOne;
			for (var i:int = 0; i < num; i++)
			{
				bg = new BaseBgItemOne();
				bg.setInfo(info, i);
				this.addChild(bg);
				list.push(bg);
			}
		}
		
		public function update(xx:Number, yy:Number, zz:Number):void
		{
			this.x = -((xx*moveX) % interval);
			if (this.x > 0){
				this.x -= interval;
			}
			
			var ty:Number = 0;
			if (startY - yy > 0){
				ty = startY - yy;
			}
		
			this.y = ty * moveY - zz * moveZ;
			
			this.scaleY = 1 - ty * sZ;
		}
	}
}