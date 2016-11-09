package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.vo.RoleVo;
	
	public class SkillYingTi extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "鹰踢";
		/**
		 * 名称
		 */
		public static const name:String = "鹰踢";
		
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
		public static const frameName:String = "鹰踢";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = ["空中剑系普攻"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 0;
		
		public const speedX:Number = 25;
		public const speedZ:Number = 20;
		
		public var addX:Number = 0;
		
		
		public function SkillYingTi(role:RoleVo)
		{
			super(role);
			
			attSpot.isFly = false;
			attSpot.x = 100;
			attSpot.xFrame = 1;
			attSpot.z = -30;
			attSpot.upY = 30;
			attSpot.downY = 30;
			attSpot.zDecline = 0.1;
			attSpot.hp = 1;
			attSpot.armor = 1;
			attSpot.stiffFrame = 60;
			// 该技能可以攻击到的攻击块
			// 鹰踢可以攻击到已经倒地的玩家
			attSpot.byList = [AttInfo.BY_ATT_NORMAL, AttInfo.BY_ATT_FELL];
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
			attSpot.curAttSpot = 0;
			roleVo.frameName = frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			addX = 0;
			if (roleVo.curTurn == 1){
				if (roleVo.curDir == 9 || roleVo.curDir == 6 || roleVo.curDir == 3){
					if (roleVo.isRuning){
						addX = 10;
					}else{
						addX = 5;
					}
				}
			}else{
				if (roleVo.curDir == 7 || roleVo.curDir == 4 || roleVo.curDir == 1){
					if (roleVo.isRuning){
						addX = 10;
					}else{
						addX = 5;
					}
				}
			}
			
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			
			if (roleVo.roleMc.currentLabel != frameName){ // 视图还没有更新
				return;
			}
			
			// 更新当前攻击状态
			roleVo.attState = SkillData.FRAME_TO_STATE[roleVo.roleMc.role.currentLabel];
			
			// 攻击中
			if (roleVo.attState == RoleState.ATT_ING){ // 45度向下冲击
				// 攻击属性设置
				attSpot.isFly = false;
				attSpot.x = 50;
				attSpot.z = 10;
				attSpot.curAttSpot = 1;
				
				roleVo.z += speedZ;
				if (roleVo.z >= 0){ // 落地,进入该技能的耍帅动作
					roleVo.curFrame ++;
					roleVo.x += (speedX + addX - roleVo.z) * roleVo.curTurn;
					roleVo.z = 0;
					roleVo.curState = RoleState.STATE_NORMAL;
					roleVo.attState = RoleState.ATT_AFTER_CANCEL;
					roleVo.setSkillComboTime(SKILL_COMBO_TIME);
					roleVo.reAction();
				}else{
					roleVo.x += (speedX + addX) * roleVo.curTurn;
				}
			}else{
				if (roleVo.roleMc.role.totalFrames == roleVo.curFrame){ // 动作完成
					roleVo.attState = RoleState.ATT_NORMAL;
					roleVo.curState = RoleState.STATE_NORMAL;
					end();
				}else{
					roleVo.curFrame ++;
				}
			}
			super.run();
		}
	}
}