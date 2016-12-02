package dyzm.data.skill
{
	import dyzm.data.FightData;
	import dyzm.data.RoleState;
	import dyzm.data.WorldData;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	
	public class SkillKZPG extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "剑系空中普攻";
		
		/**
		 * 技能信息
		 */
		public static var tableVo:SkillTableVo;
		
		public static function getTableVo():SkillTableVo
		{
			if (tableVo == null){
				tableVo = new SkillTableVo();
				tableVo.id = id;
				tableVo.cls = SkillKZPG;
				tableVo.name = "空斩"; 
				tableVo.info = "空中斩击";
				tableVo.xi = SkillTable.XI_JIAN;
				tableVo.startState = SkillTable.SKY;
				tableVo.frameName = "剑系空中普攻";
				tableVo.needGold = 50;
				tableVo.needDay = 1;
				tableVo.up1Name = "破甲";
				tableVo.up1Info = "破甲+1";
				tableVo.up1Gold = 100;
				tableVo.up1Day = 3;
				tableVo.up2Name = "伤害";
				tableVo.up2Info = "攻击力+1";
				tableVo.up2Gold = 100;
				tableVo.up2Day = 3;
				tableVo.canCancelAfter = [SkillSLZ.id, SkillSLT.id, SkillDFC.id];
				tableVo.skillComboTime = 0;
			}
			return tableVo;
		}
		
		public function SkillKZPG()
		{
			super();
			
			attSpot.isFly = false;
			attSpot.x = 200;
			attSpot.xFrame = 2;
			attSpot.z = -5;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0;
			attSpot.zDecline = 0;
			attSpot.attDecline = 0;
			attSpot.armorDecline = 0;
			attSpot.stiffFrame = 30;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.canTurn = false;
			// 该技能可以攻击到的攻击块
			// 鹰踢可以攻击到已经倒地的玩家
			attSpot.byList = [AttInfo.BY_ATT_NORMAL, AttInfo.BY_ATT_FELL];
			// 攻击火花类型
			attSpot.attFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 防御火花类型
			attSpot.defFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 火花角度
			attSpot.attFireRotation = -60;
			
			attSpot.foeActionToHead = AttInfo.YANG_TIAN;
			
			attSpot.foeAction = AttInfo.DI_TOU;
		}	
		
		/**
		 * 技能检测, 在通过初步检测后调用,进入进一步判断
		 * 初步检测包括 是否符合技能的释放位置(地面,空中,跑步),并且不在被攻击状态
		 * @return ture=可以释放
		 */
		override public function startTest():Boolean
		{
			if (roleVo.jumpInfo[SkillKZPG.id] != null){
				return false;
			}
			if (roleVo.attState == RoleState.ATT_AFTER_CANCEL || roleVo.attState == RoleState.ATT_NORMAL){
				return true;
			}
			if (roleVo.attState == RoleState.ATT_AFTER){
				for each (var id:String in tableVo.canCancelAfter) 
				{
					if (roleVo.curSkillClass.id == id){
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 * 技能开始
		 */
		override public function start():void
		{
			attSpot.attr.minAtt = roleVo.curAttr.minAtt;
			attSpot.attr.maxAtt = roleVo.curAttr.maxAtt;
			attSpot.attr.attArmor = roleVo.curAttr.attArmor;
			attSpot.attr.iceAtt = roleVo.curAttr.iceAtt;
			attSpot.attr.fireAtt = roleVo.curAttr.fireAtt;
			attSpot.attr.thundAtt = roleVo.curAttr.thundAtt;
			attSpot.attr.toxinAtt = roleVo.curAttr.toxinAtt;
			attSpot.attr.critDmg = roleVo.curAttr.critDmg;
			
			if (type==1){
				attSpot.attr.attArmor += 1;
			}else if (type==2){
				attSpot.attr.minAtt += 1;
			}
			
			roleVo.jumpInfo[id] = true;
			roleVo.frameName = tableVo.frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			if (roleVo.roleMc.label != null){
				roleVo.attState = SkillTable.FRAME_TO_STATE[roleVo.roleMc.label];
			}
			
			roleVo.x += roleVo.curMoveSpeedX;
			roleVo.y += roleVo.curMoveSpeedY;
			if (roleVo.y > FightData.level.bottomY){
				roleVo.y = FightData.level.bottomY;
			}else if (roleVo.y < FightData.level.topY){
				roleVo.y = FightData.level.topY;
			}
			roleVo.z += roleVo.curFlyPower;
			
			if (roleVo.z >= 0){ // 落地 
				roleVo.inFlood();
				roleVo.z = 0;
				roleVo.curState = RoleState.STATE_NORMAL;
				end();
			}else{
				if (roleVo.roleMc.totalFrames == roleVo.curFrame){ // 动作完成
					end();
				}else{
					roleVo.curFrame ++;
				}
				roleVo.curFlyPower -= WorldData.G;
			}
			
			super.run();
		}
	}
}