package dyzm.data
{
	import flash.net.SharedObject;
	
	import laya.utils.Browser;

	public class DataManager
	{
		
		public static function init():void
		{
			SkillData.init();
			
			PlayerKeyData.init();
			PlayerAttrData.init();
			PlayerGeniusData.init();
			PlayerSkillData.init();
			PlayerItemData.init();
			PlayerEquipData.init();
			PlayerRoleData.init();
		}
		
		/**
		 * 开始新游戏
		 */
		public static function newGame():void
		{
			PlayerKeyData.newGame();
			PlayerAttrData.newGame();
			PlayerGeniusData.newGame();
			PlayerSkillData.newGame();
			PlayerItemData.newGame();
			PlayerEquipData.newGame();
			PlayerRoleData.newGame();
		}
		
		/**
		 * 存档
		 * @param name 存档名
		 */
		public static function seveData(name:String):void
		{
			var sharedObject:SharedObject = SharedObject.getLocal(name);
			sharedObject.data.key = PlayerKeyData.getSave();
			sharedObject.data.attr = PlayerAttrData.getSave();
			sharedObject.data.genius = PlayerGeniusData.getSave();
			sharedObject.data.skill = PlayerSkillData.getSave();
			sharedObject.data.item = PlayerItemData.getSave();
			sharedObject.data.equip = PlayerEquipData.getSave();
			sharedObject.data.role = PlayerRoleData.getSave();
			sharedObject.data.time = Browser.now(); //存档时间
			sharedObject.data.day = PlayerAttrData.day; // 游戏天数
			sharedObject.data.lv = PlayerAttrData.lv; //玩家等级
			sharedObject.flush();
		}
		
		/**
		 * 读档
		 * @param name 存档名
		 */
		public static function readData(name:String):void
		{
			var sharedObject:SharedObject = SharedObject.getLocal(name);
			PlayerKeyData.setSave(sharedObject.data.key);
			PlayerAttrData.setSave(sharedObject.data.attr);
			PlayerGeniusData.setSave(sharedObject.data.genius);
			PlayerSkillData.setSave(sharedObject.data.skill);
			PlayerItemData.setSave(sharedObject.data.item);
			PlayerEquipData.setSave(sharedObject.data.equip);
			PlayerRoleData.setSave(sharedObject.data.role);
			sharedObject.flush();
		}
	}
}