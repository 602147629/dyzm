package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.Res;
	import dyzm.data.role.RoleVo;
	
	import laya.display.Sprite;
	import laya.ui.ProgressBar;
	
	public class HpBar extends Sprite
	{
		protected var roleVo:RoleVo;
		protected var hpBar:ProgressBar;
		protected var armorBar:ProgressBar;
		public function HpBar(roleVo:RoleVo)
		{
			super();
			this.roleVo = roleVo;
			this.x = -100;
			this.y = -roleVo.h;
			
			armorBar = new ProgressBar(Res.armorBar);
			armorBar.sizeGrid = "3,3,3,3";
			armorBar.y = -20;
			armorBar.width = 200;
			armorBar.height = 20;
			this.addChild(armorBar);
			
			hpBar = new ProgressBar(Res.hpBar);
			hpBar.sizeGrid = "3,3,3,3";
			hpBar.width = 200;
			hpBar.height = 20;
			this.addChild(hpBar);
			
		}
		
		public function setRole(role:RoleVo):void
		{
			roleVo = role;
		}
		
		public function frameUpdate():void
		{
			if (roleVo.curAttr.maxArmor){
				armorBar.value = roleVo.curAttr.armor / roleVo.curAttr.maxArmor;
			}else{
				armorBar.value = 0;
			}
			
			if (roleVo.curAttr.maxHp){
				hpBar.value = roleVo.curAttr.hp / roleVo.curAttr.maxHp;
			}else{
				hpBar.value = 0;
			}
				
		}
	}
}