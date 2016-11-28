package dyzm.data
{
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

	public class SkillData
	{
		/**
		 * 体系
		 */
		public static const XI_TI:int = 1;
		
		/**
		 * 剑系
		 */
		public static const XI_JIAN:int = 2;
		
		/**
		 * 枪系
		 */
		public static const XI_QIANG:int = 3;
		
		
		
		/**
		 * 地面技能
		 */
		public static const FLOOR:int = 1;
		
		/**
		 * 空中技能
		 */
		public static const SKY:int = 2;
		
		/**
		 * 跑中技能
		 */
		public static const RUN:int = 3;
		
		/**
		 * 攻击前摇的帧标签
		 */
		public static const FRAME_BEFORE:String = "before";
		
		/**
		 * 攻击前摇结束,正式进入攻击状态的帧标签
		 */
		public static const FRAME_ATT:String = "att";
		
		/**
		 * 攻击结束,进入攻击后摇状态的帧标签
		 */
		public static const FRAME_AFTER:String = "after";
		
		/**
		 * 攻击后摇结束,进入耍帅动作的帧标签
		 */
		public static const FRAME_AFTER_CANCEL:String = "cancel";
		
		
		
		/**
		 * 帧标签对应的攻击状态
		 */
		public static const FRAME_TO_STATE:Object = {
			"before":RoleState.ATT_BEFORE,
				"att":RoleState.ATT_ING,
				"att2":RoleState.ATT_ING,
				"after":RoleState.ATT_AFTER,
				"cancel":RoleState.ATT_AFTER_CANCEL
		}
		
		/**
		 * 名字到技能类的对应表
		 */
		public static var idToSkill:Object;
		
		
		public static function init():void
		{
			idToSkill = {};
			idToSkill[SkillJian1.id] = SkillJian1;
			idToSkill[SkillJian2.id] = SkillJian2;
			idToSkill[SkillJian3.id] = SkillJian3;
			idToSkill[SkillYingTi.id] = SkillYingTi;
			
			idToSkill[SkillST.id] = SkillST;
			idToSkill[SkillKZPG.id] = SkillKZPG;
			idToSkill[SkillBlock.id] = SkillBlock;
			idToSkill[SkillJump.id] = SkillJump;
			idToSkill[SkillSLZ.id] = SkillSLZ;
			idToSkill[SkillSLT.id] = SkillSLT;
			idToSkill[SkillLKZ.id] = SkillLKZ;
			idToSkill[SkillJianBSJ.id] = SkillJianBSJ;
			idToSkill[SkillDFC.id] = SkillDFC;
		}
	}
}