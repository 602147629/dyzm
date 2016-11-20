package dyzm.data.equip
{
	import flash.display.Sprite;
	
	import dyzm.data.attr.BaseAttrVo;

	public class BaseGem extends BaseAttrVo
	{
		/**
		 * 红宝石
		 */
		public static const TYPE_RED:String = "red";
		/**
		 * 钻石
		 */
		public static const TYPE_DIAMOND:String = "diamond";
		/**
		 * 黄宝石
		 */
		public static const TYPE_YELLOW:String = "yellow";
		
		public var lv:int;
		public var type:String;
		public var name:String;
		public var icon:String;
		public var img:Sprite;
		public function BaseGem()
		{
		}
	}
}