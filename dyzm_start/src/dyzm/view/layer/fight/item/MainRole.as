package dyzm.view.layer.fight.item
{
	import asset.Role_1;
	
	import dyzm.data.vo.RoleVo;

	/**
	 * 主角
	 * @author dj
	 */
	public class MainRole extends BaseRole
	{
		public function MainRole(role:RoleVo)
		{
			super(role);
			mc = new Role_1();
			this.addChild(mc);
			roleVo.roleMc = mc;
		}
		
		/**
		 * 按键方向,已经进过按键控制类处理为小键盘1-9个方向
		 * @param dir
		 */		
		public function setDir(dir:int):void
		{
			roleVo.setDir(dir);
		}
		
		public function setRun(isRun:Boolean):void
		{
			roleVo.setRun(isRun);
		}
		
		public function setJump():void
		{
			roleVo.setJump();
		}
		
		
		public function setSkill(id:int):void
		{
			roleVo.setSkill(id);
		}
		
	}
}