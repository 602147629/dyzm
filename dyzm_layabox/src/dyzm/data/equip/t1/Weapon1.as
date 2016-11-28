package dyzm.data.equip.t1
{
	import dyzm.Res;
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
			iconAtlas = Res.equipIconAtlas;
			img = Res.jian1;
			imgAtlas = Res.equipImgAtlas;
			baseAttr.minAtt = 1;
			baseAttr.maxAtt = 2;
			canOpenGem = [1,2,3];
			openGem = [];
		}
	}
}