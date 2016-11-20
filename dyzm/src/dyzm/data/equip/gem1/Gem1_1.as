package dyzm.data.equip.gem1
{
	import dyzm.data.equip.BaseGem;
	
	import gem.Gem1;

	public class Gem1_1 extends BaseGem
	{
		public function Gem1_1()
		{
			super();
			lv = 1;
			type = BaseGem.TYPE_DIAMOND;
			name = "1号砖石";
			icon = "";
			img = new Gem1;
			
			minAtt = 0;
			maxAtt = 1;
		}
	}
}