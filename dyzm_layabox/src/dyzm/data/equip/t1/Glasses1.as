package dyzm.data.equip.t1
{
	import dyzm.data.equip.BaseEquip;

	public class Glasses1 extends BaseEquip
	{
		public function Glasses1()
		{
			super();
			lv = 1;
			type = BaseEquip.TYPE_GLASSES;
			name = "T1眼镜";
			icon = "";
			baseAttr.critDmg = 1;
			canOpenGem = [1];
			openGem = [];
		}
	}
}