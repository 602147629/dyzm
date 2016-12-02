package dyzm.manager
{
	import laya.events.Event;

	public class Dbg
	{
		private static var a:int;
		public static function init():void
		{
			Laya.stage.on(Event.KEY_DOWN, null, onKeyDown);
		}
		
		private static function onKeyDown(e:Event):void
		{
			if (e.keyCode == 192){
				Msg.show("测试"+ a ++);
			}
		}
	}
}