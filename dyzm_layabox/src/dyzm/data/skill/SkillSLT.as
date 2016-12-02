package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.WorldData;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	
	public class SkillSLT extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "升龙踢";
		/**
		 * 技能信息
		 */
		public static var tableVo:SkillTableVo;
		
		/**
		 * 该技能出招时的位移效果
		 */
		public const speedZ:Number = -28;
		public const speedX:int = 0;
		public const stopX:int = 0;
		public const addX:int = 12;
		public var curSpeedX:int = 0;
		
		public var uping:Boolean = false;
		
		public static function getTableVo():SkillTableVo
		{
			if (tableVo == null){
				tableVo = new SkillTableVo();
				tableVo.id = id;
				tableVo.cls = SkillSLT;
				tableVo.name = "升龙踢"; 
				tableVo.info = "空中踢技,攻击目标的同时可继续向上跳跃一段距离";
				tableVo.xi = SkillTable.XI_TI;
				tableVo.startState = SkillTable.SKY;
				tableVo.frameName = "升龙踢";
				tableVo.needGold = 50;
				tableVo.needDay = 1;
				tableVo.up1Name = "伤害";
				tableVo.up1Info = "攻击力+1";
				tableVo.up1Gold = 200;
				tableVo.up1Day = 4;
				tableVo.up2Name = "致命";
				tableVo.up2Info = "暴击伤害+3";
				tableVo.up2Gold = 200;
				tableVo.up2Day = 4;
				tableVo.canCancelAfter = [SkillKZPG.id, SkillSLZ.id, SkillDFC.id];
				tableVo.skillComboTime = 0;
			}
			return tableVo;
		}
		
		public function SkillSLT()
		{
			super();
			
			attSpot.isFly = true;
			attSpot.x = 300;
			attSpot.xFrame = 1;
			attSpot.z = -30;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0;
			attSpot.zDecline = 0;
			attSpot.attDecline = 0;
			attSpot.armorDecline = 0;
			attSpot.stiffFrame = 45;
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
			if (roleVo.jumpInfo[SkillSLT.id] != null){
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
			
			if (type == 1){
				attSpot.attr.minAtt += 1;
				attSpot.attr.maxAtt += 1;
			}else if (type == 2){
				attSpot.attr.critDmg += 3;
			}
			
			roleVo.jumpInfo[id] = true;
			roleVo.frameName = tableVo.frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			uping = false;
			// 火花角度
			attSpot.attFireRotation = 10;
			if (roleVo.curDir == 2 || roleVo.curDir == 5 || roleVo.curDir == 8){
				if (roleVo.curTurn == 1){
					curSpeedX = speedX;
				}else{
					curSpeedX = -speedX;
				}
			}else if (roleVo.curDir == 9 || roleVo.curDir == 6 || roleVo.curDir == 3){
				if (roleVo.curTurn == 1){
					// 火花角度
					attSpot.attFireRotation = 60;
					curSpeedX = addX;
				}else{
					curSpeedX = -stopX;
				}
			}else if (roleVo.curDir == 7 || roleVo.curDir == 4 || roleVo.curDir == 1){
				if (roleVo.curTurn == 1){
					curSpeedX = stopX;
				}else{
					// 火花角度
					attSpot.attFireRotation = 60;
					curSpeedX = -addX;
				}
			}
			attSpot.xFrame = Math.abs(curSpeedX);
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
			}else{
				// 更新当前攻击状态
				if (roleVo.roleMc.label){
					var toState:int = SkillTable.FRAME_TO_STATE[roleVo.roleMc.label];
					if (roleVo.attState != toState){
						roleVo.attState = toState;
						if (toState == RoleState.ATT_ING){
							roleVo.curFlyPower = speedZ;
							roleVo.curState = RoleState.STATE_AIR;
							uping = true;
						}else if (toState == RoleState.ATT_AFTER){
							roleVo.setSkillComboTime(tableVo.skillComboTime); // 30帧以内可以出下一招
							roleVo.reAction();
						}
					}
				}
				if (uping){
					roleVo.x += curSpeedX;
					// 直线向上
					roleVo.z += roleVo.curFlyPower;
					roleVo.curFlyPower -= WorldData.G;
				}
				
				if (roleVo.roleMc.label != "att2"){
					roleVo.curFrame ++;
				}else if (roleVo.curFlyPower > 0 || uping == false){
					roleVo.curFrame ++;
				}
			}
			
			super.run();
		}
	}
}