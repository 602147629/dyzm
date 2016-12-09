package dyzm.data.buff
{
	/**
	 * BUFF对象池
	 * @author dj
	 */
	public class BuffPool
	{
		public static var pool:Object;
		public static var typeObj:Object;
		
		public static function init():void
		{
			pool = {};
			typeObj = {};
			typeObj[BrokenBuff.TYPE] = BrokenBuff;
			typeObj[ExplodeBuff.TYPE] = ExplodeBuff;
		}
		
		public static function getBuff(type:String):BaseBuff
		{
			if (pool[type] && pool[type].length > 0){
				return pool[type].shift();
			}
			
			return new typeObj[type];
		}
		
		public static function inPool(buff:BaseBuff):void
		{
			if (pool[buff.type] == null){
				pool[buff.type] = [buff];
			}else{
				pool[buff.type].push(buff);
			}
		}
	}
}