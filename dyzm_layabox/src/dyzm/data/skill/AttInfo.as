package dyzm.data.skill
{
	import dyzm.data.attr.BaseAttrVo;

	/**
	 * 本次攻击的属性
	 * @author dj
	 * 
	 */
	public class AttInfo
	{
		/**
		 * 普通被攻击块
		 */
		public static const BY_ATT_NORMAL:int = 1;
		
		/**
		 * 倒地时的被攻击块
		 */
		public static const BY_ATT_FELL:int = 2;
		
		
		/**
		 * 火花类型,刀光
		 */
		public static const FIRE_TYPE_KNIFE:int = 1;
		/**
		 * 火花类型,拳头
		 */
		public static const FIRE_TYPE_FIST:int = 2;
		
		/**
		 * 对方动作
		 */
		public static const YANG_TIAN:String  = "仰天";
		
		public static const DI_TOU:String  = "低头";
		
		/**
		 * 当前攻击点位
		 */
		public var curAttSpot:int = 1;
		/**
		 * 是否把对方击飞
		 */
		public var isFly:Boolean = false;
		/**
		 * 打退距离
		 */
		public var x:Number = 0;
		
		/**
		 * 打退距离,每帧,浮空状态使用
		 */
		public var xFrame:Number = 0;
		/**
		 * 击飞高度, 负数向上
		 */
		public var z:Number = 0;
		/**
		 * 最小反弹高度
		 */
		public var minBounceZ:Number = 0;
		
		
		/**
		 * 可以攻击到距离我上面多少范围的人
		 */
		public var upY:Number = 0;
		
		/**
		 * 可以攻击到距离我下面多少范围的人
		 */
		public var downY:Number = 0;
		
		/**
		 * 硬直递减
		 */
		public var stiffDecline:Number = 0;
		/**
		 * 击飞递减
		 */
		public var zDecline:Number = 0;
		
		/**
		 * 攻击递减
		 */
		public var attDecline:Number = 0;
		
		/**
		 * 破甲递减
		 */
		public var armorDecline:Number = 0;
		/**
		 * 技能属性
		 */
		public var attr:BaseAttrVo = new BaseAttrVo;
		
		/**
		 * 硬直帧数
		 */
		public var stiffFrame:int = 0;
		
		/**
		 * 可攻击到的块区类型
		 */		
		public var byList:Array;
		
		/**
		 * 攻击火花类型
		 */
		public var attFireType:int = FIRE_TYPE_KNIFE;
		/**
		 * 防御火花类型
		 */
		public var defFireType:int = FIRE_TYPE_KNIFE;
		
		/**
		 * 火花角度
		 */
		public var attFireRotation:int = 0;
		
		/**
		 * 攻击到头的动作
		 */
		public var foeActionToHead:String = YANG_TIAN;
		/**
		 * 攻击到身体的动作
		 */
		public var foeAction:String = DI_TOU;
		
		/**
		 * 震幅
		 */
		public var range:int = 0;
		
		
		/**
		 * 技能发动时,是否可以改变方向
		 */
		public var canTurn:Boolean = false;
		
		/**
		 * 是否必定暴击
		 */
		public var isCrit:Boolean = false;
		
		/**
		 * 是否必定硬直,即使被格挡或者未造成伤害也会使目标硬直或浮空
		 */
		public var isStiff:Boolean = false;
		 
		public function AttInfo()
		{
		}
	}
}