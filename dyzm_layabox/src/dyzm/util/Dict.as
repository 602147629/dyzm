package dyzm.util
{
	public class Dict
	{
		public var idToObj:Object;
		public var datas:Object;
		public function Dict()
		{
			idToObj = {};
			datas = {};
		}
		
		public function setData(t:IDict, data:*):void
		{
			idToObj[t.keyId] = t;
			datas[t.keyId] = data;
		}
		
		public function delData(t:IDict):void
		{
			delete idToObj[t.keyId];
			delete datas[t.keyId];
		}
		
		public function getData(t:IDict):*
		{
			return datas[t.keyId];
		}
		
		public function getT(keyId:int):*
		{
		
			return idToObj[keyId];
		}
		
		public function has(t:IDict):Boolean
		{
			return idToObj[t.keyId] != null;
		}
		
		public function toEmpty():void
		{
			idToObj = {};
			datas = {};
		}
	}
}