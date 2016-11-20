package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.role.RoleVo;
	
	public class SkillBlock extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "格挡";
		/**
		 * 名称
		 */
		public static const name:String = "格挡";
		
		/**
		 * 所属系
		 */
		public static const xi:int = SkillData.XI_TI;
		
		/**
		 * 启动状态
		 */
		public static const startState:int = SkillData.FLOOR;
		
		/**
		 * 帧名称
		 */
		public static const frameName:String = "格挡";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = [];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 0;
		
		public function SkillBlock(role:RoleVo)
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
			if (roleVo.attState == RoleState.ATT_ING){
				return false;
			}
			return true;
		}
		
		/**
		 * 技能开始
		 */
		override public function start():void
		{
			roleVo.isBlock = true;
			roleVo.frameName = RoleVo.TAG_BLOCK;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_NORMAL;
			roleVo.isRuning = false;
			roleVo.curSkill = null;
		}
	}
}


