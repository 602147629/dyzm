package dyzm.data.role
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import dyzm.data.FightData;
	import dyzm.data.RoleState;
	import dyzm.data.WorldData;
	import dyzm.data.attr.AttrVo;
	import dyzm.data.skill.BaseSkillVo;
	import dyzm.data.skill.ByAttInfo;
	import dyzm.manager.EventManager;
	
	public class RoleVo
	{
		/**
		 * 动作帧名称
		 */
		public static const TAG_STOOD:String = "站立";
		public static const TAG_MOVE:String = "走";
		public static const TAG_RUN:String = "跑";
		public static const TAG_JUMP:String = "跳";
		public static const TAG_YANG_TIAN:String = "仰天";
		public static const TAG_DI_TOU:String = "低头";
		public static const TAG_FU_KONG:String = "浮空";
		public static const TAG_DAO_DI:String = "倒地";
		public static const TAG_ZHAN_QI:String = "站起";
		
		
		/**
		 * 添加被攻击火花事件
		 */
		public static const ADD_FIRE_EVENT:String = "ADD_FIRE_EVENT";
		
		/**
		 * 删除被攻击火花事件
		 */
		public static const REMOVE_FIRE_EVENT:String = "REMOVE_FIRE_EVENT";
		
		/**
		 * 震动事件
		 */
		public static const RANGE_EVENT:String = "RANGE_EVENT";
		
		/**
		 * 势力
		 */		
		public var team:int = 0;
		
		/**
		 * 视图显示位置
		 */
		public var x:Number = 0;
		public var y:Number = 0;
		
		/**
		 * 当前跳起的高度,高度命名为Z
		 */
		public var z:Number = 0;
		public var curFlyPower:Number = 0;
		/**
		 * 走路速度 
		 */		
		public var moveSpeedX:Number = 4;
		public var moveSpeedY:Number = 2;
		
		/**
		 * 跑步速度
		 */
		public var runSpeedX:Number = 8;
		public var runSpeedY:Number = 4;
		
		
		/**
		 * 当前速度
		 */
		public var curMoveSpeedX:Number = 0;
		public var curMoveSpeedY:Number = 0;
		
		
		/**
		 * 是否跑步中
		 */
		public var isRuning:Boolean = false;
		
		/**
		 * 起跳力度
		 */
		public var jumpPower:Number = -30;
		
		
		
		/**
		 * 当前受控状态
		 */
		public var curState:int = RoleState.STATE_NORMAL;
		
		/**
		 * 当前攻击状态						<br>
		 * RoleState.ATT_NORMAL				<br>
		 * RoleState.ATT_BEFORE				<br>
		 * RoleState.ATT_ING				<br>
		 * RoleState.ATT_AFTER				<br>
		 * RoleState.ATT_AFTER_CANCEL		<br>
		 */
		public var attState:int = RoleState.ATT_NORMAL;
		
		/**
		 * 当前方向
		 */
		public var curDir:int = 5;
		
		/**
		 * 当前正在释放的技能
		 */
		public var curSkill:BaseSkillVo = null;
		
		/**
		 * 当前正在释放的技能类
		 */
		public var curSkillClass:Class = null;
		
		/**
		 * 当前动作帧名称
		 */
		public var frameName:String = TAG_STOOD;
		
		
		/**
		 * 当前帧,注意,是在帧标签中的帧
		 */
		public var curFrame:int = 1;
		
		/**
		 * 当前人物模型
		 */
		public var roleMc:MovieClip;
		
		/**
		 * 当前朝向,右=1,左=-1
		 */
		public var curTurn:int = 1;
		
		/**
		 * 人物的X轴缩放
		 */
		public var scaleX:Number = 1;
		
		/**
		 * 人物的Y轴缩放
		 */
		public var scaleY:Number = 1;
		
		/**
		 * 技能的第几招
		 */
		public var skillCombo:int = 0;
		
		/**
		 * 后续技能计时
		 */
		public var skillComboTime:int = 0;
		/**
		 * 后续技能计时
		 */
		public var skillComboAllTime:int = 0;
		
		/**
		 * 正在执行的技能ID
		 */
		public var skillId:int = 0;
		
		
		public var byAttInfo:ByAttInfo;
		
		/**
		 * 无敌帧数
		 */
		public var curInvincibleFrame:int = 0;
		
		/**
		 * 连击数记录
		 */
		public var hitsDicr:Dictionary;
		
		/**
		 * 本次被攻击,攻击我的玩家列表
		 */
		public var byAttRoleList:Dictionary;
		
		/**
		 * 最大连击数
		 */
		public var maxCombo:int = 0;
		
		/**
		 * 人物属性
		 */
		public var attr:AttrVo;
		
		public function RoleVo()
		{
			byAttInfo = new ByAttInfo();
			attr = new AttrVo();
		}
		
		
		
		/**
		 * 动作复位, 比如跳跃完毕,技能完毕等时候调用
		 * 通过状态对人物动作进行调整
		 * 该函数不会改变现有状态
		 * 子类覆盖
		 */
		public function reAction():void
		{
			var r:RoleVo;
			if (attState == RoleState.ATT_NORMAL || attState == RoleState.ATT_AFTER_CANCEL){ //如果在可以打断的后摇中,如果有方向,则执行
				if (curState == RoleState.STATE_NORMAL){
					byAttInfo.hitDict = null;
					for (r in byAttRoleList) 
					{
						r.removeHit(this);
					}
				}else if(curState == RoleState.STATE_AIR){
					byAttInfo.hitDict = null;
					for (r in byAttRoleList)
					{
						r.removeHit(this);
					}
					frameName = TAG_JUMP;
					curFrame = 1;
				}
			}
		}
		
		/**
		 * 设置技能的后续技能可出招的时间范围,单位:帧
		 */
		public function setSkillComboTime(time:int):void
		{
			if (time == 0){
				skillId = 0;
				skillCombo = 0;
				skillComboTime = 0;
				skillComboAllTime = 0;
			}else{
				skillCombo ++;
				skillComboTime = 0;
				skillComboAllTime = time;
			}
		}
		
		/**
		 * 被攻击
		 * @param attRole 攻击者
		 * @param skill 攻击技能
		 * @param a		技能段
		 * @param rect	攻击交接范围
		 */
		public function byHit(attRole:RoleVo, skill:BaseSkillVo, a:int, rect:Rectangle, b:int):void
		{
			// 火花处理
			var firePoint:Point = new Point(rect.x + rect.width/2, rect.y + rect.height/2); // 火花全局坐标
			EventManager.dispatchEvent(ADD_FIRE_EVENT, firePoint, skill.attSpot.attFireType, y+1);
			
			EventManager.dispatchEvent(RANGE_EVENT, skill.attSpot.range, false);
			
			// 被攻击记录
			if (byAttInfo.hitDict){
				if (byAttInfo.hitDict[skill]){
					if (byAttInfo.hitDict[skill][skill.attSpot.curAttSpot]){
						byAttInfo.hitDict[skill][skill.attSpot.curAttSpot] ++;
					}else{
						byAttInfo.hitDict[skill][skill.attSpot.curAttSpot] = 1;
					}
				}else{
					byAttInfo.hitDict[skill] = {};
					byAttInfo.hitDict[skill][skill.attSpot.curAttSpot] = 1;
				}
			}else{
				byAttInfo.hitDict = new Dictionary();
				byAttInfo.hitDict[skill] = {};
				byAttInfo.hitDict[skill][skill.attSpot.curAttSpot] = 1;
			}
			
			// 记下本次谁打了我
			if (byAttRoleList){
				byAttRoleList[attRole] = true;
			}else{
				byAttRoleList = new Dictionary();
				byAttRoleList[attRole] = true;
			}
			
			if ((curState == RoleState.STATE_NORMAL || curState == RoleState.STATE_STIFF) && skill.attSpot.isFly == false){ // 地面状态
				var s:int = (byAttInfo.stiffFrame - byAttInfo.curStiffFrame);
				if (s > skill.attSpot.stiffFrame){
					byAttInfo.stiffFrame = s;
				}else{
					byAttInfo.stiffFrame = skill.attSpot.stiffFrame;
				}
				byAttInfo.curStiffFrame = 0;
				curSkill = null;
				curState = RoleState.STATE_STIFF;
				if (b == 1){
					frameName = skill.attSpot.foeActionToHead;
				}else{
					frameName = skill.attSpot.foeAction;
				}
				curFrame = 1;
				byAttInfo.x = (skill.attSpot.x / byAttInfo.stiffFrame) * attRole.curTurn; // 每帧位移量
			}else{ // 浮空状态
				curSkill = null;
				curState = RoleState.STATE_FLY;
				frameName = TAG_FU_KONG;
				curFrame = 1;
				byAttInfo.x = skill.attSpot.xFrame * attRole.curTurn;
				// 处理浮空递减
				var n:Number = byAttInfo.hitDict[skill][skill.attSpot.curAttSpot] - 1;
				n = n * skill.attSpot.zDecline;
				byAttInfo.z = skill.attSpot.z - skill.attSpot.z * n;
			}
			
			curTurn = -attRole.curTurn;
		}
		
		public function addHit(foeRole:RoleVo):void
		{
			if(hitsDicr){
				if(hitsDicr[foeRole]){
					hitsDicr[foeRole] ++;
				}else{
					hitsDicr[foeRole] = 1;
				}
			}else{
				hitsDicr = new Dictionary();
				hitsDicr[foeRole] = 1;
			}
			if (hitsDicr[foeRole] > maxCombo){
				maxCombo = hitsDicr[foeRole];
			}
		}
		
		public function removeHit(foeRole:RoleVo):void
		{
			if (hitsDicr[foeRole] >= maxCombo){
				delete hitsDicr[foeRole];
				var max:int = 0;
				for (var r:RoleVo in hitsDicr){
					if (hitsDicr[r] > max){
						max = hitsDicr[r];
					}
				}
				maxCombo = max;
			}else{
				delete hitsDicr[foeRole];
			}
		}
		/**
		 * 帧率更新
		 */
		public function frameUpdate():void
		{
			if (curInvincibleFrame > 0){
				curInvincibleFrame --;
			}
			if (skillComboAllTime != 0){
				skillComboTime ++;
				if (skillComboTime > skillComboAllTime){
					skillComboTime = 0;
					skillComboAllTime = 0;
				}
			}
			if (curSkill){ // 当前有技能正在释放,进入技能循环,普通状态取消,人物行动状态交给技能控制
				curSkill.run();
				return;
			}
			switch(curState)
			{
				case RoleState.STATE_NORMAL: // 正常状态
				{
					x += curMoveSpeedX;
					y += curMoveSpeedY;
					if (y > FightData.level.bottomY){
						y = FightData.level.bottomY;
					}else if (y < FightData.level.topY){
						y = FightData.level.topY;
					}
					if (roleMc && roleMc.role && roleMc.role.totalFrames == curFrame){
						curFrame = 1;
					}else{
						curFrame ++;
					}
					break;
				}
				case RoleState.STATE_AIR: // 空中状态
				{
					x += curMoveSpeedX;
					y += curMoveSpeedY;
					if (y > FightData.level.bottomY){
						y = FightData.level.bottomY;
					}else if (y < FightData.level.topY){
						y = FightData.level.topY;
					}
					z += curFlyPower;
					
					if (z >= 0){ // 落地
						z = 0;
						curState = RoleState.STATE_NORMAL;
						reAction();
					}else{
						if (roleMc && roleMc.role){
							if (curFlyPower > 0 || roleMc.role.currentFrameLabel != "top" && curFrame < roleMc.role.totalFrames){
								curFrame ++;
							}
						}
						curFlyPower -= WorldData.G;
					}
					break;
				}
				case RoleState.STATE_STIFF: // 硬直状态
				{
					if (byAttInfo.curStiffFrame == byAttInfo.stiffFrame){ // 硬直结束
						curState = RoleState.STATE_NORMAL;
						reAction();
					}else{
						if(byAttInfo.stiffFrame - byAttInfo.curStiffFrame <= 8){
							curFrame = 17 - (byAttInfo.stiffFrame - byAttInfo.curStiffFrame);
						}else{
							x += byAttInfo.x;
							if (roleMc && roleMc.role && roleMc.role.currentFrameLabel != "stop"){
								curFrame ++;
							}
						}
						byAttInfo.curStiffFrame ++;
					}
					break;
				}
					
				case RoleState.STATE_FLY: // 浮空状态
				{
					x += byAttInfo.x;
					z += byAttInfo.z;
					if (z >= 0){ // 落地
						z = 0;
						if (roleMc && roleMc.role && roleMc.role.currentFrame == roleMc.role.totalFrames){ // 倒地动作结束, 进入倒地状态
							curState = RoleState.STATE_FLOOD;
							frameName = TAG_DAO_DI;
							curFrame = 1;
						}else{
							curFrame ++;
						}
					}else{
						if (byAttInfo.z <= 0){ // 上升阶段
							if (roleMc && roleMc.role && roleMc.role.currentFrameLabel != "up"){
								curFrame ++;
							}
						}else{ // 下降阶段
							if (roleMc && roleMc.role){
								roleMc.role.gotoAndStop("down");
								curFrame = roleMc.role.currentFrame;
							}
						}
						byAttInfo.z -= WorldData.G;
					}
					break;
				}
				case RoleState.STATE_FLOOD: // 倒地状态
				{
					if (roleMc && roleMc.role && curFrame == roleMc.role.totalFrames){ // 倒地结束, 进入站起状态
						curState = RoleState.STATE_STAND_UP;
						frameName = TAG_ZHAN_QI;
						curFrame = 1;
					}else{
						curFrame ++;
					}
					break;
				}
				case RoleState.STATE_STAND_UP: // 站起状态
				{
					if (roleMc && roleMc.role && curFrame == roleMc.role.totalFrames){ // 站起结束,设置2秒无敌,进入正常状态
						curState = RoleState.STATE_NORMAL;
						curInvincibleFrame = attr.invincibleFrame;
						reAction();
					}else{
						curFrame ++;
					}
				}
				default:
				{
					break;
				}
			}
		}
	}
}