package dyzm.data.skill
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import dyzm.data.FightData;
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.EventManager;
	import dyzm.view.layer.fight.childLayer.mainLayer.MainLayer;

	public class SkillJianBSJ extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "剑系终结技";
		/**
		 * 名称
		 */
		public static const name:String = "剑系终结技";
		
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
		public static const frameName:String = "剑系终结技";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = ["剑1", "剑2", "剑3", "鹰踢", "裂空斩", "上挑"];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 30;
		
		/**
		 * 该技能出招时的位移效果
		 */
		public const speedX:int = 15;
		public const stopX:int = 5;
		public const addX:int = 20;
		public var curSpeedX:int = 0;
		
		public var actionList:Array;
		public var roleList:Array;
		public var target:RoleVo;
		public var actionIndex:int;
		public var curAttSpot:int;
		public var phase:int;
		
		public function SkillJianBSJ(role:RoleVo)
		{
			super(role);
			// 该技能可以攻击到的攻击块
			// 鹰踢可以攻击到已经倒地的玩家
			attSpot.byList = [AttInfo.BY_ATT_NORMAL, AttInfo.BY_ATT_FELL];
			// 攻击火花类型
			attSpot.attFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			// 防御火花类型
			attSpot.defFireType = AttInfo.FIRE_TYPE_KNIFE;
			
			attSpot.foeAction = AttInfo.YANG_TIAN;
		}
		
		/**
		 * 技能检测, 在通过初步检测后调用,进入进一步判断
		 * 初步检测包括 是否符合技能的释放位置(地面,空中,跑步),并且不在被攻击状态
		 * @return ture=可以释放
		 */
		override public function startTest():Boolean
		{
			
			if (roleVo.maxCombo < 15){
				return false;
			}
			var a:Array = roleVo.comboInfo[roleVo.maxComboRole];
			if (a[a.length-1] == name){
				return false;
			}
			
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
			attSpot.isFly = false;
			attSpot.x = 0;
			attSpot.xFrame = 0;
			attSpot.z = 0;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0;
			attSpot.zDecline = 0;
			attSpot.attDecline = 0;
			attSpot.armorDecline = 0;
			attSpot.stiffFrame = 999;
			attSpot.curAttSpot = 1;
			attSpot.range = 2;
			attSpot.canTurn = false;
			
			target = roleVo.maxComboRole;
			actionList = roleVo.comboInfo[target].concat();
			actionIndex = 0;
			
			roleVo.frameName = actionList[actionIndex++];
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_ING;
			roleVo.curInvincibleFrame = 999999;
			phase = 0;
			
			roleList = [];
			for (var r:RoleVo in roleVo.comboInfo) 
			{
				roleList.push(r);
			}
			super.start();
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		override public function run():void
		{
			var r:RoleVo
			if (phase < 60){ // 放光吸人阶段
				if (phase == 0){
					var tx:int = roleVo.x + roleVo.curTurn * 120;
					for each (r in roleList) 
					{
						r.attState = RoleState.ATT_NORMAL;
						r.byAttInfo.stiffFrame = 999;
						r.byAttInfo.curStiffFrame = 0;
						r.curFrame = 1;
						r.frameName = Math.random() < 0.5 ? RoleVo.TAG_DI_TOU : RoleVo.TAG_YANG_TIAN;
						r.byAttInfo.x = 0;
						r.byAttInfo.z = 0;
						r.curState = RoleState.STATE_STIFF;
						TweenLite.to(r, 1, {x:tx + Math.random() * 20, y:roleVo.y, z:0});
					}
				}
				phase ++;
			}else{
				if (roleVo.frameName == name){ // 必杀阶段
					if (roleVo.roleMc.role.totalFrames == roleVo.curFrame){ // 结束阶段
						roleVo.curInvincibleFrame = 0;
						end();
					}else{
						roleVo.curFrame ++;
						super.run();
					}
				}else{ // 乱打阶段
					for (var i:int = 0; i < 4; i++)
					{
						roleVo.curFrame ++;
						roleVo.roleMc.role.gotoAndStop(roleVo.curFrame);
						if (roleVo.roleMc.role.currentFrameLabel == SkillData.FRAME_AFTER){
							roleVo.frameName = actionList[actionIndex++];
							if (roleVo.frameName == null){
								roleVo.frameName = name;
								attSpot.isFly = true;
								attSpot.x = 300;
								attSpot.xFrame = 30;
								attSpot.z = -20;
								attSpot.upY = 40;
								attSpot.downY = 40;
								attSpot.stiffDecline = 0;
								attSpot.zDecline = 0;
								attSpot.attDecline = 0;
								attSpot.armorDecline = 0;
								attSpot.stiffFrame = 1000;
								attSpot.curAttSpot = 1;
								attSpot.range = 16;
								attSpot.canTurn = false;
								
								attSpot.attr.minAtt = roleVo.curAttr.minAtt * 2 + roleVo.curAttr.minAtt * (roleVo.maxCombo - 30) * 0.2;
								attSpot.attr.maxAtt = roleVo.curAttr.maxAtt * 2 + roleVo.curAttr.minAtt * (roleVo.maxCombo - 30) * 0.2;
								attSpot.attr.attArmor = roleVo.curAttr.attArmor;
								attSpot.attr.iceAtt = roleVo.curAttr.iceAtt;
								attSpot.attr.fireAtt = roleVo.curAttr.fireAtt;
								attSpot.attr.thundAtt = roleVo.curAttr.thundAtt;
								attSpot.attr.toxinAtt = roleVo.curAttr.toxinAtt;
								
								// 火花角度
								attSpot.attFireRotation = 360 * Math.random();
							}
							needRange = true;
							curAttSpot ++;
							roleVo.curFrame = 1;
						}
						super.run();
					}
				}
			}
		}
		
		override public function handleAtt():void
		{
			var a:int = 1;
			var b:int = 1;
			var att:Sprite;
			var attRect:Rectangle;
			var by:Sprite;
			var byRect:Rectangle;
			var focusRect:Rectangle;
			var myTeam:int = roleVo.team;
			var foeTeamIdList:Array = FightData.teamToFoe[myTeam]; // 我的地方队伍
			var foeTeamList:Array;
			var foeRole:RoleVo;
			while(true){ // 循环执行所有的攻击块
				att = roleVo.roleMc.role["att_" + attSpot.curAttSpot + "_" + a];
				if (att){
					attRect = att.getBounds(MainLayer.me);
					for (var i:int = 0; i < foeTeamIdList.length; i++) // 循环执行所有的队伍
					{
						foeTeamList = FightData.team[foeTeamIdList[i]];
						
						for (var j:int = 0; j < foeTeamList.length; j++) // 循环执行所有队伍里的玩家
						{
							foeRole = foeTeamList[j];
							if (foeRole.curInvincibleFrame <= 0 && roleVo.y - foeRole.y < attSpot.upY && foeRole.y - roleVo.y < attSpot.downY){ // 判断对方,不在无敌状态并且在Y轴攻击范围内
								if (foeRole.roleMc && foeRole.roleMc.role){
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
											b = 1;
											while(true){ // 循环获取对方的被攻击块
												by = foeRole.roleMc.role["by_"+byAtt+"_"+b];
												if(by){
													byRect = by.getBounds(MainLayer.me);
													focusRect = attRect.intersection(byRect);
													if (focusRect.width != 0){ // 攻击到
														if (needRange){
															needRange = false;
															EventManager.dispatchEvent(RoleVo.RANGE_EVENT, attSpot.range, false);
														}
														if (attInfo[curAttSpot]){
															attInfo[curAttSpot].push(foeRole);
														}else{
															attInfo[curAttSpot] = [foeRole];
														}
														if (foeRole.byHit(roleVo, this, attSpot.curAttSpot, focusRect, b)){
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
					a ++;
				}else{
					break;
				}
			}
		}
	}
}