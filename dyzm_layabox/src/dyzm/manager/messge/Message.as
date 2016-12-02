package dyzm.manager.messge
{
	import dyzm.MainScene;
	import dyzm.Res;
	import dyzm.manager.Cfg;
	import dyzm.manager.Msg;
	
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	public class Message extends Image
	{
		public const TIME:int = 500;
		public const HIDE_TIME:int = 5000;
		public var count:int = 0;
		public var hideTime:int = 5000;
		public var txt:Label;
		
		public function Message()
		{
			super();
			this.skin = Res.baseMessage;
			this.sizeGrid = "5,5,5,5";
			this.txt = new Label();
			this.txt.align = "center";
			this.txt.color = "#ffffff";
			this.txt.fontSize = 36;
			this.txt.y = 5;
			this.addChild(this.txt);
		}
		
		public function show(str:String, runing:Array):void
		{
			this.x = Cfg.w >> 1;
			this.y = Cfg.h >> 1;
			this.txt.text = str;
			var w:int = this.txt.width;
			if (w < 400){
				w = 400;
				this.txt.width = w;
			}
			this.width = w + 24;
			this.height = this.txt.height + 16;
			
			this.pivotX = this.width >> 1;
			this.pivotY = this.height >> 1;
			
			if (runing && runing.length > 0)
			{
				var tempY:int = this.y - this.height;//新出现的目标位置
				var len:int = runing.length;
				var time:int = this.HIDE_TIME - 1000;
				var message:Message;
				for (var j:int = len-1; j >= 0; j--)
				{
					message = runing[j];
					tempY -= message.height;
					message.reUp(time, tempY);
					time -= 1000;
				}
			}
			
			MainScene.me.layer4.addChild(this);
			Tween.to(this, {y:this.y - this.height}, this.TIME, null, Handler.create(this, over));
		}
		
		private function over():void
		{
			Laya.timer.frameOnce(this.hideTime / Cfg.fps, this, clear);
		}		
		
		public function reUp(time:int, targetPos:int):void
		{
			this.count ++;
			if (this.count >= 4)
			{
				this.clear();
				return;
			}
			
			this.hideTime = time;
			Laya.timer.clearAll(this);
			Tween.to(this, {y:targetPos}, this.TIME, null, Handler.create(this, over));
		}
		
		public function clear():void{
			Tween.clearAll(this);
			this.count = 0;
			this.hideTime = this.HIDE_TIME;
			if (this.parent){
				this.parent.removeChild(this);
				Msg.inPool(this);
			}
		}
	}
}