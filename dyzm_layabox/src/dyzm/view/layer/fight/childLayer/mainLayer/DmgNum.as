package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.Res;
	import dyzm.view.base.ui.BaseNum;
	
	import laya.display.Sprite;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;

	public class DmgNum extends Sprite
	{
		public var hpNum:BaseNum;
		public var hpCritNum:BaseNum;
		public var armorNum:BaseNum;
		public var armorCritNum:BaseNum;
		
		public var cur:BaseNum;
		/**
		 * @param max 最大显示几位数,默认3位数
		 */
		public function DmgNum()
		{
			super();
			hpNum = new BaseNum(Res.hpNum, 10);
			hpCritNum = new BaseNum(Res.hpCritNum, 10);
			armorNum = new BaseNum(Res.armorNum, 10);
			armorCritNum = new BaseNum(Res.armorCritNum, 10);
		}
		
		/**
		 * @param type 文字类型
		 * @param num 值
		 * @param isCrit 是否暴击
		 */
		public function setDmg(type:String, num:int, isCrit:Boolean):void
		{
			
			if (cur != null){
				this.removeChild(cur);
			}
			if (type == "hp"){
				if (isCrit){
					cur = hpCritNum;
				}else{
					cur = hpNum;
				}
			}else{
				if (isCrit){
					cur = armorCritNum;
				}else{
					cur = armorNum;
				}
			}
			cur.setDmg(num);
			this.addChild(cur);
			this.scaleX = 0;
			this.scaleY = 0;
			this.alpha = 1;
			Tween.to(this, {scaleX:1, scaleY:1}, 500, Ease.backOut, Handler.create(this, onComplete1));
		}
		
		private function onComplete1():void
		{
			Tween.to(this, {y:y-100, alpha:0.5}, 500, null, Handler.create(this, onComplete2));
		}
		
		private function onComplete2():void
		{
			MainLayer.me.inPoolDmgNum(this);
		}
		
	}
}