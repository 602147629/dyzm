package dyzm.data.attr
{
	import dyzm.data.equip.BaseEquip;

	/**
	 * 装备属性
	 * @author dj
	 */
	public class AttrEquipVo extends BaseAttrVo
	{
		/**
		 * 武器
		 */
		public var weapon:BaseEquip;
		
		/**
		 * 帽子
		 */
		public var hat:BaseEquip;
		
		/**
		 * 眼镜
		 */
		public var glasses:BaseEquip;
		
		/**
		 * 腰带
		 */
		public var belt:BaseEquip;
		
		/**
		 * 项链
		 */
		public var neck:BaseEquip;
		
		/**
		 * 戒指
		 */
		public var ring:BaseEquip;
		
		public function AttrEquipVo()
		{
		}
	}
}