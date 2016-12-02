package dyzm.data.role
{
	import dyzm.data.PlayerSkillData;
	import dyzm.data.table.skill.SkillTable;
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
	

	public class KeyToSkillVo
	{
		/**
		 * 地面技能绑定
		 * 例:{1:类名}
		 */
		public var floorBind:Object = {};
		
		/**
		 * 空中技能绑定
		 */
		public var skyBind:Object = {};
		
		/**
		 * 跑步技能绑定
		 */
		public var runBind:Object = {};
		
		/**
		 * 地面技能
		 * 例:{1 : new SkillYingTi()}
		 */
		public var floorVo:Object = {};
		
		/**
		 * 空中技能
		 */
		public var skyVo:Object = {};
		
		/**
		 * 跑步技能
		 */
		public var runVo:Object = {};
		
		public var blockId:int = 3;
		
		
		public function KeyToSkillVo()
		{
			
		}
		
		public function init(roleVo:RoleVo, _floorBind:Object, _runBind:Object, _skyBind:Object):void
		{
			var i:int, j:int, id:String, type:int;
			for (i in _floorBind){
				floorBind[i] = [];
				floorVo[i] = [];
				for (j = 0; j < _floorBind[i].length; j++) 
				{
					id = _floorBind[i][j];
					type = PlayerSkillData.skillInfo[id].type;
					if (id == SkillBlock.id){
						blockId = i;
					}
					floorBind[i][j] = SkillTable.idToSkill[id];
					floorVo[i][j] = PlayerSkillData.skills[id];
					floorVo[i][j].type = type;
					floorVo[i][j].roleVo = roleVo;
				}
			}
			
			for (i in _runBind){
				runBind[i] = [];
				runVo[i] = [];
				for (j = 0; j < _runBind[i].length; j++) 
				{
					id = _runBind[i][j];
					type = PlayerSkillData.skillInfo[id].type;
					
					runBind[i][j] = SkillTable.idToSkill[id];
					runVo[i][j] = PlayerSkillData.skills[id];
					runVo[i][j].type = type;
					runVo[i][j].roleVo = roleVo;
				}
			}
			
			for (i in _skyBind){
				skyBind[i] = [];
				skyVo[i] = [];
				for (j = 0; j < _skyBind[i].length; j++) 
				{
					id = _skyBind[i][j];
					type = PlayerSkillData.skillInfo[id].type;
					
					skyBind[i][j] = SkillTable.idToSkill[id];
					skyVo[i][j] = PlayerSkillData.skills[id];
					skyVo[i][j].type = type;
					skyVo[i][j].roleVo = roleVo;
				}
			}
		}
	}
}