package dyzm.data
{
	import dyzm.data.attr.AttrVo;

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
			attr.hp = 100000;
			attr.hpMax = 100000;
			attr.armor = 0;
			attr.maxArmor = 0;
			attr.attMin = 1;
			attr.attMax = 2;
			attr.attArmor = 1;
			attr.critRate = 0;
			attr.critDmg = 1;
			attr.def = 0;
			attr.mf = 0;
			attr.gf = 0;
			attr.iceAtt = 0;
			attr.iceDef = 0;
			attr.fireAtt = 0;
			attr.fireDef = 0;
			attr.thundAtt = 0;
			attr.thundDef = 0;
			attr.toxinAtt = 0;
			attr.toxinDef = 0;
			attr.invincibleFrame = 120;
			attr.moveSpeed = 4;
			attr.runSpeed = 10;
			attr.jumpPower = -30;
		}
	}
}