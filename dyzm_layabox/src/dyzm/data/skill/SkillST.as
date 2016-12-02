package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.role.RoleVo;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	
	public class SkillST extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "上挑";
		
		/**
		 * 技能信息
		 */
		public static var tableVo:SkillTableVo;
		/**
		 * 该技能出招时的位移效果
		 */
		public const speedX:int = 6;
		public const stopX:int = 3;
		public const addX:int = 10;
		public var curSpeedX:int = 0;
		
		public static function getTableVo():SkillTableVo
		{
			if (tableVo == null){
				tableVo = new SkillTableVo();
				tableVo.id = id;
				tableVo.cls = SkillST;
				tableVo.name = "上挑"; 
				tableVo.info = "将敌方挑飞";
				tableVo.xi = SkillTable.XI_JIAN;
				tableVo.startState = SkillTable.FLOOR;
				tableVo.frameName = "上挑";
				tableVo.needGold = 50;
				tableVo.needDay = 1;
				tableVo.up1Name = "暴击";
				tableVo.up1Info = "暴击伤害+2";
				tableVo.up1Gold = 200;
				tableVo.up1Day = 4;
				tableVo.up2Name = "弱点打击";
				tableVo.up2Info = "对已浮空的目标暴击伤害+4";
				tableVo.up2Gold = 200;
				tableVo.up2Day = 4;
				tableVo.canCancelAfter = [SkillJian1.id, SkillJian2.id, SkillJian3.id, SkillYingTi.id, SkillLKZ.id];
				tableVo.skillComboTime = 0;
			}
			return tableVo;
		}
		
		public function SkillST()
		{
			super();
			
			attSpot.isFly = true;
			attSpot.x = 300;
			attSpot.xFrame = 5;
			attSpot.z = -30;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 1;
			attSpot.zDecline = 1;
			attSpot.attDecline = 0;
			attSpot.armorDecline = 0;
			attSpot.stiffFrame = 45;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.canTurn = false;
			// 该技能可以攻击到的攻击块
			// 鹰踢可以攻击到已经倒地的玩家
			attSpot.byList = [AttInfo.BY_ATT_NORMAL];
			// 攻击火花类型
			attSpot.attFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 防御火花类型
			attSpot.defFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 火花角度
			attSpot.attFireRotation = 205;
			
			attSpot.foeAction = AttInfo.YANG_TIAN;
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
				return false;
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
			
			roleVo.frameName = tableVo.frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			
			if (type == 1){
				attSpot.attr.critDmg += 2;
			}
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			if (roleVo.curFrame == 5){
				if (roleVo.curDir == 2 || roleVo.curDir == 5 || roleVo.curDir == 8){
					if (roleVo.curTurn == 1){
						curSpeedX = speedX;
					}else{
						curSpeedX = -speedX;
					}
				}else if (roleVo.curDir == 9 || roleVo.curDir == 6 || roleVo.curDir == 3){
					if (roleVo.curTurn == 1){
						curSpeedX = addX;
					}else{
						curSpeedX = -stopX;
					}
				}else if (roleVo.curDir == 7 || roleVo.curDir == 4 || roleVo.curDir == 1){
					if (roleVo.curTurn == 1){
						curSpeedX = stopX;
					}else{
						curSpeedX = -addX;
					}
				}
			}
			
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
				roleVo.curFrame ++;
			}
			super.run();
		}
		
		override public function hit(b:int, foeRole:RoleVo):void
		{
			if (type== 2 && (foeRole.curState == RoleState.STATE_AIR || foeRole.curState == RoleState.STATE_FLY)){
				attSpot.attr.critDmg += 4;
			}
		}
	}
}


