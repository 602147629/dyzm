package dyzm.data.role
{
	import dyzm.data.skill.SkillJian1;
	import dyzm.data.skill.SkillJian2;
	import dyzm.data.skill.SkillJian3;
	import dyzm.data.skill.SkillJian4;
	import dyzm.data.skill.SkillKZPG;
	import dyzm.data.skill.SkillLKZ;
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
			skillSkyBind[2] = [SkillYingTi];
			skillSkyVo[2] = [new SkillYingTi(roleVo)];
			skillSkyBind[3] = [SkillLKZ];
			skillSkyVo[3] = [new SkillLKZ(roleVo)];
			
			skillFloorBind[1] = [SkillJian1, SkillJian2, SkillJian3, SkillJian4];
			skillFloorVo[1] = [new SkillJian1(roleVo), new SkillJian2(roleVo), new SkillJian3(roleVo), new SkillJian4(roleVo)];
			
			skillFloorBind[2] = [SkillST];
			skillFloorVo[2] = [new SkillST(roleVo)];
		}
	}
}