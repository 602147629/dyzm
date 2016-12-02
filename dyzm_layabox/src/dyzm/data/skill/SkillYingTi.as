package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.role.RoleVo;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	
	public class SkillYingTi extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "鹰踢";
		
		/**
		 * 技能信息
		 */
		public static var tableVo:SkillTableVo;
		
		public const speedX:Number = 25;
		public const speedZ:Number = 20;
		
		public var addX:Number = 0;
		
		public static function getTableVo():SkillTableVo
		{
			if (tableVo == null){
				tableVo = new SkillTableVo();
				tableVo.id = id;
				tableVo.cls = SkillST;
				tableVo.name = "鹰踢"; 
				tableVo.info = "空中快速向前下方踢击";
				tableVo.xi = SkillTable.XI_TI;
				tableVo.startState = SkillTable.SKY;
				tableVo.frameName = "鹰踢";
				tableVo.needGold = 50;
				tableVo.needDay = 1;
				tableVo.up1Name = "酸性恶臭";
				tableVo.up1Info = "踢中目标头部时,破甲翻倍";
				tableVo.up1Gold = 200;
				tableVo.up1Day = 4;
				tableVo.up2Name = "撩阴腿";
				tableVo.up2Info = "可以踢中已倒地的目标";
				tableVo.up2Gold = 200;
				tableVo.up2Day = 4;
				tableVo.canCancelAfter = [SkillKZPG.id, SkillSLT.id, SkillDFC.id, SkillSLZ.id];
				tableVo.skillComboTime = 0;
			}
			return tableVo;
		}
		
		public function SkillYingTi()
		{
			super();
			
			attSpot.isFly = false;
			attSpot.x = 300;
			attSpot.xFrame = 10;
			attSpot.z = -25;
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
			attSpot.byList = AttInfo.BY1;
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
			if (roleVo.z > -200){
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
			
			roleVo.frameName = tableVo.frameName;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_BEFORE;
			addX = 0;
			if (type == 2){//撩阴腿, 可以踢中已倒地的目标
				attSpot.byList = AttInfo.BY1AND2;
			}
			if (roleVo.curTurn == 1){
				if (roleVo.curDir == 9 || roleVo.curDir == 6 || roleVo.curDir == 3){
					if (roleVo.isRuning){
						addX = 10;
					}else{
						addX = 5;
					}
				}
			}else{
				if (roleVo.curDir == 7 || roleVo.curDir == 4 || roleVo.curDir == 1){
					if (roleVo.isRuning){
						addX = 10;
					}else{
						addX = 5;
					}
				}
			}
			
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			if (roleVo.roleMc.totalFrames == roleVo.curFrame){ // 动作完成
				roleVo.attState = RoleState.ATT_NORMAL;
				roleVo.curState = RoleState.STATE_NORMAL;
				end();
			}else{
				if(roleVo.roleMc.label){
					// 更新当前攻击状态
					roleVo.attState = SkillTable.FRAME_TO_STATE[roleVo.roleMc.label];
				}
				
				// 攻击中
				if (roleVo.attState == RoleState.ATT_ING){ // 45度向下冲击
					roleVo.z += speedZ;
					if (roleVo.z >= 0){ // 落地,进入该技能的耍帅动作
						roleVo.curFrame ++;
						roleVo.x += (speedX + addX - roleVo.z) * roleVo.curTurn;
						roleVo.curState = RoleState.STATE_NORMAL;
						roleVo.attState = RoleState.ATT_AFTER;
						roleVo.setSkillComboTime(tableVo.skillComboTime);
						roleVo.inFlood();
						roleVo.reAction();
					}else{
						roleVo.x += (speedX + addX) * roleVo.curTurn;
					}
				}else{
					roleVo.curFrame ++;
				}
			}
			super.run();
		}
		
		override public function hit(b:int, foeRole:RoleVo):void
		{
			if (b==0 && type == 1){ //酸性恶臭,踢中目标头部时,破甲翻倍
				attSpot.attr.attArmor = roleVo.curAttr.attArmor * 2;
			}
		}
	}
}