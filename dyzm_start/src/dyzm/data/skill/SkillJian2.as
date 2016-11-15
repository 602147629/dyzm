package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.role.RoleVo;
	
	public class SkillJian2 extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "剑2";
		/**
		 * 名称
		 */
		public static const name:String = "剑系普攻二段";
		
		/**
		 * 所属系
		 */
		public static const xi:int = SkillData.XI_JIAN;
		
		/**
		 * 启动状态
		 */
		public static const startState:int = SkillData.FLOOR;
		
		/**
		 * 帧名称
		 */
		public static const frameName:String = "剑2";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = ["剑1"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 30;
		
		/**
		 * 该技能出招时的位移效果
		 */
		public const speedX:int = 12;
		public const stopX:int = 6;
		public const addX:int = 20;
		public var curSpeedX:int = 0;
		
		public function SkillJian2(role:RoleVo)
		{
			super(role);
			
			attSpot.isFly = false;
			attSpot.x = 300;
			attSpot.xFrame = 10;
			attSpot.z = -30;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0.1;
			attSpot.zDecline = 0.01;
			attSpot.attDecline = 0.1;
			attSpot.armorDecline = 0.1;
			attSpot.attr.attMin = 1;
			attSpot.attr.attMax = 1;
			attSpot.attr.attArmor = 1;
			attSpot.stiffFrame = 45;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.canTurn = false;
			// 该技能可以攻击到的攻击块
			// 鹰踢可以攻击到已经倒地的玩家
			attSpot.byList = [AttInfo.BY_ATT_NORMAL];
			// 攻击火花类型
			attSpot.attFireType = AttInfo.FIRE_TYPE_SHARP_TRANSVERSE;
			
			// 防御火花类型
			attSpot.defFireType = AttInfo.FIRE_TYPE_SHARP_TRANSVERSE;
			
			attSpot.foeAction = AttInfo.YANG_TIAN;
		}	
		/**
		 * 技能检测, 在通过初步检测后调用,进入进一步判断
		 * 初步检测包括 是否符合技能的释放位置(地面,空中,跑步),并且不在被攻击状态
		 * @return ture=可以释放
		 */
		override public function startTest():Boolean
		{
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
				return false;
			}
			return false;
		}
		
		/**
		 * 技能开始
		 */
		override public function start():void
		{
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
			
			
			if (roleVo.curFrame == 5){
				if (roleVo.curDir == 2 || roleVo.curDir == 5 || roleVo.curDir == 8){
					if (roleVo.curTurn == 1){
						curSpeedX = speedX;
					}else{
						curSpeedX = -speedX;
					}
				}else if (roleVo.curDir == 9 || roleVo.curDir == 6 || roleVo.curDir == 3){
					if (roleVo.curTurn == 1){
						curSpeedX = addX;
					}else{
						curSpeedX = -stopX;
					}
				}else if (roleVo.curDir == 7 || roleVo.curDir == 4 || roleVo.curDir == 1){
					if (roleVo.curTurn == 1){
						curSpeedX = stopX;
					}else{
						curSpeedX = -addX;
					}
				}
			}
			
			if (roleVo.curFrame >= 5 && roleVo.curFrame <= 21){
				roleVo.x += curSpeedX;
			}
			
			if (roleVo.attState != toState && toState == RoleState.ATT_AFTER){
				roleVo.attState = toState;
				roleVo.setSkillComboTime(SKILL_COMBO_TIME); // 30帧以内可以出下一招
				roleVo.reAction();
			}
			
			if (roleVo.curFrame == roleVo.roleMc.role.totalFrames){
				roleVo.attState = RoleState.ATT_NORMAL;
				end();
			}
			
			roleVo.curFrame ++;
			super.run();
		}
	}
}


