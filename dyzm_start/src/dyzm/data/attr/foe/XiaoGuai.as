package dyzm.data.attr.foe
{
	import asset.Role_1;

	public class XiaoGuai extends BaseFoe
	{
		public function XiaoGuai()
		{
			super();
			
			name = "小怪";
			hp = 3;
			hpMax = 3;
			attMin = 1;
			attMax = 2;
			style = Role_1;
		}
	}
}