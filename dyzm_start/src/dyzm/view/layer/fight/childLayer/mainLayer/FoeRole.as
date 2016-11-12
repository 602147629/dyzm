package dyzm.view.layer.fight.childLayer.mainLayer
{
	import asset.Role_1;
	
	import dyzm.data.role.foe.BaseAiControl;

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