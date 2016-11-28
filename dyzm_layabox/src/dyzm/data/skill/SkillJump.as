package dyzm.data.skill
{
	import dyzm.data.FightData;
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.WorldData;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Evt;
	
	import laya.maths.Point;
	import laya.maths.Rectangle;
	
	public class SkillJump extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "跳";
		/**
		 * 名称
		 */
		public static const name:String = "跳";
		
		/**
		 * 所属系
		 */
		public static const xi:int = SkillData.XI_JIAN;
		
		/**
		 * 启动状态
		 */
		public static const startState:int = SkillData.FLOOR;
		
		/**
		 * 帧名称
		 */
		public static const frameName:String = "跳";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = ["剑1", "剑2", "剑3", "裂空斩", "上挑"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 0;
		
		public function SkillJump()
		{
			super();
			attSpot.isFly = false;
			attSpot.x = 300;
			attSpot.xFrame = 10;
			attSpot.z = -20;
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
			attSpot.byList = [AttInfo.BY_ATT_FELL];
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
			if (roleVo.attState == RoleState.ATT_AFTER_CANCEL || roleVo.attState == RoleState.ATT_NORMAL){
				return true;
			}
			if (roleVo.attState == RoleState.ATT_AFTER){
				for each (var id:String in CAN_CANCEL_AFTER) 
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
			roleVo.z = roleVo.curAttr.jumpPower;
			roleVo.curFlyPower = roleVo.curAttr.jumpPower - WorldData.G;
			
			roleVo.curState = RoleState.STATE_AIR;
			roleVo.attState = RoleState.ATT_NORMAL;
			roleVo.frameName = RoleVo.TAG_JUMP;
			roleVo.curFrame = 1;
			roleVo.curSkill = null;
			roleVo.jumpSkill = this;
			
			if (type == 1){
				roleVo.setInvincibleFrame(10); 
			}
			super.start();
		}
		
		override public function end():void
		{
			attSpot.attr.minAtt = roleVo.curAttr.minAtt;
			attSpot.attr.maxAtt = roleVo.curAttr.maxAtt;
			attSpot.attr.attArmor = roleVo.curAttr.attArmor;
			attSpot.attr.iceAtt = roleVo.curAttr.iceAtt;
			attSpot.attr.fireAtt = roleVo.curAttr.fireAtt;
			attSpot.attr.thundAtt = roleVo.curAttr.thundAtt;
			attSpot.attr.toxinAtt = roleVo.curAttr.toxinAtt;
			attSpot.attr.critDmg = roleVo.curAttr.critDmg;
			
			var curAttSpot:int = 1;
			var myTeam:int = roleVo.team;
			var foeTeamIdList:Array = FightData.teamToFoe[myTeam]; // 我的敌方队伍
			var foeTeamList:Array;
			var foeRole:RoleVo;
			var a:int = 0;
			var b:int = 0;
			var att:Array;
			var by:Array;
			var focusRect:Rectangle;
			if (type == 2){
				arrayToMainLayerRect([-100, -100, 200, 200], roleVo, ATT_TEMP);
				for (var i:int = 0; i < foeTeamIdList.length; i++) // 循环执行所有的队伍
				{
					foeTeamList = FightData.team[foeTeamIdList[i]];
					
					for (var j:int = 0; j < foeTeamList.length; j++) // 循环执行所有队伍里的玩家
					{
						foeRole = foeTeamList[j];
						if (foeRole.curInvincibleFrame <= 0 && roleVo.y - foeRole.y < attSpot.upY && foeRole.y - roleVo.y < attSpot.downY){ // 判断对方,不在无敌状态并且在Y轴攻击范围内
							//判断是否有打到过对方
							var isHitAgain:Boolean = false;
							for each (var r:RoleVo in attInfo[curAttSpot]){
								if (r == foeRole){
									isHitAgain = true;
									break;
								}
							}
							if (isHitAgain == false){ // 这个招式没有打到过对方
								for each (var byAtt:int in attSpot.byList) // 循环执行该技能可以攻击的被攻击块
								{
									b = 0;
									while(true){ // 循环获取对方的被攻击块
										by = null;
										if (foeRole.roleMc.by && foeRole.roleMc.by[byAtt]){
											by = foeRole.roleMc.by[byAtt][b];
										}
										if(by){
											arrayToMainLayerRect(by, foeRole, BY_TEMP);
											focusRect = ATT_TEMP.intersection(BY_TEMP, Rectangle.TEMP);
											if (focusRect){ // 攻击到
												hit(b, foeRole);
												if (needRange){
													needRange = false;
													Evt.event(RoleVo.RANGE_EVENT, [attSpot.range, false]);
												}
												if (attInfo[curAttSpot]){
													attInfo[curAttSpot].push(foeRole);
												}else{
													attInfo[curAttSpot] = [foeRole];
												}
												// 火花处理
												var firePoint:Point = Point.TEMP;
												firePoint.x = focusRect.x + focusRect.width/2;
												firePoint.y = focusRect.y + focusRect.height/2;
												if(foeRole.byHit(roleVo, this, attSpot.curAttSpot, firePoint, b)){
													roleVo.addHit(foeRole);
												}
												break;
											}
											b ++;
										}else{
											break;
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}


