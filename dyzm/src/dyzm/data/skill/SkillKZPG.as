package dyzm.data.skill
{
	import dyzm.data.FightData;
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.WorldData;
	import dyzm.data.role.RoleVo;
	
	public class SkillKZPG extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "空中普攻";
		/**
		 * 名称
		 */
		public static const name:String = "空中普攻";
		
		/**
		 * 所属系
		 */
		public static const xi:int = SkillData.XI_TI;
		
		/**
		 * 启动状态
		 */
		public static const startState:int = SkillData.SKY;
		
		/**
		 * 帧名称
		 */
		public static const frameName:String = "空中普攻";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = ["升龙斩"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 0;
		
		public function SkillKZPG(role:RoleVo)
		{
			super(role);
			
			attSpot.isFly = false;
			attSpot.x = 300;
			attSpot.xFrame = 2;
			attSpot.z = -5;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0.2;
			attSpot.zDecline = 0.2;
			attSpot.attDecline = 0.3;
			attSpot.armorDecline = 0.3;
			attSpot.attr.attMin = 1;
			attSpot.attr.attMax = 1;
			attSpot.attr.attArmor = 1;
			attSpot.stiffFrame = 45;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.canTurn = false;
			// 该技能可以攻击到的攻击块
			// 鹰踢可以攻击到已经倒地的玩家
			attSpot.byList = [AttInfo.BY_ATT_NORMAL, AttInfo.BY_ATT_FELL];
			// 攻击火花类型
			attSpot.attFireType = AttInfo.FIRE_TYPE_SHARP_TRANSVERSE;
			
			// 防御火花类型
			attSpot.defFireType = AttInfo.FIRE_TYPE_SHARP_TRANSVERSE;
			
			attSpot.foeActionToHead = AttInfo.YANG_TIAN;
			
			attSpot.foeAction = AttInfo.DI_TOU;
		}	
		
		/**
		 * 技能检测, 在通过初步检测后调用,进入进一步判断
		 * 初步检测包括 是否符合技能的释放位置(地面,空中,跑步),并且不在被攻击状态
		 * @return ture=可以释放
		 */
		override public function startTest():Boolean
		{
			if (roleVo.jumpInfo[SkillKZPG.id] != null){
				return false;
			}
			if (roleVo.attState == RoleState.ATT_AFTER_CANCEL || roleVo.attState == RoleState.ATT_NORMAL){
				return true;
			}
			if (roleVo.attState == RoleState.ATT_AFTER){
				for each (var id:String in CAN_CANCEL_AFTER) 
				{
					if (roleVo.curSkillClass.id == id){
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 * 技能开始
		 */
		override public function start():void
		{
			roleVo.jumpInfo[SkillKZPG.id] = true;
			roleVo.frameName = frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			// 更新当前攻击状态
			roleVo.attState = SkillData.FRAME_TO_STATE[roleVo.roleMc.role.currentLabel];
			
			roleVo.x += roleVo.curMoveSpeedX;
			roleVo.y += roleVo.curMoveSpeedY;
			if (roleVo.y > FightData.level.bottomY){
				roleVo.y = FightData.level.bottomY;
			}else if (roleVo.y < FightData.level.topY){
				roleVo.y = FightData.level.topY;
			}
			roleVo.z += roleVo.curFlyPower;
			
			if (roleVo.z >= 0){ // 落地
				roleVo.inFlood();
				roleVo.z = 0;
				roleVo.curState = RoleState.STATE_NORMAL;
				end();
			}else{
				if (roleVo.roleMc.role.totalFrames == roleVo.curFrame){ // 动作完成
					end();
				}else{
					roleVo.curFrame ++;
				}
				roleVo.curFlyPower -= WorldData.G;
			}
			
			super.run();
		}
	}
}