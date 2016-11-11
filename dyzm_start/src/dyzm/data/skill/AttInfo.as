package dyzm.data.skill
{
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
		 * 火花类型, 横刀
		 */
		public static const FIRE_TYPE_SHARP_TRANSVERSE:int = 1;
		/**
		 * 火花类型, 竖刀
		 */
		public static const FIRE_TYPE_SHARP_VERTICAL:int = 2;
		/**
		 * 火花类型,拳头
		 */
		public static const FIRE_TYPE_FIST:int = 3;
		
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
		public var isFly:Boolean = true;
		/**
		 * 打退距离
		 */
		public var x:Number = 100;
		
		/**
		 * 打退距离,每帧,浮空状态使用
		 */
		public var xFrame:Number = 1;
		/**
		 * 击飞高度, 负数向上
		 */
		public var z:Number = -50;
		
		/**
		 * 可以攻击到距离我上面多少范围的人
		 */
		public var upY:Number = 30;
		
		/**
		 * 可以攻击到距离我下面多少范围的人
		 */
		public var downY:Number = 30;
		
		/**
		 * 击飞递减
		 */
		public var zDecline:Number = 0.1;
		
		/**
		 * 攻击力
		 */
		public var att:int = 0;
		/**
		 * 破甲
		 */
		public var armor:int = 0;
		
		/**
		 * 硬直帧数
		 */
		public var stiffFrame:int = 60;
		
		/**
		 * 可攻击到的块区类型
		 */		
		public var byList:Array;
		
		/**
		 * 攻击火花类型
		 */
		public var attFireType:int = FIRE_TYPE_SHARP_TRANSVERSE;
		
		/**
		 * 防御火花类型
		 */
		public var defFireType:int = FIRE_TYPE_SHARP_TRANSVERSE;
		
		public var foeAction:String = YANG_TIAN;
		
		/**
		 * 震幅
		 */
		public var range:int = 4;
		
		
		/**
		 * 技能发动时,是否可以改变方向
		 */
		public var canTurn:Boolean = false;
		
		 
		public function AttInfo()
		{
		}
	}
}