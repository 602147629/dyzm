package dyzm.data
{
	import dyzm.Res;
	import dyzm.data.role.PlayerControl;
	import dyzm.data.role.RoleSkinVo;

	/**
	 * 玩家数据汇总
	 * @author dj
	 * 
	 */
	public class PlayerRoleData
	{
		public static var roleVo:PlayerControl;
		
		public static function init():void
		{
			roleVo = new PlayerControl();
		}
		
		public static function newGame():void
		{
			roleVo.style = Res.role1;
			roleVo.skin = new RoleSkinVo();
			roleVo.attr = PlayerAttrData.attr;
			roleVo.attr.equip = PlayerEquipData.equip;
			roleVo.keyToSkill = PlayerSkillData.keyToSkill;
			roleVo.genius = PlayerGeniusData.genius;
		}
		
		/**
		 * 进入战斗前,数据处理
		 */
		public static function startFight():void
		{
			roleVo.attr.handle();
			roleVo.attr.minAtt = 123;
			roleVo.attr.maxAtt = 123;
			
			roleVo.attr.maxHp = 10;
			roleVo.attr.hp = 10;
//			roleVo.attr.maxHp = int.MAX_VALUE;
//			roleVo.attr.hp = int.MAX_VALUE;
			roleVo.attr.armor = 0;
			roleVo.attr.maxArmor = 0;
			
			roleVo.initAttr(roleVo.attr);
			if (PlayerSkillData.isChange){
				PlayerSkillData.isChange = false;
				roleVo.keyToSkill.init(roleVo, PlayerSkillData.floorBind, PlayerSkillData.runBind, PlayerSkillData.skyBind);
			}
		}
		
		/**
		 * 存档时调用,获取存档数据
		 * @return 
		 */
		public static function getSave():Object
		{
			return {};
		}
		
		/**
		 * 载入存档
		 * @param obj
		 */
		public static function setSave(obj:Object):void
		{
			roleVo.style = Res.role1;
			roleVo.skin = new RoleSkinVo();
			roleVo.attr = PlayerAttrData.attr;
			roleVo.attr.equip = PlayerEquipData.equip;
			roleVo.keyToSkill = PlayerSkillData.keyToSkill;
			roleVo.genius = PlayerGeniusData.genius;
		}
	}
}