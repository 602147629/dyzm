package dyzm.data.level
{
	import dyzm.data.attr.foe.BaseFoe;
	import dyzm.data.vo.RoleVo;

	public class BaseLevel
	{
		
		/**
		 * 怪物列表
		 */
		public var foeList:Array;
		
		public var boss:BaseFoe;
		
		/**
		 * 背景
		 */
		public var bgBg:Array;
		
		/**
		 * 前景
		 */
		public var bgFront:Array;
		
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
		
		public var topY:int;
		
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