package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	
	public class SkillDFC extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "大风车";
		/**
		 * 技能信息
		 */
		public static var tableVo:SkillTableVo;
		
		public static function getTableVo():SkillTableVo
		{
			if (tableVo == null){
				tableVo = new SkillTableVo();
				tableVo.id = id;
				tableVo.cls = SkillDFC;
				tableVo.name = "大风车"; 
				tableVo.info = "空中将目标击向地面,目标碰到地面后会弹起";
				tableVo.xi = SkillTable.XI_JIAN;
				tableVo.startState = SkillTable.SKY;
				tableVo.frameName = "大风车";
				tableVo.needGold = 50;
				tableVo.needDay = 1;
				tableVo.up1Name = "轮回";
				tableVo.up1Info = "空中普攻和升龙踢可以在本次跳跃中再次使用";
				tableVo.up1Gold = 200;
				tableVo.up1Day = 3;
				tableVo.up2Name = "巨力";
				tableVo.up2Info = "距离地面2个身高以上发动此技能时,攻击力翻倍";
				tableVo.up2Gold = 200;
				tableVo.up2Day = 3;
				tableVo.canCancelAfter = [SkillKZPG.id, SkillSLZ.id, SkillSLT.id];
				tableVo.skillComboTime = 0;
			}
			return tableVo;
		}
		
		public function SkillDFC()
		{
			super();
			
			// 该技能可以攻击到的攻击块
			attSpot.byList = [AttInfo.BY_ATT_NORMAL];
			// 攻击火花类型
			attSpot.attFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 防御火花类型
			attSpot.defFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 火花角度
			attSpot.attFireRotation = 0;
			
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
			if (roleVo.jumpInfo[SkillDFC.id] != null){
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
			if (type == 1){ // 轮回, 空中普攻和升龙踢可以在本次跳跃中再次使用
				roleVo.jumpInfo[SkillKZPG.id] = null;
				roleVo.jumpInfo[SkillSLT.id] = null;
			}
			
			attSpot.isFly = true;
			attSpot.x = 300;
			attSpot.xFrame = 1;
			attSpot.z = 50;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0;
			attSpot.zDecline = 0;
			attSpot.attDecline = 0;
			attSpot.armorDecline = 0;
			attSpot.stiffFrame = 45;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.minBounceZ = -43;
			attSpot.canTurn = false;
			
			attSpot.attr.minAtt = roleVo.curAttr.minAtt;
			attSpot.attr.maxAtt = roleVo.curAttr.maxAtt;
			if (type == 2){ // 巨力, 距离地面2个身高以上发动此技能时,攻击力翻倍
				if (roleVo.z < -300){
					attSpot.attr.minAtt *= 2;
					attSpot.attr.maxAtt *= 2;
				}
			}
			attSpot.attr.attArmor = roleVo.curAttr.attArmor;
			attSpot.attr.iceAtt = roleVo.curAttr.iceAtt;
			attSpot.attr.fireAtt = roleVo.curAttr.fireAtt;
			attSpot.attr.thundAtt = roleVo.curAttr.thundAtt;
			attSpot.attr.toxinAtt = roleVo.curAttr.toxinAtt;
			attSpot.attr.critDmg = roleVo.curAttr.critDmg;
			
			roleVo.jumpInfo[id] = true;
			roleVo.frameName = tableVo.frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			roleVo.curFlyPower = 0;
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			if (roleVo.curFrame == roleVo.roleMc.totalFrames){
				roleVo.attState = RoleState.ATT_NORMAL;
				end();
			}else {
				if (roleVo.roleMc.label != null){
					var toState:int = SkillTable.FRAME_TO_STATE[roleVo.roleMc.label];
					if (roleVo.attState != toState){
						roleVo.attState = toState;
						if (toState == RoleState.ATT_AFTER){
							roleVo.setSkillComboTime(tableVo.skillComboTime); // 30帧以内可以出下一招
							roleVo.reAction();
						}
					}
				}
				
				if (roleVo.roleMc.label == "att2"){
					attSpot.isFly = true;
					attSpot.x = 300;
					attSpot.xFrame = 4;
					attSpot.z = -30;
					attSpot.upY = 40;
					attSpot.downY = 40;
					attSpot.stiffDecline = 0.2;
					attSpot.zDecline = 0.2;
					attSpot.attDecline = 0.3;
					attSpot.armorDecline = 0.3;
					attSpot.attr.minAtt = 1;
					attSpot.attr.maxAtt = 1;
					attSpot.attr.attArmor = 1;
					attSpot.stiffFrame = 45;
					attSpot.curAttSpot = 1;
					attSpot.range = 8;
					attSpot.minBounceZ = 0;
					attSpot.canTurn = false;
				}
				
				roleVo.curFrame ++;
			}
			
			super.run();
		}
	}
}