package dyzm.data.equip.t3
{
	import dyzm.data.equip.BaseEquip;

	public class Neck3 extends BaseEquip
	{
		public function Neck3()
		{
			super();
			lv = 2;
			type = BaseEquip.TYPE_NECK;
			name = "T1项链";
			icon = "";
			baseAttr.maxArmor = 1;
			baseAttr.armor = 1;
		}
	}
}