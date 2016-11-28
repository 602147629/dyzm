package dyzm.data.equip.t2
{
	import dyzm.data.equip.BaseEquip;

	public class Glasses2 extends BaseEquip
	{
		public function Glasses2()
		{
			super();
			lv = 2;
			type = BaseEquip.TYPE_GLASSES;
			name = "T2眼镜";
			icon = "";
			baseAttr.critDmg = 3;
		}
	}
}