package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.role.RoleVo;
	
	public class SkillDFC extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "大风车";
		/**
		 * 名称
		 */
		public static const name:String = "大风车";
		
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
		public static const frameName:String = "大风车";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = ["剑系空中普攻", "升龙斩", "升龙踢"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 0;
		
		public function SkillDFC(role:RoleVo)
		{
			super(role);
			
			// 该技能可以攻击到的攻击块
			attSpot.byList = [AttInfo.BY_ATT_NORMAL];
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
			if (roleVo.jumpInfo[SkillDFC.id] != null){
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
			attSpot.isFly = true;
			attSpot.x = 300;
			attSpot.xFrame = 1;
			attSpot.z = 50;
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
			attSpot.minBounceZ = -43;
			attSpot.canTurn = false;
			
			roleVo.jumpInfo[SkillDFC.id] = true;
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
			var toState:int = SkillData.FRAME_TO_STATE[roleVo.roleMc.role.currentLabel];
			
			if (roleVo.attState != toState && toState == RoleState.ATT_AFTER){
				roleVo.attState = toState;
				roleVo.setSkillComboTime(SKILL_COMBO_TIME); // 30帧以内可以出下一招
				roleVo.reAction();
			}
			if (roleVo.roleMc.role.currentFrameLabel == "att2"){
				attSpot.isFly = true;
				attSpot.x = 300;
				attSpot.xFrame = 4;
				attSpot.z = -30;
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
				attSpot.minBounceZ = 0;
				attSpot.canTurn = false;
			}
			roleVo.curFrame ++;
			
			if (roleVo.curFrame == roleVo.roleMc.role.totalFrames){
				roleVo.attState = RoleState.ATT_NORMAL;
				end();
			}
			
			super.run();
		}
	}
}