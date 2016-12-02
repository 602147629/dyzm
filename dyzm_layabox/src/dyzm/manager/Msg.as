package dyzm.manager
{
	import dyzm.manager.messge.Message;

	public class Msg
	{
		public static var pool:Array = [];
		public static var runing:Array = [];
		public static var TIME:int = 300;
		public static function init():void
		{
			
		}
		
		public static function show(string:String):void
		{
			var text:Message;
			if (pool.length > 0){
				text = pool.shift();
			}else{
				text = new Message();
			}
			text.show(string, runing);
			runing.push(text);
		}
		
		public static function inPool(message:Message):void
		{
			runing.removeAt(runing.indexOf(message));
			pool.push(message);
		}
	}
}
