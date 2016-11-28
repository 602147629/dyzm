package dyzm.data.level
{
	import dyzm.data.role.RoleVo;
	import dyzm.data.role.foe.BaseAiControl;

	public class BaseLevel
	{
		
		/**
		 * 怪物列表
		 */
		public var foeList:Vector.<BaseAiControl>;
		
		public var boss:BaseAiControl;
		
		/**
		 * 最大刷怪数
		 */
		public var maxFoe:int;
		
		/**
		 * 最小刷怪数, 当前怪数量低于这个值时会刷到最大值
		 */
		public var minFoe:int;
		
		/**
		 * 背景
		 */
		public var bg:BaseBg;
		
		/**
		 * 时间限制,单位帧
		 */
		public var time:int;
		
		/**
		 * 通关奖励
		 */
		public var drop:Array;
		
		/**
		 * 首次通关奖励
		 */
		public var firstDrop:Array;
		
		/**
		 * 最低进入等级
		 */
		public var lvMin:int;
		
		/**
		 * 主角
		 */
		public var mainRole:RoleVo;
		
		/**
		 * 上边
		 */
		public var topY:int;
		
		/**
		 * 下边
		 */
		public var bottomY:int;
		
		public function BaseLevel()
		{
		}
		
		/**
		 * 关卡特殊效果,在进入关卡后执行
		 * @param mainRole 主角
		 */
		public function special(mainRole:RoleVo):void
		{
			this.mainRole = mainRole;
		}
	}
}