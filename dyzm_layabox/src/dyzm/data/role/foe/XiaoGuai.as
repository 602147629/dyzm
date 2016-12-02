package dyzm.data.role.foe
{
	import dyzm.Res;
	import dyzm.data.attr.GeniusVo;
	import dyzm.data.role.RoleSkinVo;
	import dyzm.data.skill.SkillBlock;
	import dyzm.data.skill.SkillJian1;
	
	public class XiaoGuai extends BaseAiControl
	{
		public var skill1:SkillJian1;
		public function XiaoGuai()
		{
			super();
			
			// 形象配置
			name = "小怪";
			style = Res.role1;
			skin = new RoleSkinVo();
			h = 280;
			
			// 属性配置
			attr.hp = int.MAX_VALUE;
			attr.maxHp = int.MAX_VALUE;
			
//			attr.hp = 10;
//			attr.maxHp = 10;
			attr.armor = 0;
			attr.maxArmor = 0;
			attr.minAtt = 1;
			attr.maxAtt = 2;
			attr.attArmor = 1;
			attr.critDmg = 1;
			attr.def = 0;
			attr.mf = 0;
			attr.gf = 0;
			attr.iceAtt = 0;
			attr.iceDef = 0;
			attr.fireAtt = 0;
			attr.fireDef = 0;
			attr.thundAtt = 0;
			attr.thundDef = 0;
			attr.toxinAtt = 0;
			attr.toxinDef = 0;
			attr.invincibleFrame = 0;
			attr.moveSpeed = 4;
			attr.runSpeed = 8;
			attr.jumpPower = -30;
			curAttr.add(attr);
			
			// 天赋配置
			genius = new GeniusVo();
			
			// ai配置
			findMoveStopTime = 30;
			attStartStopTime = 20;
			findMoveMaxX = 90;
			findMoveMinX = 40;
			findMoveMaxY = 40;
			findMoveMinY = 0;
			minBlockFrame = 60;
			
			// 格挡配置
			blockRate = 0.5;
			blockFrame = 300;
			block = new SkillBlock();
			block.roleVo = this;
			block.type = 0;
			
			//攻击技能配置
			skill1 = new SkillJian1();
			skill1.roleVo = this;
			skill1.type = 0;
			
			
			
		}
		
		override public function attTest():Boolean
		{
			if (curTarget && Math.abs(curTarget.x - x) < 300 && Math.abs(curTarget.y - y) < 50){
				var b:Boolean = skill1.startTest();
				if (b){
					curSkill = skill1;
					curSkillClass = SkillJian1;
					aiState = AI_STATE_ATT;
					skill1.start();
					return true;
				}else{
					return false;
				}
			}
			return false;
		}
	}
}