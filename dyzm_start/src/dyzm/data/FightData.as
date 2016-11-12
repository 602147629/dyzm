package dyzm.data
{
	import dyzm.data.level.BaseLevel;
	import dyzm.data.level.Level1;
	import dyzm.data.role.PlayerControl;
	import dyzm.data.role.RoleVo;
	import dyzm.data.role.foe.BaseAiControl;
	import dyzm.util.Maths;

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
		 * 已经刷新怪物数组
		 */
		public static var foeList:Vector.<BaseAiControl>;
		
		
		/**
		 * 队伍分组
		 */
		public static var team:Object;
		
		/**
		 * 敌对关系
		 */
		public static var teamToFoe:Object;
		
		/**
		 * 当前怪物数量
		 */
		public static var foeNum:int;
		
		/**
		 * 当前出怪顺序
		 */
		public static var curFoeIndex:int;
		
		/**
		 * 是否还需要刷怪
		 */
		public static var needAddFoe:Boolean;
		
		/**
		 * 开始战斗
		 * @param level 关卡
		 */
		public static function start(levelId:int):void
		{
			// 初始化关卡
			level = new levelObj[levelId]();
			
			// 初始化主角
			mainRole = new PlayerControl();
			mainRole.x = Maths.random(-1000, 1000);
			mainRole.y = Maths.random(level.topY, level.bottomY);
			mainRole.team = 0;
			
			team = {};
			team[0] = [mainRole];
			team[1] = [];
			
			// 刷怪
			foeList = new Vector.<BaseAiControl>;
			foeList.length = level.maxFoe;
			foeNum = 0;
			curFoeIndex = 0;
			needAddFoe = true;
			
			addFoe();
			
			teamToFoe = {};
			teamToFoe[0] = [1];
			teamToFoe[1] = [0];
		}
		
		/**
		 * 数据刷新
		 */
		public static function frameUpdate():void
		{
			mainRole.frameUpdate();
			
			var b:Boolean = false;
			for (var i:int = 0; i < foeList.length; i++) 
			{
				foeList[i].frameUpdate();
				
				if (foeList[i].needDel){
					foeList[i] = null;
					foeNum --;
					if (needAddFoe){
						b = true;
					}
				}
			}
			
			if (b){
				addFoe();
			}
		}
		
		private static function addFoe():void
		{
			var needNum:int;
			if (foeNum < level.minFoe){
				needNum = level.maxFoe - foeNum;
			}
			var needBoss:Boolean = false;
			if (needNum + curFoeIndex > level.foeList.length){
				needNum = level.foeList.length - curFoeIndex;
				needBoss = true;
				needAddFoe = false;
			}
			
			for (var i:int = 0; i < needNum; i++) 
			{
				for (var j:int = 0; j < foeList.length; j++) 
				{
					if (foeList[j] == null){
						foeList[j] = initFoe();
					}
				}
			}
			if (needBoss){
				for (j = 0; j < foeList.length; j++) 
				{
					if (foeList[j] == null){
						foeList[j] = level.boss;
						foeList[j].x = Maths.random(-500, 500);
						foeList[j].y = Maths.random(level.topY, level.bottomY);
						foeList[j].team = 1;
					}
				}
			}
		}
		
		private static function initFoe():RoleVo
		{
			var role:BaseAiControl = level.foeList[curFoeIndex];
			curFoeIndex ++;
			role.x = Maths.random(-500, 500);
			role.y = Maths.random(level.topY, level.bottomY);
			role.team = 1;
			team[1].push(role);
			role.start(team[0]);
			return role;
		}
	}
}