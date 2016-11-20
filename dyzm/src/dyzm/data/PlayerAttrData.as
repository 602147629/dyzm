package dyzm.data
{
	import dyzm.data.attr.AttrVo;
	import dyzm.data.equip.gem1.Gem1_1;
	import dyzm.data.equip.t1.Belt1;
	import dyzm.data.equip.t1.Glasses1;
	import dyzm.data.equip.t1.Hat1;
	import dyzm.data.equip.t1.Neck1;
	import dyzm.data.equip.t1.Ring1;
	import dyzm.data.equip.t2.Weapon2;

	/**
	 * 主角属性
	 * @author dj
	 */
	public class PlayerAttrData
	{
		public static var attr:AttrVo;
		public static var lv:int;
		public static var exp:int;
		public static var gold:int;
		public static function init():void
		{
			lv = 1;
			exp = 0;
			attr = new AttrVo();
			
			attr.equip.weapon = new Weapon2();
			attr.equip.weapon.gem1 = new Gem1_1();
			attr.equip.weapon.gem2 = new Gem1_1();
			attr.equip.weapon.gem3 = new Gem1_1();
			attr.equip.hat = new Hat1();
			attr.equip.glasses = new Glasses1();
			attr.equip.belt = new Belt1();
			attr.equip.neck = new Neck1();
			attr.equip.ring = new Ring1();
			attr.handle();
			attr.hp = int.MAX_VALUE;
			attr.maxHp = int.MAX_VALUE;
		}
	}
}