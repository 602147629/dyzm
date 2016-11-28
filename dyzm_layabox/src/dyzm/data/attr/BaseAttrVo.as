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
		public var maxHp:int = 0;
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
		public var minAtt:int = 0;
		/**
		 * 最大攻击力
		 */
		public var maxAtt:int = 0;
		/**
		 * 破甲
		 */
		public var attArmor:int = 0;
		/**
		 * 暴击伤害
		 */
		public var critDmg:int = 0;
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
			maxHp += b.maxHp;
			armor += b.armor;
			maxArmor += b.maxArmor;
			minAtt += b.minAtt;
			maxAtt += b.maxAtt;
			attArmor += b.attArmor;
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
		
		/**
		 * 属性清零
		 */
		public function toZero():void
		{
			hp = 0;
			maxHp = 0;
			armor = 0;
			maxArmor = 0;
			minAtt = 0;
			maxAtt = 0;
			attArmor = 0;
			critDmg = 0;
			def = 0;
			mf = 0;
			gf = 0;
			iceAtt = 0;
			iceDef = 0;
			fireAtt = 0;
			fireDef = 0;
			thundAtt = 0;
			thundDef = 0;
			toxinAtt = 0;
			toxinDef = 0;
			
			moveSpeed = 0;
			runSpeed = 0;
			jumpPower = 0;
		}
		
		public function toObj():Object
		{
			return {
				hp:hp,
				maxHp:maxHp,
				armor:armor,
				maxArmor:maxArmor,
				minAtt:minAtt,
				maxAtt:maxAtt,
				attArmor:attArmor,
				critDmg:critDmg,
				def:def,
				mf:mf,
				gf:gf,
				iceAtt:iceAtt,
				iceDef:iceDef,
				fireAtt:fireAtt,
				fireDef:fireDef,
				thundAtt:thundAtt,
				thundDef:thundDef,
				toxinAtt:toxinAtt,
				toxinDef:toxinDef,
				
				moveSpeed:moveSpeed,
				runSpeed:runSpeed,
				jumpPower:jumpPower
			}
		}
		
		public function formObj(obj:Object):void
		{
			for (var i:String in obj) 
			{
				if (this.hasOwnProperty(i)){
					this[i] = obj[i];
				}
			}
		}
	}
}