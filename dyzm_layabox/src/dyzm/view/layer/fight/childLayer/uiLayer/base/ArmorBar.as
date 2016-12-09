package dyzm.view.layer.fight.childLayer.uiLayer.base
{
	import dyzm.Res;
	import dyzm.manager.Asset;
	
	import laya.display.Sprite;
	import laya.ui.Image;

	public class ArmorBar extends Sprite
	{
		/**
		 * 进度条宽度
		 */
		public var _w:int = 256;
		/**
		 * 分隔数
		 */
		public var _max:int = -1;
		/**
		 * 当前值
		 */
		public var _value:int = 0;
		/**
		 * 左边豆
		 */
		public var left:Sprite;
		/**
		 * 右边豆
		 */
		public var right:Sprite;
		/**
		 * 中间拉伸豆
		 */
		public var middle:Image;
		/**
		 * 分隔斜杠
		 */
		public var separators:Array;
		public function ArmorBar()
		{
			left = new Sprite();
			left.texture = Asset.getRes(Res.armorLeft);
			right = new Sprite();
			right.texture = Asset.getRes(Res.armorRight);
			middle = new Image(Res.armorMiddle);
			middle.sizeGrid = "0,14,0,14";
			
			separators = [];
			this.addChild(middle);
			this.addChild(left);
			right.x = 229;
			this.addChild(right);
		}
		
		public function set max(v:int):void
		{
			if (_max == v) return;
			
			_max = v;
			if (_max == 0){
				left.visible = false;
				middle.visible = false;
				right.visible = false;
			}
			
			var needNum:int = _max - 1;
			var spr:Sprite;
			var a:Number = _w / _max;
			for (var i:int = 0; i < needNum; i++) 
			{
				spr = separators[i];
				if (!spr){
					spr = new Sprite();
					spr.texture = Asset.getRes(Res.armorSeparator);
					spr.pivotX = spr.texture.width >> 1;
					this.addChild(spr);
					spr.x = a * (i + 1);
					separators[i] = spr;
				}
			}
			
			if (separators.length > needNum){
				for (var j:int = needNum; j < separators.length; j++) 
				{
					spr = separators[j];
					this.removeChild(spr);
				}
			}
		}
		
		public function set value(v:int):void
		{
			if (_value == v) return;
			_value = v;
			
			if (_max == 0) return;
			
			middle.width = _w * (_value/_max);
			if (_value == _max){
				right.visible = true;
			}else{
				right.visible = false;
			}
			
			if (_value == 0){
				left.visible = false;
				middle.visible = false;
			}else{
				left.visible = true;
				middle.visible = true;
			}
		}
	}
}