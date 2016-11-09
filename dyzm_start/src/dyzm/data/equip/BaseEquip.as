package dyzm.data.equip
{
	import dyzm.data.attr.BaseAttrVo;
	import dyzm.data.vo.RoleVo;

	public class BaseEquip
	{
		public static const TYPE_WEAPON:String = "weapon";
		
		/**
		 * 装备类型
		 */
		public var type:String;
		
		/**
		 * 装备名称
		 */
		public var name:String;
		
		/**
		 * 基础属性
		 */
		public var baseAttr:BaseAttrVo;
		
		public function BaseEquip()
		{
			baseAttr = new BaseAttrVo();
		}
		
		/**
		 * 装备特殊效果
		 * @param attRole
		 * @param foeRole
		 */
		public function special(attRole:RoleVo, foeRole:RoleVo):void
		{
			
		}
	}
}