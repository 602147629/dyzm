package dyzm.view.layer.fight.childLayer.uiLayer.base
{
	import dyzm.Res;
	import dyzm.manager.Asset;
	
	import laya.display.Sprite;
	
	public class HpBar extends Sprite
	{
		public var maskSpr:Sprite;
		
		public var _value:Number = 1;
		public function HpBar()
		{
			super();
			texture = Asset.getRes(Res.hpBar);
			
			maskSpr = new Sprite();
			maskSpr.texture = Asset.getRes(Res.hpBar);
			
			mask = maskSpr;
		}
		
		public function set value(v:Number):void
		{
			if (_value == v) return;
			_value = v;
			maskSpr.x = texture.width * v - texture.width;
		}
	}
}