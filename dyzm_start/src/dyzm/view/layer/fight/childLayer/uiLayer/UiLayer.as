package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.data.FightData;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.layer.fight.childLayer.mainLayer.FoeArrow;

	public class UiLayer extends BaseLayer
	{
		/**
		 * 怪物箭头
		 */
		public var arrowList:Vector.<FoeArrow>;
		
		public function UiLayer()
		{
			super();
			
			arrowList = new Vector.<FoeArrow>;
			for (var i:int = 0; i < FightData.foeList.length; i++) 
			{
				arrowList[i] = new FoeArrow(FightData.foeList[i]);
				this.addChild(arrowList[i]);
			}
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			
			for (var i:int = 0; i < arrowList.length; i++) 
			{
				arrowList[i] = new FoeArrow(FightData.foeList[i]);
				this.addChild(arrowList[i]);
			}
		}
	}
}