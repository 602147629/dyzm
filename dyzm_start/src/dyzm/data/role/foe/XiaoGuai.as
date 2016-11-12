package dyzm.data.role.foe
{
	import asset.Role_1;

	public class XiaoGuai extends BaseAiControl
	{
		public function XiaoGuai()
		{
			super();
			
			name = "小怪";
			style = Role_1;
			
			attr.hp = 3;
			attr.hpMax = 3;
			attr.attMin = 1;
			attr.attMax = 2;
		}
	}
}