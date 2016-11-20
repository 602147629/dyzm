package dyzm.data.equip.t2
{
	import asset.T2Weapon;
	
	import dyzm.data.equip.BaseEquip;

	public class Weapon2 extends BaseEquip
	{
		public function Weapon2()
		{
			super();
			lv = 1;
			type = BaseEquip.TYPE_WEAPON;
			name = "T2武器";
			icon = "";
			img = new T2Weapon;
			baseAttr.minAtt = 1;
			baseAttr.maxAtt = 2;
		}
	}
}