package dyzm.data.role
{
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
	

	public class KeyToSkillVo
	{
		/**
		 * 地面技能绑定
		 * 例:{1:类名}
		 */
		public var skillFloorBind:Object = {};
		
		/**
		 * 空中技能绑定
		 */
		public var skillSkyBind:Object = {};
		
		/**
		 * 跑步技能绑定
		 */
		public var skillRunBind:Object = {};
		
		/**
		 * 地面技能
		 * 例:{1 : new SkillYingTi()}
		 */
		public var skillFloorVo:Object = {}
		
		/**
		 * 空中技能
		 */
		public var skillSkyVo:Object = {}
		
		/**
		 * 跑步技能
		 */
		public var skillRunVo:Object = {}
		
		public function KeyToSkillVo(roleVo:RoleVo)
		{
			skillSkyBind[1] = [SkillKZPG];
			skillSkyVo[1] = [new SkillKZPG(roleVo)];
			skillSkyBind[2] = [SkillSLT];
			skillSkyVo[2] = [new SkillSLT(roleVo)];
			skillSkyBind[3] = [SkillYingTi];
			skillSkyVo[3] = [new SkillYingTi(roleVo)];
			skillSkyBind[4] = [SkillLKZ];
			skillSkyVo[4] = [new SkillLKZ(roleVo)];
			skillSkyBind[5] = [SkillDFC];
			skillSkyVo[5] = [new SkillDFC(roleVo)];
			
			skillFloorBind[1] = [SkillJian1, SkillJian2, SkillJian3];
			skillFloorVo[1] = [new SkillJian1(roleVo), new SkillJian2(roleVo), new SkillJian3(roleVo)];
			skillFloorBind[2] = [SkillJump];
			skillFloorVo[2] = [new SkillJump(roleVo)];
			skillFloorBind[3] = [SkillST];
			skillFloorVo[3] = [new SkillST(roleVo)];
			skillFloorBind[4] = [SkillSLZ];
			skillFloorVo[4] = [new SkillSLZ(roleVo)];
			
			skillFloorBind[6] = [SkillJianBSJ];
			skillFloorVo[6] = [new SkillJianBSJ(roleVo)];
		}
	}
}