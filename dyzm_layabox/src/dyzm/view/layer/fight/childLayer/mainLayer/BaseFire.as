package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.Res;
	import dyzm.manager.Cfg;
	import dyzm.util.IDict;
	
	import laya.display.Animation;
	import laya.events.Event;

	public class BaseFire extends Animation implements IDict
	{
		private var _keyId:int;
		public var yy:Number;
		public var fireTypeToUrl:Object = {
			1:Res.knifeFireAtlas
		}
		public function BaseFire()
		{
			super();
			_keyId = Cfg.getKeyId();
			yy = _y;
			this.blendMode = "lighter";
		}
		
		public function playFire(fireType:int, _y:Number, fireRotation:int):void
		{
			this.interval = 20;
			this.pivotX = 37;
			this.pivotY = 374;
			this.play(0, false, fireTypeToUrl[fireType]);
			this.rotation = fireRotation;
			this.once(Event.COMPLETE, this, onComplete);
		}
		
		public function onComplete():void
		{
			MainLayer.me.inPoolBaseFire(this);
		}
		
		public function get keyId():int
		{
			return _keyId;
		}
	}
}