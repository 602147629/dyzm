package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	
	public class SkillJian2 extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "剑2";
		/**
		 * 技能信息
		 */
		public static var tableVo:SkillTableVo;
		
		/**
		 * 该技能出招时的位移效果
		 */
		public const speedX:int = 12;
		public const stopX:int = 6;
		public const addX:int = 20;
		public var curSpeedX:int = 0;
		
		public static function getTableVo():SkillTableVo
		{
			if (tableVo == null){
				tableVo = new SkillTableVo();
				tableVo.id = id;
				tableVo.cls = SkillJian2;
				tableVo.name = "普攻二段"; 
				tableVo.info = "剑系普攻第二段攻击";
				tableVo.xi = SkillTable.XI_JIAN;
				tableVo.startState = SkillTable.FLOOR;
				tableVo.frameName = "剑2";
				tableVo.needGold = 50;
				tableVo.needDay = 1;
				tableVo.up1Name = "破甲";
				tableVo.up1Info = "破甲伤害+1";
				tableVo.up1Gold = 100;
				tableVo.up1Day = 2;
				tableVo.up2Name = "伤害";
				tableVo.up2Info = "攻击力+1";
				tableVo.up2Gold = 100;
				tableVo.up2Day = 2;
				tableVo.canCancelAfter = [SkillJian1.id];
				tableVo.skillComboTime = 30;
			}
			return tableVo;
		}
		
		public function SkillJian2()
		{
			super();
			
			attSpot.isFly = false;
			attSpot.x = 300;
			attSpot.xFrame = 5;
			attSpot.z = -20;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0.1;
			attSpot.zDecline = 0.01;
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
			attSpot.attFireRotation = 0;
			
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
			
			if (type == 1){
				attSpot.attr.attArmor += 1;
			}else if(type == 2){
				attSpot.attr.minAtt += 1;
				attSpot.attr.maxAtt += 1;
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
			
			if (roleVo.curFrame >= 5 && roleVo.curFrame <= 21){
				roleVo.x += curSpeedX;
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
	}
}


