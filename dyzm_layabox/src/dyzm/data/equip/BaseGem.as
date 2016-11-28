package dyzm.data.equip
{
	import dyzm.data.attr.BaseAttrVo;

	public class BaseGem extends BaseAttrVo
	{
		/**
		 * 红宝石
		 */
		public static const TYPE_RED:int = 1;
		/**
		 * 黄宝石
		 */
		public static const TYPE_YELLOW:int = 2;
		/**
		 * 钻石
		 */
		public static const TYPE_DIAMOND:int = 3;
		
		
		public var lv:int;
		public var type:int;
		public var name:String;
		public var icon:String;
		public var img:String;
		public function BaseGem()
		{
		}
	}
}