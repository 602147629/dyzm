package dyzm.view.layer.fight.item
{
	import asset.Role_1;
	
	import dyzm.data.vo.RoleVo;

	/**
	 * 敌方人物,带AI
	 * @author dj
	 */
	public class FoeRole extends BaseRole
	{
		public function FoeRole(role:RoleVo)
		{
			super(role);
			mc = new Role_1();
			this.addChild(mc);
			roleVo.roleMc = mc;
		}
	}
}