package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	
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
		
		public function SkillDFC()
		{
			super();
			
			// 该技能可以攻击到的攻击块
			attSpot.byList = [AttInfo.BY_ATT_NORMAL];
			// 攻击火花类型
			attSpot.attFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 防御火花类型
			attSpot.defFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 火花角度
			attSpot.attFireRotation = 0;
			
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
			attSpot.stiffDecline = 0;
			attSpot.zDecline = 0;
			attSpot.attDecline = 0;
			attSpot.armorDecline = 0;
			attSpot.stiffFrame = 45;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.minBounceZ = -43;
			attSpot.canTurn = false;
			
			attSpot.attr.minAtt = roleVo.curAttr.minAtt;
			attSpot.attr.maxAtt = roleVo.curAttr.maxAtt;
			attSpot.attr.attArmor = roleVo.curAttr.attArmor;
			attSpot.attr.iceAtt = roleVo.curAttr.iceAtt;
			attSpot.attr.fireAtt = roleVo.curAttr.fireAtt;
			attSpot.attr.thundAtt = roleVo.curAttr.thundAtt;
			attSpot.attr.toxinAtt = roleVo.curAttr.toxinAtt;
			attSpot.attr.critDmg = roleVo.curAttr.critDmg;
			
			roleVo.jumpInfo[SkillDFC.id] = true;
			roleVo.frameName = frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			roleVo.curFlyPower = 0;
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			if (roleVo.curFrame == roleVo.roleMc.totalFrames){
				roleVo.attState = RoleState.ATT_NORMAL;
				end();
			}else {
				if (roleVo.roleMc.label != null){
					var toState:int = SkillData.FRAME_TO_STATE[roleVo.roleMc.label];
					if (roleVo.attState != toState){
						roleVo.attState = toState;
						if (toState == RoleState.ATT_AFTER){
							roleVo.setSkillComboTime(SKILL_COMBO_TIME); // 30帧以内可以出下一招
							roleVo.reAction();
						}
					}
				}
				
				if (roleVo.roleMc.label == "att2"){
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
					attSpot.attr.minAtt = 1;
					attSpot.attr.maxAtt = 1;
					attSpot.attr.attArmor = 1;
					attSpot.stiffFrame = 45;
					attSpot.curAttSpot = 1;
					attSpot.range = 8;
					attSpot.minBounceZ = 0;
					attSpot.canTurn = false;
				}
				
				roleVo.curFrame ++;
			}
			
			super.run();
		}
	}
}