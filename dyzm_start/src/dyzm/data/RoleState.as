package dyzm.data
{
	/**
	 * 人物状态控制器
	 * @author dj
	 */
	public class RoleState
	{
		// ↓↓↓↓↓↓↓↓↓受控状态↓↓↓↓↓↓↓↓↓↓
		/**
		 * 正常状态
		 */
		public static const STATE_NORMAL:int = 0;
		/**
		 * 浮空状态,空中不受控制状态 
		 */		
		public static const STATE_FLY:int = 1;
		/**
		 * 空中状态,空中受控制状态
		 */		
		public static const STATE_AIR:int = 2;
		/**
		 * 硬直状态
		 */
		public static const STATE_STIFF:int = 3;
		/**
		 * 趟地状态
		 */
		public static const STATE_FLOOD:int = 4;
		/**
		 * 站起状态
		 */
		public static const STATE_STAND_UP:int = 5;
		/**
		 * 倒下状态
		 */
		public static const STATE_DOWNING:int = 6;
		/**
		 * 死亡状态
		 */
		public static const STATE_DEATH:int = 7;
		/**
		 * 弹起阶段
		 */
		public static const STATE_BOUNCE:int = 8;
		// ↑↑↑↑↑↑↑↑↑受控状态↑↑↑↑↑↑↑↑↑↑
		
		
		// ↓↓↓↓↓↓↓↓↓攻击状态↓↓↓↓↓↓↓↓↓↓
		/**
		 * 不在攻击中
		 */
		public static const ATT_NORMAL:int = 0;
		/**
		 * 攻击前摇中
		 */
		public static const ATT_BEFORE:int = 1;
		/**
		 * 攻击中
		 */
		public static const ATT_ING:int = 2;
		/**
		 * 攻击后摇中
		 */
		public static const ATT_AFTER:int = 3;
		/**
		 * 可以任意取消的攻击后摇,一般为技能最后无意义的耍帅动作
		 */
		public static const ATT_AFTER_CANCEL:int = 4;
		
		// ↑↑↑↑↑↑↑↑↑攻击状态↑↑↑↑↑↑↑↑↑↑
		
	}
}