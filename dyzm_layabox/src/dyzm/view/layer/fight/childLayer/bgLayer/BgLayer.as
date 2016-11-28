package dyzm.view.layer.fight.childLayer.bgLayer
{
	import dyzm.data.FightData;
	import dyzm.view.base.BaseLayer;

	public class BgLayer extends BaseLayer
	{
		public var bgInfo:Array;
		
		public var bgList:Array;
		public function BgLayer(info:Array)
		{
			super();
			bgInfo = info;
			bgList = [];
			var bg:BaseBgItem;
			for (var i:int = 0; i < bgInfo.length; i++) 
			{
				var a:Array = bgInfo[i];
				bg = new BaseBgItem();
				bg.setInfo(a);
				this.addChild(bg);
				bgList.push(bg);
			}
			frameUpdate();
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			var xx:Number = FightData.mainRole.x;
			var yy:Number = FightData.mainRole.y;
			var zz:Number = FightData.mainRole.z;
			
			for (var i:int = 0; i < bgList.length; i++) 
			{
				bgList[i].update(xx, yy, zz);
			}
		}
	}
}