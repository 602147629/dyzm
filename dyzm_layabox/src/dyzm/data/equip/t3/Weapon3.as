package dyzm.data.equip.t3
{
	import dyzm.Res;
	import dyzm.data.equip.BaseEquip;

	public class Weapon3 extends BaseEquip
	{
		public function Weapon3()
		{
			super();
			lv = 2;
			type = BaseEquip.TYPE_WEAPON;
			name = "T2武器";
			icon = "";
			iconAtlas = Res.equipIconAtlas;
			img = Res.jian1;
			imgAtlas = Res.equipImgAtlas;
			baseAttr.minAtt = 1;
			baseAttr.maxAtt = 2;
		}
	}
}