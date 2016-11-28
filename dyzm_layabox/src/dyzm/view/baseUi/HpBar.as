package dyzm.view.baseUi
{
	import flash.display.Sprite;
	
	import dyzm.data.role.RoleVo;
	
	public class HpBar extends Sprite
	{
		
		protected var roleVo:RoleVo;
		public function HpBar(roleVo:RoleVo)
		{
			
		}
		
		public function setRole(role:RoleVo):void
		{
			roleVo = role;
		}
		
		public function frameUpdate():void
		{
//			if (_value != roleVo.curAttr.hp || _max != roleVo.curAttr.maxHp){
//				_max = roleVo.curAttr.maxHp;
//				_value = Math.min(roleVo.curAttr.hp, _max);
//				update();
//			}
		}
	}
}