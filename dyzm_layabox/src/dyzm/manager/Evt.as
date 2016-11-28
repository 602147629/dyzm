package dyzm.manager
{
	import laya.events.EventDispatcher;

	public class Evt
	{
		public static const ENTER_FRAME:String = "ENTER_FRAME";
		public static const EXIT_FRAME:String = "EXIT_FRAME";
		
		public static var _event:EventDispatcher = new EventDispatcher;
		
		public function Evt():void
		{
		}
		
		/**
		 * 使用 EventDispatcher 对象注册指定类型的事件侦听器对象，以使侦听器能够接收事件通知。
		 * @param	type 事件的类型。
		 * @param	caller 事件侦听函数的执行域。
		 * @param	listener 事件侦听函数。
		 * @param	args 事件侦听函数的回调参数。
		 * @return 此 EventDispatcher 对象。
		 */
		public static function on(type:String, caller:*, listener:Function, args:Array = null):EventDispatcher{
			return _event.on(type, caller, listener, args);
		}
		
		/**
		 * 从 EventDispatcher 对象中删除侦听器。
		 * @param	type 事件的类型。
		 * @param	caller 事件侦听函数的执行域。
		 * @param	listener 事件侦听函数。
		 * @param	onceOnly 如果值为 true ,则只移除通过 once 方法添加的侦听器。
		 * @return 此 EventDispatcher 对象。
		 */
		public static function off(type:String, caller:*, listener:Function, onceOnly:Boolean = false):EventDispatcher
		{
			return _event.off(type, caller, listener, onceOnly);
		}
		
		/**
		 * 使用 EventDispatcher 对象注册指定类型的事件侦听器对象，以使侦听器能够接收事件通知，此侦听事件响应一次后自动移除。
		 * @param	type 事件的类型。
		 * @param	caller 事件侦听函数的执行域。
		 * @param	listener 事件侦听函数。
		 * @param	args 事件侦听函数的回调参数。
		 * @return 此 EventDispatcher 对象。
		 */
		public static function once(type:String, caller:*, listener:Function, args:Array = null):EventDispatcher {
			return _event.once(type, caller, listener, args);
		}
		
		/**
		 * 派发事件。
		 * @param	type 事件类型。
		 * @param	data 回调数据。
		 * 				<b>注意：</b>如果是需要传递多个参数 p1,p2,p3,...可以使用数组结构如：[p1,p2,p3,...] ；如果需要回调单个参数 p 是一个数组，则需要使用结构如：[p]，其他的单个参数 p ，可以直接传入参数 p。
		 * @return 此事件类型是否有侦听者，如果有侦听者则值为 true，否则值为 false。
		 */
		public static function event(type:String, data:* = null):Boolean
		{
			return _event.event(type, data);
		}
	};
}