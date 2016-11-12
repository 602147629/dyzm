package dyzm.data
{
	import dyzm.data.level.BaseLevel;
	import dyzm.data.level.Level1;
	import dyzm.data.role.BaseAiControl;
	import dyzm.data.role.PlayerControl;
	import dyzm.data.role.RoleVo;

	/**
	 * 当前战斗数据
	 * @author dj
	 * 
	 */
	public class FightData
	{
		/**
		 * 总关卡数据
		 */
		public static const levelObj:Object = {
			1:Level1
		}
			
		/**
		 * 当前关卡
		 */
		public static var level:BaseLevel;
			
		/**
		 * 主角数据
		 */
		public static var mainRole:PlayerControl;
		
		
		/**
		 * 怪数组
		 */
		public static var foeList:Array;
		
		
		public static var team:Object;
		
		
			
		public static var teamToFoe:Object = {
			0:[1],
			1:[0]
		}
		/**
		 * 开始战斗
		 * @param level 关卡
		 */
		public static function start(levelId:int):void
		{
			level = new levelObj[levelId]();
			
			mainRole = new PlayerControl();
			mainRole.x = 0;
			mainRole.y = 800;
			mainRole.team = 0;
			foeList = [initFoe()];
			
			team = {};
			team[0] = [mainRole];
			team[1] = foeList.concat();
			
			for (var i:int = 0; i < foeList.length; i++) 
			{
				foeList[i].start(team[0]);
			}
			
		}
		
		/**
		 * 数据刷新
		 */
		public static function frameUpdate():void
		{
			mainRole.frameUpdate();
			
			for (var i:int = 0; i < foeList.length; i++) 
			{
				foeList[i].frameUpdate();
			}
		}
		
		public static function initFoe():RoleVo
		{
			var role:BaseAiControl = new BaseAiControl();
			role.x = 800;
			role.y = 500;
			role.team = 1;
			return role;
		}
		
	}
}