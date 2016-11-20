package dyzm.data.equip.t1
{
	import dyzm.data.equip.BaseEquip;
	
	public class Belt1 extends BaseEquip
	{
		public function Belt1()
		{
			super();
			lv = 1;
			type = BaseEquip.TYPE_GLASSES;
			name = "T1腰带";
			icon = "";
			baseAttr.maxHp = 5;
		}
	}
}