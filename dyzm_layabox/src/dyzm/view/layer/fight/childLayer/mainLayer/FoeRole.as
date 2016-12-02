package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.data.role.RoleVo;
	import dyzm.data.role.foe.BaseAiControl;
	import dyzm.manager.Asset;

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
			hpBar = new HpBar(role);
			this.addChild(hpBar);
		}
		
		public function setRole(role:RoleVo):void
		{
			role.roleMc = roleVo.roleMc;
			role.roleMc.setData(Asset.getRes(role.style));
			role.roleMc.setSkinFromSkinVo(role.skin);
			
			roleVo = role;
			hpBar.setRole(role);
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			hpBar.frameUpdate();
		}
	}
}