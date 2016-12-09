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
		
		public var hpBar:FoeHpBar;
		
		public function FoeRole(role:BaseAiControl)
		{
			super(role);
			hpBar = new FoeHpBar(role);
			this.addChild(hpBar);
		}
		
		public function setRole(role:RoleVo):void
		{
			role.roleMc = roleVo.roleMc;
			role.roleSpr = this;
			role.roleMc.setData(Asset.getRes(role.style));
			role.roleMc.setSkinFromSkinVo(role.skin);
			
			roleVo = role;
			hpBar.setRole(role);
			hpBar.visible = true;
			shadow.visible = true;
			frameUpdate();
		}
		
		override public function explode():void
		{
			hpBar.visible = false;
			super.explode();
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			hpBar.frameUpdate();
		}
	}
}