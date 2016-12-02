package dyzm.data
{
	import dyzm.data.role.KeyToSkillVo;
	import dyzm.data.skill.SkillBlock;
	import dyzm.data.skill.SkillDFC;
	import dyzm.data.skill.SkillJian1;
	import dyzm.data.skill.SkillJian2;
	import dyzm.data.skill.SkillJian3;
	import dyzm.data.skill.SkillJianBSJ;
	import dyzm.data.skill.SkillJump;
	import dyzm.data.skill.SkillKZPG;
	import dyzm.data.skill.SkillLKZ;
	import dyzm.data.skill.SkillSLT;
	import dyzm.data.skill.SkillSLZ;
	import dyzm.data.skill.SkillST;
	import dyzm.data.skill.SkillYingTi;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	import dyzm.manager.Evt;
	

	/**
	 * 主角技能
	 * @author dj
	 */
	public class PlayerSkillData
	{
	
		/**
		 * 天赋发生变化时派发事件,参数为 [SkillTableVo, 是否升级]
		 */
		public static const SKILL_UPDATE_EVENT:String = "SKILL_UPDATE_EVENT";
		/**
		 * 名字到技能类的对应表
		 */
		public static var keyToSkill:KeyToSkillVo;
		
		/**
		 * 地面技能绑定
		 * 例:{1:技能ID}
		 */
		public static var floorBind:Object = {};
		
		/**
		 * 空中技能绑定
		 */
		public static var skyBind:Object = {};
		
		/**
		 * 跑步技能绑定
		 */
		public static var runBind:Object = {};
		
		/**
		 * 技能绑定是否改变
		 */
		public static var isChange:Boolean;
		
		/**
		 * 技能id为key,储存技能实例
		 */
		public static var skills:Object;
		
		/**
		 * 所有技能列表[id,...]
		 */
		public static var skillAllList:Array;
		
		/**
		 * 主角技能信息{id:info}
		 * info = {type:当前状态, make:正在学习某状态, day:学习的天数}
		 */
		public static var skillInfo:Object;
		
		/**
		 * 没学会的技能
		 */
		public static const NO:int = -1;
		
		/**
		 * 学会的技能
		 */
		public static const YES:int = 0;
		
		/**
		 * 开启第一进阶的技能
		 */
		public static const TYPE1:int = 1;
		/**
		 * 开启第二进阶的技能
		 */
		public static const TYPE2:int = 2;
		
		/**
		 * 正在升级的技能信息
		 */
		public static var upingInfo:Object;
		public static var upingTableVo:SkillTableVo;
		public static function init():void
		{
			keyToSkill = new KeyToSkillVo();
			skills = {};
			skills[SkillBlock.id] = new SkillBlock();
			skills[SkillDFC.id] = new SkillDFC();
			skills[SkillJian1.id] = new SkillJian1();
			skills[SkillJian2.id] = new SkillJian2();
			skills[SkillJian3.id] = new SkillJian3();
			skills[SkillJianBSJ.id] = new SkillJianBSJ();
			skills[SkillJump.id] = new SkillJump();
			skills[SkillKZPG.id] = new SkillKZPG();
			skills[SkillLKZ.id] = new SkillLKZ();
			skills[SkillSLT.id] = new SkillSLT();
			skills[SkillSLZ.id] = new SkillSLZ();
			skills[SkillST.id] = new SkillST();
			skills[SkillYingTi.id] = new SkillYingTi();
			
			skillAllList = [
				SkillJian1.id,
				SkillJian2.id,
				SkillJian3.id,
				SkillJump.id,
				SkillBlock.id,
				SkillKZPG.id,
				SkillST.id,
				SkillLKZ.id,
				SkillSLZ.id,
				SkillSLT.id,
				SkillYingTi.id,
				SkillDFC.id,
				SkillJianBSJ.id
			]
		}
		
		/**
		 * 技能升级,升级成功返回null,否则返回错误信息
		 * @param skillId
		 * @param type 技能升级方向,0表示技能本身
		 */
		public static function upSkill(skillId:String, type:int):String
		{
			var tableVo:SkillTableVo = SkillTable.table[skillId];
			var info:Object = skillInfo[skillId];
			if (info.type == -1){
				if (type != 0){
					return "需先学会该技能";
				}
				if (PlayerAttrData.gold < tableVo.needGold){
					return "灵力不足,无法升级";
				}
				PlayerAttrData.useGold(tableVo.needGold, "技能", "学习", tableVo.id);
				info.make = 0;
				info.day = 0;
				upingInfo = info;
				upingTableVo = tableVo;
				Evt.once(WorldData.STOP_MOVING_DAY, null, stopMovingDay);
				Evt.once(WorldData.DAY_EVENT, null, upSkilling);
				WorldData.startTimeMove(3);
			}else{
				var name:String = info.make == 1 ? tableVo.up1Name : tableVo.up2Name;
				if (info.make == type){ // 已经处于学习状态,继续训练
					upingInfo = info;
					Evt.once(WorldData.STOP_MOVING_DAY, null, stopMovingDay);
					Evt.once(WorldData.DAY_EVENT, null, upSkilling);
					WorldData.startTimeMove(3);
					return null;
				}
				if (info.opened.indexOf(type) != -1){ // 已经学会该技能,可以直接开启
					info.type = type;
					return null;
				}
				if (info.make != -1){ // 正在学习别的技能,无法学习新的升级
					return "请先完成" + name + "的升级";
				}
				var needGold:int = type == 1 ? tableVo.up1Gold : tableVo.up2Gold;
				if (PlayerAttrData.gold < needGold){
					return "灵力不足,无法升级";
				}
				PlayerAttrData.useGold(tableVo.needGold, "技能", "升级", tableVo.id + ":" + name);
				info.make = type;
				info.day = 0;
				upingInfo = info;
				upingTableVo = tableVo;
				Evt.once(WorldData.STOP_MOVING_DAY, null, stopMovingDay);
				Evt.once(WorldData.DAY_EVENT, null, upSkilling);
				WorldData.startTimeMove(3);
			}
			return null;
		}
		
		/**
		 * 时间停止运行
		 */
		private static function stopMovingDay():void
		{
			Evt.off(WorldData.STOP_MOVING_DAY, null, stopMovingDay);
			Evt.off(WorldData.DAY_EVENT, null, upSkilling);
		}
		
		public static function upSkilling():void
		{
			var next:Boolean = true; // 是否继续
			upingInfo.day ++;
			if (upingInfo.make == 0){
				if (upingInfo.day >= upingTableVo.needDay){
					upingInfo.type = 0;
					upingInfo.day = 0;
					upingInfo.make = -1;
					next = false;
				}
			}else if (upingInfo.make == 1){
				if (upingInfo.day >= upingTableVo.up1Day){
					upingInfo.type = 1;
					upingInfo.day = 0;
					upingInfo.make = -1;
					upingInfo.opened.push(1);
					next = false;
				}
			}else if (upingInfo.make == 2){
				if (upingInfo.day >= upingTableVo.up2Day){
					upingInfo.type = 2;
					upingInfo.day = 0;
					upingInfo.make = -1;
					upingInfo.opened.push(2);
					next = false;
				}
			}
			
			if (next){
				if (WorldData.moving){
					Evt.once(WorldData.DAY_EVENT, null, upSkilling);
				}
			}else{
				WorldData.stopTimeMove();
			}
			Evt.event(SKILL_UPDATE_EVENT, [upingTableVo, !next]);
		}
		
		public static function newGame():void
		{
			// 技能数据初始化
			skillInfo = {};
			skillInfo[SkillKZPG.id]		= {type:0, make:-1, day:0, opened:[]};
			skillInfo[SkillSLT.id]		= {type:0, make:-1, day:0, opened:[]};
			skillInfo[SkillYingTi.id]	= {type:2, make:-1, day:0, opened:[2]};
			skillInfo[SkillLKZ.id]		= {type:0, make:-1, day:0, opened:[]};
			skillInfo[SkillDFC.id]		= {type:1, make:-1, day:0, opened:[1]};
			skillInfo[SkillJian1.id]	= {type:0, make:-1, day:0, opened:[]};
			skillInfo[SkillJian2.id]	= {type:0, make:-1, day:0, opened:[]};
			skillInfo[SkillJian3.id]	= {type:0, make:-1, day:0, opened:[]};
			
			skillInfo[SkillJump.id]		= {type:0, make:-1, day:0, opened:[]};
			skillInfo[SkillBlock.id]	= {type:-1, make:-1, day:0, opened:[]};
			skillInfo[SkillSLZ.id]		= {type:0, make:-1, day:0, opened:[]};
			skillInfo[SkillST.id]		= {type:0, make:-1, day:0, opened:[]};
			skillInfo[SkillJianBSJ.id]	= {type:0, make:-1, day:0, opened:[]};
			
			// 技能按键绑定初始化
			skyBind[1] = [SkillKZPG.id];
			skyBind[2] = [SkillSLT.id];
			skyBind[3] = [SkillYingTi.id];
			skyBind[4] = [SkillLKZ.id];
			skyBind[5] = [SkillDFC.id];
			
			floorBind[1] = [SkillJian1.id, SkillJian2.id, SkillJian3.id];
			floorBind[2] = [SkillJump.id];
			floorBind[3] = [SkillBlock.id];
			floorBind[4] = [SkillSLZ.id];
			floorBind[5] = [SkillST.id];
			floorBind[6] = [SkillJianBSJ.id];
			
			isChange = true;
		}
		
		/**
		 * 存档时调用,获取存档数据
		 * @return 
		 */
		public static function getSave():Object
		{
			return {
				skillInfo:skillInfo,
				skyBind:skyBind,
				floorBind:floorBind,
				runBind:runBind
			};
		}
		
		/**
		 * 载入存档
		 * @param obj
		 */
		public static function setSave(obj:Object):void
		{
			skillInfo = obj.skillInfo,
			skyBind = obj.skyBind,
			floorBind = obj.floorBind,
			runBind = obj.runBind
			
			isChange = true;
		}
		
	}
}