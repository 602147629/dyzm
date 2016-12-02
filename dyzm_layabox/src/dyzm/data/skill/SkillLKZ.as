package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	
	public class SkillLKZ extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "裂空斩";
		
		/**
		 * 技能信息
		 */
		public static var tableVo:SkillTableVo;
		
		public const speedZ:Number = 30;
		
		public static function getTableVo():SkillTableVo
		{
			if (tableVo == null){
				tableVo = new SkillTableVo();
				tableVo.id = id;
				tableVo.cls = SkillLKZ;
				tableVo.name = "裂空斩"; 
				tableVo.info = "空中垂直向下斩击";
				tableVo.xi = SkillTable.XI_JIAN;
				tableVo.startState = SkillTable.SKY;
				tableVo.frameName = "裂空斩";
				tableVo.needGold = 50;
				tableVo.needDay = 1;
				tableVo.up1Name = "千钧";
				tableVo.up1Info = "距离地面2个身高以上发动此技能时,攻击力翻倍";
				tableVo.up1Gold = 200;
				tableVo.up1Day = 4;
				tableVo.up2Name = "震击";
				tableVo.up2Info = "可以击中已倒地的目标";
				tableVo.up2Gold = 200;
				tableVo.up2Day = 4;
				tableVo.canCancelAfter = [SkillKZPG.id, SkillSLT.id, SkillDFC.id];
				tableVo.skillComboTime = 0;
			}
			return tableVo;
		}
		
		public function SkillLKZ()
		{
			super();
			
			attSpot.isFly = false;
			attSpot.x = 300;
			attSpot.xFrame = 2;
			attSpot.z = 40;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 1;
			attSpot.zDecline = 1;
			attSpot.attDecline = 0;
			attSpot.armorDecline = 0;
			attSpot.stiffFrame = 45;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.minBounceZ = -25;
			attSpot.canTurn = false;
			// 该技能可以攻击到的攻击块
			// 鹰踢可以攻击到已经倒地的玩家
			attSpot.byList = AttInfo.BY1;
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
			
			if (type == 1){
				if (roleVo.z < -300){
					attSpot.attr.minAtt *= 2;
					attSpot.attr.maxAtt *= 2;
				}
			}else if (type == 2){
				attSpot.byList = AttInfo.BY1AND2;
			}
			
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
			// 更新当前攻击状态
			if (roleVo.roleMc.label != null){
				roleVo.attState = SkillTable.FRAME_TO_STATE[roleVo.roleMc.label];
			}
			// 攻击中
			if (roleVo.attState == RoleState.ATT_ING && roleVo.curState != RoleState.STATE_NORMAL){ // 垂直向下冲击
				roleVo.z += speedZ;
				if (roleVo.z >= 0){ // 落地,进入该技能的耍帅动作
					roleVo.curFrame ++;
					roleVo.curState = RoleState.STATE_NORMAL;
					roleVo.setSkillComboTime(tableVo.skillComboTime);
					roleVo.inFlood();
					roleVo.reAction();
				}else if (roleVo.roleMc.label != "att2"){
					roleVo.curFrame ++;
				}
			}else{
				if (roleVo.roleMc.totalFrames == roleVo.curFrame){ // 动作完成
					roleVo.attState = RoleState.ATT_NORMAL;
					roleVo.curState = RoleState.STATE_NORMAL;
					end();
				}else{
					roleVo.curFrame ++;
				}
			}
			
			super.run();
		}
	}
}