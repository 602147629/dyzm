package dyzm.data.equip
{
	import dyzm.data.PlayerEquipData;
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
		 * 装备图标所属图集
		 */
		public var iconAtlas:String;
		
		/**
		 * 装备图片
		 */
		public var img:String;
		/**
		 * 装备图片所属图集
		 */
		public var imgAtlas:String;
		
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
		
		/**
		 * 已经开启的插槽位
		 */
		public var openGem:Array;
		
		/**
		 * 可以开启的插槽位
		 */
		public var canOpenGem:Array;
		
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
			toZero();
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
		
		/**
		 * 装备从低级升到高级时
		 * 由高级装备调用,继承装备属性
		 */
		public function up(equip:BaseEquip):void
		{
			gem1 = equip.gem1;
			gem2 = equip.gem2;
			gem3 = equip.gem3;
			
			openGem = equip.openGem;
			canOpenGem = equip.canOpenGem;
		}
		
		override public function toObj():Object
		{
			var obj:Object = {
				type:type,
				lv:lv,
				openGem:openGem
			};
			if (gem1){
				obj.gem1Lv = gem1.lv;
				obj.gem1Type = gem1.type;
				obj.gem1Name = gem1.name;
				obj.gem1Icon = gem1.icon;
				obj.gem1Img = gem1.img;
				obj.gem1Attr = gem1.toObj();
			}
			if (gem2){
				obj.gem2Lv = gem2.lv;
				obj.gem2Type = gem2.type;
				obj.gem2Name = gem2.name;
				obj.gem2Icon = gem2.icon;
				obj.gem2Img = gem2.img;
				obj.gem2Attr = gem2.toObj();
			}
			if (gem3){
				obj.gem3Lv = gem3.lv;
				obj.gem3Type = gem3.type;
				obj.gem3Name = gem3.name;
				obj.gem3Icon = gem3.icon;
				obj.gem3Img = gem3.img;
				obj.gem3Attr = gem3.toObj();
			}
			return obj;
		}
		
		public static function getEquipFromObj(obj:Object):BaseEquip
		{
			var equ:BaseEquip = new (PlayerEquipData.typeLvToClass[obj.type][obj.lv]);
			if (obj.gem1Lv){
				equ.gem1 = new BaseGem();
				equ.gem1.lv = obj.gem1Lv;
				equ.gem1.type = obj.gem1Type;
				equ.gem1.name = obj.gem1Name;
				equ.gem1.icon = obj.gem1Icon;
				equ.gem1.img = obj.gem1Img;
				equ.gem1.formObj(obj.gem1Attr);
			}
			if (obj.gem2Lv){
				equ.gem2 = new BaseGem();
				equ.gem2.lv = obj.gem2Lv;
				equ.gem2.type = obj.gem2Type;
				equ.gem2.name = obj.gem2Name;
				equ.gem2.icon = obj.gem2Icon;
				equ.gem2.img = obj.gem2Img;
				equ.gem2.formObj(obj.gem2Attr);
			}
			if (obj.gem3Lv){
				equ.gem3 = new BaseGem();
				equ.gem3.lv = obj.gem3Lv;
				equ.gem3.type = obj.gem3Type;
				equ.gem3.name = obj.gem3Name;
				equ.gem3.icon = obj.gem3Icon;
				equ.gem3.img = obj.gem3Img;
				equ.gem3.formObj(obj.gem3Attr);
			}
			return equ;
		}
	}
}