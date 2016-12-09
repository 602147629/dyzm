package dyzm.data.skill
{
	import dyzm.data.FightData;
	import dyzm.data.RoleState;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Cfg;
	import dyzm.manager.Evt;
	
	import laya.maths.Point;
	import laya.maths.Rectangle;
	
	/**
	 * 技能基类
	 * 当人物交由技能类控制时,技能类将完全控制该人物
	 * @author dj
	 */
	public class BaseSkillVo
	{
		public var keyId:int;
		
		protected var _type:int;
		
		/**
		 * 当前技能使用者
		 */
		public var roleVo:RoleVo;
		
		/**
		 * 当前攻击点
		 */
		public var attSpot:AttInfo;
		
		/**
		 * 攻击信息,记录该招式打到了谁
		 */
		public var attInfo:Object;
		
		/**
		 * 是否需要打击感震动
		 */
		public var needRange:Boolean;
		
		protected static const ATT_TEMP:Rectangle =/*[STATIC SAFE]*/ new Rectangle();
		
		protected static const BY_TEMP:Rectangle =/*[STATIC SAFE]*/ new Rectangle();
		
		public function BaseSkillVo()
		{
			keyId = Cfg.getKeyId();
			attSpot = new AttInfo();
		}
		
		
		/**
		 * 技能检测
		 * @return ture=可以释放
		 */
		public function startTest():Boolean
		{
			return true;
		}
		
		/**
		 * 技能开始
		 */
		public function start():void
		{
			attInfo = {};
			needRange = true;
		}
		
		/**
		 * 技能进行中,每帧调用
		 */
		public function run():void
		{
			handleAtt();
		}
		
		/**
		 * 技能结束
		 */
		public function end():void
		{
			roleVo.attState = RoleState.ATT_NORMAL;
			roleVo.curSkill = null;
			roleVo.reAction();
		}
		
		/**
		 * 攻击到对方时调用
		 */
		public function hit(b:int, foeRole:RoleVo):void
		{
			
		}
		
		/**
		 * 处理攻击
		 */
		public function handleAtt(curAttSpot:int = -1):void
		{
			if (curAttSpot == -1){
				curAttSpot = attSpot.curAttSpot;
			}
			var a:int = 0;
			var b:int = 0;
			var att:Array;
			var by:Array;
			var focusRect:Rectangle;
			var myTeam:int = roleVo.team;
			var foeTeamIdList:Array = FightData.teamToFoe[myTeam]; // 我的敌方队伍
			var foeTeamList:Array;
			var foeRole:RoleVo;
			while(true){ // 循环执行所有的攻击块
				att = null;
				if (roleVo.roleMc.att && roleVo.roleMc.att[attSpot.curAttSpot]){
					att = roleVo.roleMc.att[attSpot.curAttSpot][a];
				}
				if (att){
					arrayToMainLayerRect(att, roleVo, ATT_TEMP);
					for (var i:int = 0; i < foeTeamIdList.length; i++) // 循环执行所有的队伍
					{
						foeTeamList = FightData.team[foeTeamIdList[i]];
						
						for (var j:int = 0; j < foeTeamList.length; j++) // 循环执行所有队伍里的玩家
						{
							foeRole = foeTeamList[j];
							if (!foeRole.isInvincible() && roleVo.y - foeRole.y < attSpot.upY && foeRole.y - roleVo.y < attSpot.downY){ // 判断对方,不在无敌状态并且在Y轴攻击范围内
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
													if(foeRole.byHit(roleVo, this, attSpot.curAttSpot, firePoint, b, attSpot.toBuff)){
														roleVo.addHit(foeRole);
														// 击中对方,给自己加buff
														if (attSpot.fromBuff){
															for (var k:int = 0; k < attSpot.fromBuff.length; k++) 
															{
																roleVo.addBuff(foeRole, attSpot.fromBuff[k]);
															}
														}
													}
													return;
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
					a ++;
				}else{
					break;
				}
			}
		}
		
		protected function arrayToMainLayerRect(arr:Array, role:RoleVo, rect:Rectangle):void
		{
			rect.x = role.x + arr[0] * role.curTurn + (role.curTurn == 1 ? 0 : -rect.width);
			rect.y = role.y + role.z + arr[1];
			rect.width = arr[2];
			rect.height = arr[3];
		}

		/**
		 * 当前技能类型,-1=没学会,0=已经学会,1=开启1号升级,2=开启2号升级
		 */
		public function get type():int
		{
			return _type;
		}

		/**
		 * @private
		 */
		public function set type(value:int):void
		{
			_type = value;
		}

	}
}