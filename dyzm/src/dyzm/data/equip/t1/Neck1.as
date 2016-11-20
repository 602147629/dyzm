package dyzm.data.equip.t1
{
	import dyzm.data.equip.BaseEquip;

	public class Neck1 extends BaseEquip
	{
		public function Neck1()
		{
			super();
			lv = 1;
			type = BaseEquip.TYPE_NECK;
			name = "T1项链";
			icon = "";
			baseAttr.invincibleFrame = 60;
		}
	}
}