package dyzm.data.attr
{
	public class GeniusVo
	{
		
		/**
		 * 连击到4,必定暴击
		 */
		public var blast4:Boolean = false;
		public var blast7:Boolean = false;
		public var blast10:Boolean = false;
		public var blast15:Boolean = false;
		public var blast20:Boolean = false;
		/**
		 * 生命吸收
		 */
		public var hpAbsorb:Boolean = false;
		/**
		 * 护甲吸收
		 */
		public var armorAbsorb:Boolean = false;
		/**
		 * 破坏
		 */
		public var destroy:Boolean = false;
		/**
		 * 屹立
		 */
		public var erect:Boolean = false;
		
		public var info:Object = {};
		public function GeniusVo()
		{
		}
	}
}