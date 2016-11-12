package dyzm.view.layer.fight.item
{
	import asset.Role_1;
	
	import dyzm.data.role.BaseAiControl;

	/**
	 * 敌方人物,带AI
	 * @author dj
	 */
	public class FoeRole extends BaseRole
	{
		public var aiControl:BaseAiControl;
		public function FoeRole(role:BaseAiControl)
		{
			super(role);
			mc = new Role_1();
			this.addChild(mc);
			roleVo.roleMc = mc;
			aiControl = role;
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
		}
	}
}