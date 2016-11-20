package dyzm.data.equip.t1
{
	import dyzm.data.equip.BaseEquip;

	public class Hat1 extends BaseEquip
	{
		public function Hat1()
		{
			super();
			lv = 1;
			type = BaseEquip.TYPE_HAT;
			name = "T1帽子";
			icon = "";
			baseAttr.def = 1;
		}
	}
}