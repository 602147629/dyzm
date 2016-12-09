package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.Res;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Asset;
	import dyzm.view.layer.fight.childLayer.uiLayer.base.ArmorBar;
	import dyzm.view.layer.fight.childLayer.uiLayer.base.HpBar;
	
	import laya.display.Sprite;
	
	public class FoeHpBar extends Sprite 
	{
		protected var roleVo:RoleVo;
		protected var hpBar:HpBar;
		protected var armorBar:ArmorBar;
		public function FoeHpBar(roleVo:RoleVo)
		{
			super();
			this.roleVo = roleVo;
			this.x = -100;
			this.y = -roleVo.h;
			this.texture = Asset.getRes(Res.foeHpDi);
			
			
			
			armorBar = new ArmorBar();
			armorBar.scaleX = 0.6;
			armorBar.scaleY = 0.5;
			armorBar.x = 22;
			armorBar.y = 3;
			this.addChild(armorBar);
			
			hpBar = new HpBar();
			hpBar.scaleX = 0.64;
			hpBar.scaleY = 0.5;
			hpBar.x = 7;
			hpBar.y = 11;
			this.addChild(hpBar);
		}
		
		public function setRole(role:RoleVo):void
		{
			roleVo = role;
		}
		
		public function frameUpdate():void
		{
			armorBar.max = roleVo.curAttr.maxArmor;
			armorBar.value = roleVo.curAttr.armor;
			
			if (roleVo.curAttr.maxHp){
				hpBar.value = roleVo.curAttr.hp / roleVo.curAttr.maxHp;
			}else{
				hpBar.value = 0;
			}
		}
	}
}