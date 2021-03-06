package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.data.role.PlayerControl;

	/**
	 * 主角
	 * @author dj
	 */
	public class PlayerRole extends BaseRole
	{
		public var mianRoleControl:PlayerControl;
		public var skillId:int = 0;
		public const  INPUT_DELAY:int = 15;
		public var  curInputDelay:int = 0;
		public function PlayerRole(role:PlayerControl)
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
		
		public function setSkill(id:int):void
		{
			skillId = id;
			curInputDelay = INPUT_DELAY;
		}
		
		override public function frameUpdate():void
		{
			if (skillId != 0){
				if (mianRoleControl.setSkill(skillId)){
					skillId = 0;
				}else{
					curInputDelay --;
					if (curInputDelay < 0){
						skillId = 0;
					}
				}
			}
			super.frameUpdate();
			
		}
	}
}