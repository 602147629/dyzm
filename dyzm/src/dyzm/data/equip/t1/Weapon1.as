package dyzm.data.equip.t1
{
	import asset.T1Weapon;
	
	import dyzm.data.equip.BaseEquip;

	public class Weapon1 extends BaseEquip
	{
		public function Weapon1()
		{
			super();
			lv = 1;
			type = BaseEquip.TYPE_WEAPON;
			name = "T1武器";
			icon = "";
			img = new T1Weapon;
			baseAttr.minAtt = 1;
			baseAttr.maxAtt = 2;
		}
	}
}