package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.data.FightData;
	import dyzm.view.layer.fight.item.BaseItem;
	
	import laya.display.Text;
	

	public class ComboLayer extends BaseItem
	{
		private var num:Text;
		public function ComboLayer()
		{
			num = new Text();
			this.addChild(num);
			
			num.x = 0;
			num.y = 300;
			num.align = "left";
			num.fontSize = 48;
			num.color = "#ff0000";
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			if (FightData.mainRole.maxCombo > 1){
				num.text = FightData.mainRole.maxCombo + "连击";
			}else{
				num.text = "";
			}
			
		}
	}
}