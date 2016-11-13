package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.data.role.RoleVo;
	import dyzm.data.role.foe.BaseAiControl;
	import dyzm.view.baseUi.HpBar;

	/**
	 * 敌方人物,带AI
	 * @author dj
	 */
	public class FoeRole extends BaseRole
	{
		
		public var hpBar:HpBar;
		
		public function FoeRole(role:BaseAiControl)
		{
			super(role);
			hpBar = new HpBar(this, role);
		}
		
		public function setRole(role:RoleVo):void
		{
			if (roleVo.style != role.style){
				turnContainer.removeChild(mc);
				mc = new role.style();
				turnContainer.addChild(mc);
			}
			roleVo = role;
			roleVo.roleMc = mc;
			hpBar.setRole(role);
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			hpBar.frameUpdate();
		}
	}
}