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
		 * 每过一天,发送一次该事件
		 */
		public static const DAY_EVENT:String = "DAY_EVENT";
		
		/**
		 * 时间开始流逝
		 * @param lv 1 = 每5秒一天, 2=每3秒一天, 1=每秒1天
		 */
		public static function startTimeMove(lv:int):void
		{
			var frame:int;
			if (lv == 1){
				frame = 5 * 60;
			}else if (lv == 2){
				frame = 3 * 60;
			}else if (lv == 3){
				frame = 60;
			}
			Laya.timer.frameLoop(frame, null, nextDay);
		}
		
		/**
		 * 时间进行到下一天
		 */
		public static function nextDay():void
		{
			Evt.event(DAY_EVENT);
		}
		
		/**
		 * 停止时间流逝
		 */
		public static function stopTimeMove():void
		{
			Laya.timer.clear(null, nextDay);
		}
	}
}