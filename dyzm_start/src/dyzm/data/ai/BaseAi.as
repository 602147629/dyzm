package dyzm.data.ai
{
	import dyzm.data.vo.RoleVo;

	public class BaseAi
	{
		/**
		 * 停顿状态
		 */
		public static const STATE_STOP:int = 0;
		/**
		 * 移动状态
		 */
		public static const STATE_MOVING:int = 1;
		
		/**
		 * 当前状态
		 */
		public var state:int = 0;
		
		/**
		 * 当前时间
		 */
		public var curTime:int = 0;
		
		/**
		 * 寻路停顿时间, 单位帧
		 */
		public var findMoveStopTime:int = 60;
		
		/**
		 * 攻击开始前停顿时间, 单位帧
		 */
		public var attStartStopTime:int = 60;
		
		/**
		 * 寻路X轴最大偏差,单位像素
		 */
		public var findMoveMaxX:int = 60;
		/**
		 * 寻路X轴最小偏差,单位像素
		 */
		public var findMoveMinX:int = 60;
		
		
		/**
		 * 寻路Y轴最大偏差,单位像素
		 */
		public var findMoveMaxY:int = 60;
		/**
		 * 寻路Y轴最小偏差,单位像素
		 */
		public var findMoveMinY:int = 60;
		
		/**
		 * 自己的数据
		 */
		public var me:RoleVo;
		
		/**
		 * 敌方数组
		 */
		public var foeList:Array;
		
		public function BaseAi()
		{
		}
		
		public function start(roleVo:RoleVo, foeList:Array):void
		{
			me = roleVo;
			this.foeList = foeList;
		}
		
		public function frameUpdate():void
		{
			curTime ++;
			switch(state)
			{
				case STATE_STOP:
				{
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
	}
}