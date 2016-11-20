package dyzm.data.equip
{
	import flash.display.Sprite;
	
	import dyzm.data.attr.BaseAttrVo;
	import dyzm.data.role.RoleVo;

	public class BaseEquip extends BaseAttrVo
	{
		/**
		 * 武器
		 */
		public static const TYPE_WEAPON:String = "weapon";
		/**
		 * 帽子
		 */
		public static const TYPE_HAT:String = "hat";
		/**
		 * 眼镜
		 */
		public static const TYPE_GLASSES:String = "glasses";
		/**
		 * 腰带
		 */
		public static const TYPE_BELT:String = "belt";
		/**
		 * 项链
		 */
		public static const TYPE_NECK:String = "neck";
		/**
		 * 戒指
		 */
		public static const TYPE_RING:String = "ring";
		
		
		/**
		 * 等级
		 */
		public var lv:int = 1;
		/**
		 * 装备类型
		 */
		public var type:String;
		
		/**
		 * 装备名称
		 */
		public var name:String;
		
		/**
		 * 装备图标
		 */
		public var icon:String;
		
		/**
		 * 装备图片
		 */
		public var img:Sprite;
		/**
		 * 基础属性
		 */
		public var baseAttr:BaseAttrVo;
		
		/**
		 * 宝石1
		 */
		public var gem1:BaseGem;
		/**
		 * 宝石2
		 */
		public var gem2:BaseGem;
		/**
		 * 宝石3
		 */
		public var gem3:BaseGem;
		
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
		
		/**
		 * 装备属性计算
		 */
		public function handle():void
		{
			add(baseAttr);
			if (gem1){
				add(gem1);
			}
			if (gem2){
				add(gem2);
			}
			if (gem3){
				add(gem3);
			}
		}
	}
}