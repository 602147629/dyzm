package dyzm.data.vo
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
		 * 当前方向
		 */
		public var curDir:int = 5;
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
		
		public var keyToSkill:KeyToSkillVo;
		
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
		public var invincibleFrame:int = 0;
		
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
			keyToSkill = new KeyToSkillVo(this);
			byAttInfo = new ByAttInfo();
		}
		
		/**
		 * 设置方向
		 * @param isRun
		 */
		public function setDir(dir:int):void
		{
			if (curState != RoleState.STATE_NORMAL && curState != RoleState.STATE_AIR) return;
			curDir = dir;
			curMoveSpeedX = 0;
			curMoveSpeedY = 0;
			
			if (dir == 5){
				isRuning = false;
				if (curState == RoleState.STATE_NORMAL && attState == RoleState.ATT_NORMAL){
					if (frameName != TAG_STOOD){
						frameName = TAG_STOOD;
						curFrame = 1;
					}
					
				}
				return;
			}
			
			var mx:Number = moveSpeedX;
			if (isRuning){
				mx = runSpeedX;
			}
			var my:Number = moveSpeedY;
			if (isRuning){
				my = runSpeedY;
			}
			
			if (dir == 7 || dir == 8 || dir == 9){ // 上
				curMoveSpeedY = -my;
			}else if (dir == 1 || dir == 2 || dir == 3){ // 下
				curMoveSpeedY = my;
			}
			
			if (dir == 1 || dir == 4 || dir == 7){ // 左
				curTurn = -1;
				curMoveSpeedX = -mx;
			}else if (dir == 3 || dir == 6 || dir == 9){ // 右
				curTurn = 1;
				curMoveSpeedX = mx;
			}
			
			if (attState == RoleState.ATT_AFTER_CANCEL){
				attState = RoleState.ATT_NORMAL;
				curSkill = null;
			}else if(attState != RoleState.ATT_NORMAL){
				return;
			}
			
			if (curState == RoleState.STATE_NORMAL){
				if (isRuning){
					if (frameName != TAG_RUN){
						frameName = TAG_RUN;
						curFrame = 1;
					}
				}else{
					if (frameName != TAG_MOVE){
						frameName = TAG_MOVE;
						curFrame = 1;
					}
				}
			}
		}
		
		/**
		 * 设置跑步状态
		 * @param isRun
		 */
		public function setRun(isRun:Boolean):void
		{
			if (curState != RoleState.STATE_NORMAL || attState != RoleState.ATT_NORMAL)
				return;
			
			isRuning = isRun;
			setDir(curDir);
		}
		
		/**
		 * 设置跳跃状态
		 */
		public function setJump():void
		{
			if (curState != RoleState.STATE_NORMAL || attState != RoleState.ATT_NORMAL)
				return;
			
			z = jumpPower;
			curFlyPower = jumpPower - WorldData.G;
			
			curState = RoleState.STATE_AIR;
			
			frameName = TAG_JUMP;
			curFrame = 1;
			
		}
		
		/**
		 * 攻击
		 * @param id 快捷键id
		 */
		public function setSkill(id:int):void
		{
			var bindObj:Object;
			var skillObj:Object;
			if (curState == RoleState.STATE_NORMAL && isRuning == false){ // 地面正常状态
				bindObj = keyToSkill.skillFloorBind;
				skillObj = keyToSkill.skillFloorVo;
			}else if (curState == RoleState.STATE_NORMAL && isRuning == true){ // 地面跑步状态
				bindObj = keyToSkill.skillRunBind;
				skillObj = keyToSkill.skillRunVo;
				
			}else if (curState == RoleState.STATE_AIR){ // 空中状态
				bindObj = keyToSkill.skillSkyBind;
				skillObj = keyToSkill.skillSkyVo;
			}
			
			var c:int = skillCombo;
			if (skillComboAllTime == 0){ // 已经过了连招时间,不进行连招判断
				c = skillCombo = 0;
				skillComboTime = 0;
			}
			
			if (skillId != id){ //发招不同
				c = 0;
			}
			
			if (bindObj[id] && bindObj[id][c]){
				var skill:BaseSkillVo = skillObj[id][c];
				var isCan:Boolean = skill.startTest();
				if (isCan){ // 检测通过,该技能可以释放
					if (skillId != id){
						skillCombo = 0;
					}
					skill.start(); //启动技能
					curSkill = skill;
					curSkillClass = bindObj[id][c];
					skillId = id;
				}
			}
		}
		
		/**
		 * 动作复位, 比如跳跃完毕,技能完毕等时候调用
		 * 通过状态对人物动作进行调整
		 * 该函数不会改变现有状态
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
					setDir(curDir);
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
		public function byHit(attRole:RoleVo, skill:BaseSkillVo, a:int, rect:Rectangle):void
		{
			// 火花处理
			var firePoint:Point = new Point(rect.x + rect.width/2, rect.y + rect.height/2); // 火花全局坐标
			EventManager.dispatchEvent(ADD_FIRE_EVENT, firePoint, skill.attSpot.attFireType, y+1);
			
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
				frameName = skill.attSpot.foeAction;
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
			if (invincibleFrame > 0){
				invincibleFrame --;
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
						if(byAttInfo.stiffFrame - byAttInfo.curStiffFrame <= 4){
							curFrame = 5 + byAttInfo.stiffFrame - byAttInfo.curStiffFrame;
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
					if (roleMc && roleMc.role && roleMc.role.currentFrame == roleMc.role.totalFrames){ // 倒地结束, 进入站起状态
						curState = RoleState.STATE_STAND_UP;
						curFrame = 1;
					}else{
						curFrame ++;
					}
				}
				case RoleState.STATE_STAND_UP: // 站起状态
				{
					if (roleMc && roleMc.role && roleMc.role.currentFrame == roleMc.role.totalFrames){ // 站起结束,设置2秒无敌,进入正常状态
						curState = RoleState.STATE_NORMAL;
						invincibleFrame = 120;
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