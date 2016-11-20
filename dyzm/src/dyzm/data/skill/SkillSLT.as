package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.WorldData;
	import dyzm.data.role.RoleVo;
	
	public class SkillSLT extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "升龙踢";
		/**
		 * 名称
		 */
		public static const name:String = "升龙踢";
		
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
		public static const frameName:String = "升龙踢";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = ["剑系空中普攻", "升龙斩", "大风车"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 0;
		
		/**
		 * 该技能出招时的位移效果
		 */
		public const speedZ:Number = -28;
		public const speedX:int = 0;
		public const stopX:int = 0;
		public const addX:int = 12;
		public var curSpeedX:int = 0;
		
		public var uping:Boolean = false;
		
		public function SkillSLT(role:RoleVo)
		{
			super(role);
			
			attSpot.isFly = true;
			attSpot.x = 300;
			attSpot.xFrame = 1;
			attSpot.z = -30;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0.2;
			attSpot.zDecline = 0.2;
			attSpot.attDecline = 0.3;
			attSpot.armorDecline = 0.3;
			attSpot.stiffFrame = 45;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.canTurn = false;
			// 该技能可以攻击到的攻击块
			// 鹰踢可以攻击到已经倒地的玩家
			attSpot.byList = [AttInfo.BY_ATT_NORMAL, AttInfo.BY_ATT_FELL];
			// 攻击火花类型
			attSpot.attFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 防御火花类型
			attSpot.defFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			
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
			if (roleVo.jumpInfo[SkillSLT.id] != null){
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
			attSpot.attr.minAtt = roleVo.curAttr.minAtt;
			attSpot.attr.maxAtt = roleVo.curAttr.maxAtt;
			attSpot.attr.attArmor = roleVo.curAttr.attArmor;
			attSpot.attr.iceAtt = roleVo.curAttr.iceAtt;
			attSpot.attr.fireAtt = roleVo.curAttr.fireAtt;
			attSpot.attr.thundAtt = roleVo.curAttr.thundAtt;
			attSpot.attr.toxinAtt = roleVo.curAttr.toxinAtt;
			
			roleVo.jumpInfo[SkillSLT.id] = true;
			roleVo.frameName = frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			uping = false;
			// 火花角度
			attSpot.attFireRotation = 10;
			if (roleVo.curDir == 2 || roleVo.curDir == 5 || roleVo.curDir == 8){
				if (roleVo.curTurn == 1){
					curSpeedX = speedX;
				}else{
					curSpeedX = -speedX;
				}
			}else if (roleVo.curDir == 9 || roleVo.curDir == 6 || roleVo.curDir == 3){
				if (roleVo.curTurn == 1){
					// 火花角度
					attSpot.attFireRotation = 60;
					curSpeedX = addX;
				}else{
					curSpeedX = -stopX;
				}
			}else if (roleVo.curDir == 7 || roleVo.curDir == 4 || roleVo.curDir == 1){
				if (roleVo.curTurn == 1){
					curSpeedX = stopX;
				}else{
					// 火花角度
					attSpot.attFireRotation = 60;
					curSpeedX = -addX;
				}
			}
			attSpot.xFrame = Math.abs(curSpeedX);
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			// 更新当前攻击状态
			var toState:int = SkillData.FRAME_TO_STATE[roleVo.roleMc.role.currentLabel];
			
			if (roleVo.attState != toState && toState == RoleState.ATT_ING){
				roleVo.attState = toState;
				roleVo.curFlyPower = speedZ;
				roleVo.curState = RoleState.STATE_AIR;
				uping = true;
			}
			if (uping){
				roleVo.x += curSpeedX;
				// 直线向上
				roleVo.z += roleVo.curFlyPower;
				roleVo.curFlyPower -= WorldData.G;
			}
			
			if (roleVo.attState != toState){
				roleVo.attState = toState;
				if (toState == RoleState.ATT_AFTER){
					roleVo.setSkillComboTime(SKILL_COMBO_TIME); // 30帧以内可以出下一招
					roleVo.reAction();
				}
			}
			
			if (roleVo.curFrame == roleVo.roleMc.role.totalFrames){
				roleVo.attState = RoleState.ATT_NORMAL;
				end();
			}
			if (roleVo.roleMc.role.currentLabel != "att2"){
				roleVo.curFrame ++;
			}else if (roleVo.curFlyPower > 0 || uping == false){
				roleVo.curFrame ++;
			}
			super.run();
		}
	}
}