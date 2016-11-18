package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.data.FightData;
	import dyzm.view.base.BaseLayer;

	public class UiLayer extends BaseLayer
	{
		/**
		 * 怪物箭头
		 */
		public var arrowList:Vector.<FoeArrow>;
		public var comboLayer:ComboLayer;
		public var skillLayer:SkillLayer;
		public function UiLayer()
		{
			super();
			
			arrowList = new Vector.<FoeArrow>;
			for (var i:int = 0; i < FightData.foeList.length; i++) 
			{
				arrowList[i] = new FoeArrow(FightData.foeList[i], i);
				this.addChild(arrowList[i]);
			}
			
			comboLayer = new ComboLayer();
			this.addChild(comboLayer);
			
			skillLayer = new SkillLayer();
			this.addChild(skillLayer);
			
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			
			for (var i:int = 0; i < arrowList.length; i++) 
			{
				arrowList[i].frameUpdate();
			}
			comboLayer.frameUpdate();
		}
	}
}