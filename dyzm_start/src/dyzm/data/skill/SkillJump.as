package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.WorldData;
	import dyzm.data.role.RoleVo;
	
	public class SkillJump extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "跳";
		/**
		 * 名称
		 */
		public static const name:String = "跳";
		
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
		public static const frameName:String = "跳";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = ["剑1", "剑2", "剑3", "鹰踢", "裂空斩", "上挑"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 0;
		
		public function SkillJump(role:RoleVo)
		{
			super(role);
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
			roleVo.z = roleVo.curAttr.jumpPower;
			roleVo.curFlyPower = roleVo.curAttr.jumpPower - WorldData.G;
			
			roleVo.curState = RoleState.STATE_AIR;
			roleVo.attState = RoleState.ATT_NORMAL;
			roleVo.frameName = RoleVo.TAG_JUMP;
			roleVo.curFrame = 1;
			roleVo.curSkill = null;
		}
	}
}


