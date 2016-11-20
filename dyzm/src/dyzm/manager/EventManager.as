package dyzm.manager
{
	public class EventManager
	{
		public static var eventList:Object = {};
		
		// 添加事件
		public static function addEvent(type:String, fun:Function):Boolean{
			var eventType:EventType = eventList[type];
			var eventChild:EventChild = null;
			if (eventType == null){
				eventChild = new EventChild(fun);
				eventType = new EventType();
				eventType.addStart = eventChild;
				eventType.addEnd = eventChild;
				eventList[type] = eventType;
				return true;
			}
			eventChild = getEventChild(eventType, fun);
			if (eventChild == null){
				eventChild = new EventChild(fun);
				if (eventType.addEnd == null){
					eventType.addStart = eventChild;
					eventType.addEnd = eventChild;
				}else{
					eventChild.prev = eventType.addEnd;
					eventChild.prev.next = eventChild;
					eventType.addEnd = eventChild;
				}
				return true;
			}
			return false;
		}
		
		//删除事件
		public static function removeEvent(type:String, fun:Function):Boolean
		{
			var eventType:EventType = eventList[type];
			
			if (eventType == null){
				//cc.log("删除事件错误没有事件类型", type);
				return false;
			}
			var eventChild:EventChild = getEventChild(eventType, fun);
			if (eventChild == null){
				//cc.log("删除事件错误没有事件", type, fun);
				return false;
			}
			
			if (eventChild.prev != null){
				eventChild.prev.next = eventChild.next;
			}else{
				if (eventType.addStart == eventChild){
					eventType.addStart = eventChild.next;
				}else{
					eventType.start = eventChild.next;
				}
			}
			if (eventChild.next != null){
				eventChild.next.prev = eventChild.prev;
			}else{
				if (eventType.addEnd == eventChild){
					eventType.addEnd = eventChild.prev;
				}else{
					eventType.end = eventChild.prev
				}
			}
			
			return true;
		}
		
		//派发事件
		public static function dispatchEvent(type:String, data1:Object=null, data2:Object=null, data3:Object=null, data4:Object=null):void
		{
			if (eventList[type] == null){
				return;
			}
			var eventType:EventType = eventList[type];
			
			if (eventType.start == null){
				eventType.start = eventType.addStart;
				eventType.end = eventType.addEnd;
				eventType.addStart = null;
				eventType.addEnd = null;
			}else if (eventType.addStart != null){
				eventType.end.next = eventType.addStart;
				eventType.addStart.prev = eventType.end;
				eventType.end = eventType.addEnd;
				eventType.addStart = null;
				eventType.addEnd = null;
			}
			
			var start:EventChild = eventType.start;
			while(start != null){
				switch(start.self.length)
				{
					case 0:
					{
						start.self();
						break;
					}
					case 1:
					{
						start.self(data1);
						break;
					}
					case 2:
					{
						start.self(data1, data2);
						break;
					}
					case 3:
					{
						start.self(data1, data2, data3);
						break;
					}
					case 4:
					{
						start.self(data1, data2, data3, data4);
						break;
					}
					default:
					{
						break;
					}
				}
				start = start.next;
			}
		}
		
		//删除无用事件类型
		public static function gc():void{
			var arr:Array = [];
			var i:int = 0;
			for (var type:String in eventList)
			{
				var eventType:EventType = eventList[type];
				if (eventType.addStart == null && eventType.start == null){
					arr[i ++] = type;
				}
			}
			for (var j:int = 0; j < i; j++)
			{
				delete eventList[arr[j]];
			}
		}
		
		public static function getEventChild(eventType:EventType, fun:Function):EventChild
		{
			var start:EventChild = eventType.start;
			while(start != null){
				if (start.self == fun){
					return start;
				}
				start = start.next;
			}
			
			start = eventType.addStart;
			while(start != null){
				if (start.self == fun){
					return start;
				}
				start = start.next;
			}
			return null;
		}
	};
}

class EventChild
{
	public var prev:EventChild = null;
	public var next:EventChild = null;
	public var self:Function = null;
	public function EventChild(fun:Function){
		self = fun;
	}
}

class EventType
{
	public var start:EventChild = null;
	public var end:EventChild = null;
	public var addStart:EventChild = null;
	public var addEnd:EventChild = null;
}
