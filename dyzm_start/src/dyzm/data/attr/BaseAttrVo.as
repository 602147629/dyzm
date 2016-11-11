package dyzm.data.attr
{
	/**
	 * 基础属性
	 * @author dj
	 */
	public class BaseAttrVo
	{
		/**
		 * 当前生命值
		 */
		public var hp:int = 0;
		/**
		 * 最大生命值
		 */
		public var hpMax:int = 0;
		/**
		 * 当前护甲
		 */
		public var armor:int = 0;
		/**
		 * 最大护甲
		 */
		public var maxArmor:int = 0;
		/**
		 * 最小攻击力
		 */
		public var attMin:int = 0;
		/**
		 * 最大攻击力
		 */
		public var attMax:int = 0;
		/**
		 * 破甲
		 */
		public var attArmor:int = 0;
		/**
		 * 暴击率
		 */
		public var critRate:Number = 0;
		/**
		 * 暴击伤害
		 */
		public var critDmg:Number = 0;
		/**
		 * 防御
		 */
		public var def:int = 0;
		
		/**
		 * 获得更好装备的几率
		 */
		public var mf:Number = 0;
		
		/**
		 * 获得更多金币的几率
		 */
		public var gf:Number = 0;
		
		/**
		 * 冰攻
		 */
		public var iceAtt:int = 0;
		
		/**
		 * 冰防
		 */
		public var iceDef:int = 0;
		/**
		 * 火攻
		 */
		public var fireAtt:int = 0;
		/**
		 * 火防
		 */
		public var fireDef:int = 0;
		/**
		 * 电攻
		 */
		public var thundAtt:int = 0;
		/**
		 * 电防
		 */
		public var thundDef:int = 0;
		
		/**
		 * 毒攻
		 */
		public var toxinAtt:int = 0;
		/**
		 * 毒防
		 */
		public var toxinDef:int = 0;
		/**
		 * 起身无敌帧数
		 */
		public var invincibleFrame:int = 120;
		
		public function BaseAttrVo()
		{
		}
		
		/**
		 * 两个属性相加,a+=b,a改变,b不变
		 * @param a
		 * @param b
		 * @return 
		 */
		public static function add(a:BaseAttrVo, b:BaseAttrVo):void
		{
			a.hp += b.hp;
			a.hpMax += b.hpMax;
			a.armor += b.armor;
			a.maxArmor += b.maxArmor;
			a.attMin += b.attMin;
			a.attMax += b.attMax;
			a.attArmor += b.attArmor;
			a.critRate += b.critRate;
			a.critDmg += b.critDmg;
			a.def += b.def;
			a.mf += b.mf;
			a.gf += b.gf;
			a.iceAtt += b.iceAtt;
			a.iceDef += b.iceDef;
			a.fireAtt += b.fireAtt;
			a.fireDef += b.fireDef;
			a.thundAtt += b.thundAtt;
			a.thundDef += b.thundDef;
			a.toxinAtt += b.toxinAtt;
			a.toxinDef += b.toxinDef;
		}
	}
}