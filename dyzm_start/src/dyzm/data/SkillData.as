package dyzm.data
{
	public class SkillData
	{
		/**
		 * 体系
		 */
		public static const XI_TI:int = 1;
		
		/**
		 * 剑系
		 */
		public static const XI_JIAN:int = 2;
		
		/**
		 * 枪系
		 */
		public static const XI_QIANG:int = 3;
		
		
		
		/**
		 * 地面技能
		 */
		public static const FLOOR:int = 1;
		
		/**
		 * 空中技能
		 */
		public static const SKY:int = 2;
		
		/**
		 * 跑中技能
		 */
		public static const RUN:int = 3;
		
		/**
		 * 攻击前摇的帧标签
		 */
		public static const FRAME_BEFORE:String = "before";
		
		/**
		 * 攻击前摇结束,正式进入攻击状态的帧标签
		 */
		public static const FRAME_ATT:String = "att";
		
		/**
		 * 攻击结束,进入攻击后摇状态的帧标签
		 */
		public static const FRAME_AFTER:String = "after";
		
		/**
		 * 攻击后摇结束,进入耍帅动作的帧标签
		 */
		public static const FRAME_AFTER_CANCEL:String = "cancel";
		
		/**
		 * 帧标签对应的攻击状态
		 */
		public static const FRAME_TO_STATE:Object = {
			"before":RoleState.ATT_BEFORE,
				"att":RoleState.ATT_ING,
				"after":RoleState.ATT_AFTER,
				"cancel":RoleState.ATT_AFTER_CANCEL
		}
		
	}
}