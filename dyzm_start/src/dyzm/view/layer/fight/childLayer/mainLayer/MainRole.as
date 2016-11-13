package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.data.role.PlayerControl;

	/**
	 * 主角
	 * @author dj
	 */
	public class MainRole extends BaseRole
	{
		public var mianRoleControl:PlayerControl;
		public function MainRole(role:PlayerControl)
		{
			super(role);
			mianRoleControl = role;
		}
		
		/**
		 * 按键方向,已经进过按键控制类处理为小键盘1-9个方向
		 * @param dir
		 */		
		public function setDir(dir:int):void
		{
			mianRoleControl.setDir(dir);
		}
		
		public function setRun(isRun:Boolean):void
		{
			mianRoleControl.setRun(isRun);
		}
		
		public function setJump():void
		{
			mianRoleControl.setJump();
		}
		
		
		public function setSkill(id:int):void
		{
			mianRoleControl.setSkill(id);
		}
		
	}
}