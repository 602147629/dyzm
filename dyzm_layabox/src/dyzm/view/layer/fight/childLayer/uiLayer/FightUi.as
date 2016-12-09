package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.data.FightData;
	import dyzm.data.attr.BaseAttrVo;
	import dyzm.view.layer.fight.childLayer.uiLayer.base.ArmorBar;
	import dyzm.view.layer.fight.childLayer.uiLayer.base.BaseFightUI;
	import dyzm.view.layer.fight.childLayer.uiLayer.base.HpBar;

	public class FightUi extends BaseFightUI
	{
		public var _armorBar:ArmorBar;
		public var _hpBar:HpBar;
		public function FightUi()
		{
			super();
			_armorBar = new ArmorBar;
			this.addChild(_armorBar);
			_hpBar = new HpBar();
			this.addChild(_hpBar);
			align();
		}
		
		
		public function align():void
		{
			_armorBar.x = 86;
			_armorBar.y = 54;
			_hpBar.x = 67;
			_hpBar.y = 70;
		}
		
		public function frameUpadte():void
		{
			var attr:BaseAttrVo = FightData.mainRole.curAttr;
			if (attr.maxArmor){
				_armorBar.max = attr.maxArmor;
				_armorBar.value = attr.armor;
			}else{
				_armorBar.max = 0;
				_armorBar.value = 0;
			}
			
			if (attr.maxHp){
				_hpBar.value = attr.hp / attr.maxHp;
			}else{
				_hpBar.value = 0;
			}
		}
	}
}