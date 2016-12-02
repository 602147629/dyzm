package dyzm.data
{
	import dyzm.manager.Evt;
	
	public class WorldData
	{
		/**
		 * 世界重力
		 */
		public static const G:Number = -1.6;
		
		/**
		 * 开始过时间
		 */
		public static const START_MOVING_DAY:String = "START_MOVING_DAY";
		/**
		 * 停止过时间
		 */
		public static const STOP_MOVING_DAY:String = "STOP_MOVING_DAY";
		/**
		 * 每过一天,发送一次该事件
		 */
		public static const DAY_EVENT:String = "DAY_EVENT";
		
		/**
		 * 一天过完,发送一次该事件
		 */
		public static const DAY_OVER_EVENT:String = "DAY_OVER_EVENT";
		
		/**
		 * 时间是否处于运行状态
		 */
		public static var moving:Boolean = false;
		
		/**
		 * 过一天需要的总帧数
		 */
		public static var allFrame:int;
		
		/**
		 * 过一天需要的总帧数
		 */
		public static var curFrame:int;
		
		/**
		 * 时间开始流逝
		 * @param lv 1 = 每5秒一天, 2=每3秒一天, 3=每秒1天
		 */
		public static function startTimeMove(lv:int):void
		{
			if (lv == 1){
				allFrame = 5 * 60;
			}else if (lv == 2){
				allFrame = 3 * 60;
			}else if (lv == 3){
				allFrame = 60;
			}
			
			if (!moving){
				moving = true;
				Evt.event(START_MOVING_DAY);
				curFrame = 0;
				Laya.timer.frameLoop(1, null, nextFrame);
			}
		}
		
		private static function nextFrame():void
		{
			if (curFrame >= allFrame){
				nextDay();
			}else{
				curFrame ++;
			}
		}
		
		/**
		 * 时间进行到下一天
		 */
		public static function nextDay():void
		{
			Evt.event(DAY_EVENT);
			
			Evt.event(DAY_OVER_EVENT);
			
			curFrame = 0;
		}
		
		/**
		 * 停止时间流逝
		 */
		public static function stopTimeMove():void
		{
			if (moving){
				moving = false;
				Laya.timer.clear(null, nextFrame);
				Evt.event(STOP_MOVING_DAY);
			}
		}
	}
}