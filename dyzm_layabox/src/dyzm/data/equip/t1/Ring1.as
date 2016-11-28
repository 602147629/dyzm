package dyzm.data.equip.t1
{
	import dyzm.data.equip.BaseEquip;
	
	public class Ring1 extends BaseEquip
	{
		public function Ring1()
		{
			super();
			lv = 1;
			type = BaseEquip.TYPE_RING;
			name = "T1戒指";
			icon = "";
			baseAttr.attArmor = 1;
			canOpenGem = [3];
			openGem = [];
		}
	}
}