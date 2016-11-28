package dyzm.data
{
	import dyzm.data.attr.AttrEquipVo;
	import dyzm.data.equip.BaseEquip;
	import dyzm.data.equip.BaseGem;
	import dyzm.data.equip.t1.Belt1;
	import dyzm.data.equip.t1.Glasses1;
	import dyzm.data.equip.t1.Hat1;
	import dyzm.data.equip.t1.Neck1;
	import dyzm.data.equip.t1.Ring1;
	import dyzm.data.equip.t1.Weapon1;
	import dyzm.data.equip.t2.Belt2;
	import dyzm.data.equip.t2.Glasses2;
	import dyzm.data.equip.t2.Hat2;
	import dyzm.data.equip.t2.Neck2;
	import dyzm.data.equip.t2.Ring2;
	import dyzm.data.equip.t2.Weapon2;
	import dyzm.data.equip.t3.Belt3;
	import dyzm.data.equip.t3.Glasses3;
	import dyzm.data.equip.t3.Hat3;
	import dyzm.data.equip.t3.Neck3;
	import dyzm.data.equip.t3.Ring3;
	import dyzm.data.equip.t3.Weapon3;
	
	/**
	 * 玩家装备数据
	 * @author dj
	 */
	public class PlayerEquipData
	{
		public static var equip:AttrEquipVo;
		public static var typeLvToClass:Object;
		
		public static function init():void
		{
			typeLvToClass = {
				weapon:[Weapon1, Weapon2, Weapon3],
				hat:[Hat1, Hat2, Hat3],
				glasses:[Glasses1, Glasses2, Glasses3],
				belt:[Belt1, Belt2, Belt3],
				neck:[Neck1, Neck2, Neck3],
				ring:[Ring1, Ring2, Ring3]
			};
			equip = new AttrEquipVo();
		}
		
		public static function newGame():void
		{
			equip.weapon = new Weapon1();
			equip.hat = new Hat1();
			equip.glasses = new Glasses1();
			equip.belt = new Belt1();
			equip.neck = new Neck1();
			equip.ring = new Ring1();
		}
		
		/**
		 * 存档时调用,获取存档数据
		 * @return 
		 */
		public static function getSave():Object
		{
			return {
				weapon:equip.weapon.toObj(),
					hat:equip.hat.toObj(),
					glasses:equip.glasses.toObj(),
					belt:equip.belt.toObj(),
					neck:equip.neck.toObj(),
					ring:equip.ring.toObj()
			};
		}
		
		/**
		 * 载入存档
		 * @param obj
		 */
		public static function setSave(obj:Object):void
		{
			var equip:AttrEquipVo = PlayerEquipData.equip;
			for (var i:String in obj) 
			{
				equip[i] = BaseEquip.getEquipFromObj(obj[i]);
			}
		}
		
		/**
		 * 装备镶嵌宝石测试,可以镶嵌返回null,不可以返回错误内容
		 * @param equip
		 * @param gem
		 */
		public static function addGemTest(equip:BaseEquip, gem:BaseGem):String
		{
			if (equip.openGem.indexOf(gem.type) == -1){
				return "没有该类型插槽";
			}
			return null;
		}
		
		/**
		 * 装备镶嵌宝石
		 * @param equip
		 * @param gem
		 */
		public static function addGem(equip:BaseEquip, gem:BaseGem):void
		{
			if (addGemTest(equip, gem) == null){
				switch(gem.type)
				{
					case 1:
					{
						equip.gem1 = gem;
						break;
					}
					case 2:
					{
						equip.gem2 = gem;
						break;
					}
					case 3:
					{
						equip.gem3 = gem;
						break;
					}
					default:
					{
						break;
					}
				}
				
			}
		}
	}
}