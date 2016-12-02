package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.data.FightData;
	import dyzm.data.attr.BaseAttrVo;
	import dyzm.view.layer.fight.childLayer.uiLayer.base.BaseFightUI;

	public class FightUi extends BaseFightUI
	{
		public function FightUi()
		{
			super();
		}
		
		override protected function createChildren():void {
			super.createChildren();
			align();
		}
		
		
		public function align():void
		{
			this.armorBar.x = 60;
			this.armorBar.y = 20;
			
			this.hpBar.x = 60;
			this.hpBar.y = 40;
		}
		
		public function frameUpadte():void
		{
			var attr:BaseAttrVo = FightData.mainRole.curAttr;
			if (attr.maxArmor){
				this.armorBar.value = attr.armor / attr.maxArmor;
			}else{
				this.armorBar.value = 0;
			}
			if (attr.maxHp){
				this.hpBar.value = attr.hp / attr.maxHp;
			}else{
				this.hpBar.value = 0;
			}
		}
	}
}