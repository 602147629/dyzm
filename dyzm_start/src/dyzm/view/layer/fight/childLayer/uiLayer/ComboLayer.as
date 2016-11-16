package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.data.FightData;
	import dyzm.view.layer.fight.item.BaseItem;
	
	import ui.ComboNum;

	public class ComboLayer extends BaseItem
	{
		private var num:ComboNum;
		public function ComboLayer()
		{
			num = new ComboNum();
			this.addChild(num);
			
			num.x = 0;
			num.y = 300;
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			if (FightData.mainRole.maxCombo > 1){
				num.txt.text = FightData.mainRole.maxCombo + "连击";
			}else{
				num.txt.text = "";
			}
			
		}
	}
}