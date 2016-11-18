package dyzm.view.baseUi
{
	import com.bit101.components.ProgressBar;
	
	import flash.display.DisplayObjectContainer;
	
	import dyzm.data.role.RoleVo;
	
	public class HpBar extends ProgressBar
	{
		
		protected var roleVo:RoleVo;
		public function HpBar(parent:DisplayObjectContainer, roleVo:RoleVo)
		{
			super(parent, -70, -roleVo.h);
			this.setSize(140, 15);
			this.roleVo = roleVo;
		}
		
		public function setRole(role:RoleVo):void
		{
			roleVo = role;
		}
		
		public function frameUpdate():void
		{
			if (_value != roleVo.curAttr.hp || _max != roleVo.curAttr.hpMax){
				_max = roleVo.curAttr.hpMax;
				_value = Math.min(roleVo.curAttr.hp, _max);
				update();
			}
		}
	}
}