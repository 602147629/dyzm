package dyzm.data.skill
{
	public class ByAttInfo
	{
		/**
		 * 打退距离
		 */
		public var x:Number = 0;
		/**
		 * 击飞高度
		 */
		public var z:Number = 0;
		
		/**
		 * 最小反弹高度
		 */
		public var minBounceZ:Number = 0;
		
		/**
		 * 硬直帧数
		 */
		public var stiffFrame:int = 0;
		
		/**
		 * 硬直帧数
		 */
		public var curStiffFrame:int = 0;
		
		/**
		 * 被攻击记录
		 */
		public var hitDict:Object;
		
		public function ByAttInfo()
		{
			
		}
	}
}