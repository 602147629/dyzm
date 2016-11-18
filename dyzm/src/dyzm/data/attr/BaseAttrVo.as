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
		public var invincibleFrame:int = 0;
		
		/**
		 * 走路速度 
		 */		
		public var moveSpeed:Number = 0;
		
		/**
		 * 跑步速度
		 */
		public var runSpeed:Number = 0;
		
		/**
		 * 起跳力度
		 */
		public var jumpPower:Number = 0;
		
		public function BaseAttrVo()
		{
		}
		
		/**
		 * 当前属性加上参数属性
		 * @param b
		 * @return 
		 */
		public function add(b:BaseAttrVo):void
		{
			hp += b.hp;
			hpMax += b.hpMax;
			armor += b.armor;
			maxArmor += b.maxArmor;
			attMin += b.attMin;
			attMax += b.attMax;
			attArmor += b.attArmor;
			critRate += b.critRate;
			critDmg += b.critDmg;
			def += b.def;
			mf += b.mf;
			gf += b.gf;
			iceAtt += b.iceAtt;
			iceDef += b.iceDef;
			fireAtt += b.fireAtt;
			fireDef += b.fireDef;
			thundAtt += b.thundAtt;
			thundDef += b.thundDef;
			toxinAtt += b.toxinAtt;
			toxinDef += b.toxinDef;
			
			moveSpeed += b.moveSpeed;
			runSpeed += b.runSpeed;
			jumpPower += b.jumpPower;
		}
	}
}