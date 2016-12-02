package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.data.FightData;
	import dyzm.view.base.BaseLayer;

	public class UiLayer extends BaseLayer
	{
		/**
		 * 怪物箭头
		 */
		public var arrowList:Array;
		public var comboLayer:ComboLayer;
		public var skillLayer:SkillLayer;
		
		public var dirLayer:DirLayer;
		
		public var view:FightUi;
		public function UiLayer()
		{
			super();
			
			view = new FightUi();
			this.addChild(view);
			
			// 怪物跑出屏幕后,显示箭头
			arrowList = [];
			for (var i:int = 0; i < FightData.foeList.length; i++) 
			{
				arrowList[i] = new FoeArrow(FightData.foeList[i], i);
				this.addChild(arrowList[i]);
			}
			
			comboLayer = new ComboLayer();
			this.addChild(comboLayer);
			
			skillLayer = new SkillLayer();
			this.addChild(skillLayer);
			
			dirLayer = new DirLayer();
			this.addChild(dirLayer);
			
			frameUpdate();
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			
			for (var i:int = 0; i < arrowList.length; i++) 
			{
				arrowList[i].frameUpdate();
			}
			comboLayer.frameUpdate();
			
			view.frameUpadte();
		}
	}
}