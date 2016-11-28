package dyzm.data
{
	import dyzm.data.role.KeyToSkillVo;
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
	

	/**
	 * 主角技能
	 * @author dj
	 */
	public class PlayerSkillData
	{
		
		/**
		 * 名字到技能类的对应表
		 */
		public static var keyToSkill:KeyToSkillVo;
		
		/**
		 * 地面技能绑定
		 * 例:{1:技能ID}
		 */
		public static var floorBind:Object = {};
		
		/**
		 * 空中技能绑定
		 */
		public static var skyBind:Object = {};
		
		/**
		 * 跑步技能绑定
		 */
		public static var runBind:Object = {};
		
		/**
		 * 技能绑定是否改变
		 */
		public static var isChange:Boolean;
		
		/**
		 * 技能id为key,储存技能实例
		 */
		public static var skills:Object;
		
		/**
		 * 没学会的技能
		 */
		public static const NO:int = -1;
		
		/**
		 * 学会的技能
		 */
		public static const YES:int = 0;
		
		/**
		 * 开启第一进阶的技能
		 */
		public static const TYPE1:int = 1;
		/**
		 * 开启第二进阶的技能
		 */
		public static const TYPE2:int = 2;
		
		public static function init():void
		{
			keyToSkill = new KeyToSkillVo();
			skills = {};
			skills[SkillBlock.id] = new SkillBlock();
			skills[SkillDFC.id] = new SkillDFC();
			skills[SkillJian1.id] = new SkillJian1();
			skills[SkillJian2.id] = new SkillJian2();
			skills[SkillJian3.id] = new SkillJian3();
			skills[SkillJianBSJ.id] = new SkillJianBSJ();
			skills[SkillJump.id] = new SkillJump();
			skills[SkillKZPG.id] = new SkillKZPG();
			skills[SkillLKZ.id] = new SkillLKZ();
			skills[SkillSLT.id] = new SkillSLT();
			skills[SkillSLZ.id] = new SkillSLZ();
			skills[SkillST.id] = new SkillST();
			skills[SkillYingTi.id] = new SkillYingTi();
		}
		
		public static function newGame():void
		{
			skyBind[1] = [[SkillKZPG.id, 0]];
			skyBind[2] = [[SkillSLT.id, 0]];
			skyBind[3] = [[SkillYingTi.id, 2]];
			skyBind[4] = [[SkillLKZ.id, 0]];
			skyBind[5] = [[SkillDFC.id, 0]];
			
			floorBind[1] = [[SkillJian1.id, 0], [SkillJian2.id, 0], [SkillJian3.id, 0]];
			floorBind[2] = [[SkillJump.id, 2]];
			floorBind[3] = [[SkillBlock.id, 2]];
			floorBind[4] = [[SkillSLZ.id, 0]];
			floorBind[5] = [[SkillST.id, 0]];
			floorBind[6] = [[SkillJianBSJ.id, 0]];
			
			isChange = true;
		}
		
		/**
		 * 存档时调用,获取存档数据
		 * @return 
		 */
		public static function getSave():Object
		{
			return {
				skyBind:skyBind,
				floorBind:floorBind,
				runBind:runBind
			};
		}
		
		/**
		 * 载入存档
		 * @param obj
		 */
		public static function setSave(obj:Object):void
		{
			skyBind = obj.skyBind,
			floorBind = obj.floorBind,
			runBind = obj.runBind
		}
	}
}