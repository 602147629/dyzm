package dyzm.data.skill
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import dyzm.data.FightData;
	import dyzm.data.vo.RoleVo;
	import dyzm.view.layer.fight.childLayer.MainLayer;
	
	/**
	 * 技能基类
	 * 当人物交由技能类控制时,技能类将完全控制该人物
	 * @author dj
	 */
	public class BaseSkillVo
	{
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
		
		public function BaseSkillVo(role:RoleVo)
		{
			roleVo = role;
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
			roleVo.curSkill = null;
			roleVo.reAction();
		}
		
		/**
		 * 处理攻击
		 */
		public function handleAtt():void
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
									for each (var r:RoleVo in attInfo[attSpot.curAttSpot]){
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
													roleVo.addHit(foeRole);
													byRect = by.getBounds(MainLayer.me);
													focusRect = attRect.intersection(byRect);
													if (focusRect.width != 0){ // 攻击到
														if (attInfo[attSpot.curAttSpot]){
															attInfo[attSpot.curAttSpot].push(foeRole);
														}else{
															attInfo[attSpot.curAttSpot] = [foeRole];
														}
														foeRole.byHit(roleVo, this, attSpot.curAttSpot, focusRect, b);
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