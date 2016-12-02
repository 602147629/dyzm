package dyzm.data.table.skill
{
	public class SkillTableVo
	{
		/**
		 * 技能唯一标识
		 */
		public var id:String = "大风车";
		/**
		 * 技能执行类
		 */
		public var cls:Class;
		/**
		 * 技能名称
		 */
		public var name:String = "大风车";
		
		/**
		 * 技能介绍
		 */
		public var info:String = "空中停住,将目标击向地面,目标碰到地面后会弹起";
		
		/**
		 * 所属系
		 */
		public var xi:int = SkillTable.XI_TI;
		
		/**
		 * 启动状态
		 */
		public var startState:int = SkillTable.SKY;
		
		/**
		 * 帧名称
		 */
		public var frameName:String = "大风车";
		
		/**
		 * 学习需要灵力
		 */
		public var needGold:int = 100;
		
		/**
		 * 学习需要天数
		 */
		public var needDay:int = 1;
		
		/**
		 * 升级1名称
		 */
		public var up1Name:String = "轮回";
		/**
		 * 升级1介绍
		 */
		public var up1Info:String = "空中普攻和升龙踢可以在本次跳跃中再次使用";
		
		/**
		 * 升级1需要灵力
		 */
		public var up1Gold:int = 100;
		
		/**
		 * 升级1需要天数
		 */
		public var up1Day:int = 3;
		
		/**
		 * 升级2名称
		 */
		public var up2Name:String = "巨力";
		/**
		 * 升级1介绍
		 */
		public var up2Info:String = "空中普攻和升龙踢可以在本次跳跃中再次使用";
		
		/**
		 * 升级1需要灵力
		 */
		public var up2Gold:int = 100;
		
		/**
		 * 升级1需要天数
		 */
		public var up2Day:int = 3;
		/**
		 * 可以打断的后摇
		 */
		public var canCancelAfter:Array = ["剑系空中普攻", "升龙斩", "升龙踢"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public var skillComboTime:int = 0;
		
		public function SkillTableVo()
		{
		}
	}
}