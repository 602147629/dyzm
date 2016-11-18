package dyzm.data.role
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	
	import dyzm.data.FightData;
	import dyzm.data.RoleState;
	import dyzm.data.WorldData;
	import dyzm.data.attr.AttrVo;
	import dyzm.data.attr.BaseAttrVo;
	import dyzm.data.skill.BaseSkillVo;
	import dyzm.data.skill.ByAttInfo;
	import dyzm.manager.EventManager;
	import dyzm.util.Maths;
	
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
		public static const TAG_TAN_QI:String = "弹起";
		public static const TAG_DAO_DI:String = "倒地";
		public static const TAG_ZHAN_QI:String = "站起";
		public static const TAG_DOWNING:String = "倒下";
		public static const TAG_DEATH:String = "死亡";
		public static const TAG_BLOCK:String = "格挡";
		
		
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
		 * 人物高度,用于在头上显示血条等
		 */
		public var h:Number = 100;
		
		/**
		 * 当前跳起的高度,高度命名为Z
		 */
		public var z:Number = 0;
		public var curFlyPower:Number = 0;
		
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
		 * 当前正在释放的技能类,用于连续技判断
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
		 * 模型类
		 */
		public var style:Class;
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
		 * 后续技能总时间
		 */
		public var skillComboAllTime:int = 0;
		/**
		 * 攻击形态(1=地面,2=地面跑步,3=空中);
		 */
		public var attForm:int = 1;
		
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
		 * 造成最大连击的人
		 */
		public var maxComboRole:RoleVo;
		
		/**
		 * 人物属性
		 */
		public var attr:AttrVo;
		
		/**
		 * 当前人物属性
		 */
		public var curAttr:BaseAttrVo;
		
		/**
		 * 需要删除该人物时,为true
		 */
		public var needDel:Boolean = false;
		
		/**
		 * 跳到空中时的攻击记录,落地后清空
		 */
		public var jumpInfo:Object = {};
		
		public var isBlock:Boolean = false;
		
		public var comboInfo:Dictionary;
		
		public function RoleVo()
		{
			comboInfo = new Dictionary();
			byAttInfo = new ByAttInfo();
			attr = new AttrVo();
			curAttr = new AttrVo();
		}
		
		public function initAttr(a:AttrVo):void
		{
			attr.add(a);
			curAttr.add(a);
		}
		
		
		
		/**
		 * 动作复位, 比如跳跃完毕,技能完毕等时候调用
		 * 通过状态对人物动作进行调整
		 * 该函数不会改变现有状态
		 * 子类覆盖
		 */
		public function reAction():void
		{
			if(attState == RoleState.ATT_NORMAL && curState == RoleState.STATE_AIR){
				frameName = TAG_JUMP;
				if (curFlyPower < 0){
					curFrame = 5;
				}else{
					curFrame = 21;
				}
			}
		}
		
		/**
		 * 落地, 凡是落到地上,都需要调用该函数
		 */
		public function inFlood():void
		{
			z = 0;
			jumpInfo = {};
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
		public function byHit(attRole:RoleVo, skill:BaseSkillVo, a:int, rect:Rectangle, b:int):Boolean
		{
			// 火花处理
			var firePoint:Point = new Point(rect.x + rect.width/2, rect.y + rect.height/2); // 火花全局坐标
			
			
			if (isBlock){ // 格挡成功
				if (curTurn == 1 && x < attRole.x){
					EventManager.dispatchEvent(ADD_FIRE_EVENT, firePoint, skill.attSpot.defFireType, y+1);
					return false;
				}else if (curTurn == -1 && x > attRole.x){
					EventManager.dispatchEvent(ADD_FIRE_EVENT, firePoint, skill.attSpot.defFireType, y+1);
					return false;
				}
			}
			
			EventManager.dispatchEvent(ADD_FIRE_EVENT, firePoint, skill.attSpot.attFireType, y+1);
			isBlock = false;
			// 重复攻击递减
			var decline:Number = 0;
			if (byAttInfo.hitDict && byAttInfo.hitDict[skill] && byAttInfo.hitDict[skill][skill.attSpot.curAttSpot]){
				decline = byAttInfo.hitDict[skill][skill.attSpot.curAttSpot];
			}
			// 伤害处理
			var att:Number = Maths.random(attRole.curAttr.attMin + skill.attSpot.attr.attMin, attRole.curAttr.attMax + skill.attSpot.attr.attMax); // 计算发挥的攻击力大小
			att = att - att * decline * skill.attSpot.armorDecline; // 计算重复攻击递减
			att = att - curAttr.def; // 计算防御减伤
			var iceAtt:Number = attRole.curAttr.iceAtt + skill.attSpot.attr.iceAtt;
			// 冰攻击
			iceAtt =  iceAtt - iceAtt * decline * skill.attSpot.armorDecline - curAttr.iceDef;
			var fireAtt:Number = attRole.curAttr.fireAtt + skill.attSpot.attr.fireAtt;
			// 火攻击
			fireAtt =  fireAtt - fireAtt * decline * skill.attSpot.armorDecline - curAttr.fireDef;
			// 电攻击
			var thundAtt:Number = attRole.curAttr.thundAtt + skill.attSpot.attr.thundAtt;
			thundAtt =  thundAtt - thundAtt * decline * skill.attSpot.armorDecline - curAttr.thundDef;
			// 毒攻击
			var toxinAtt:Number = attRole.curAttr.toxinAtt + skill.attSpot.attr.toxinAtt;
			toxinAtt =  toxinAtt - toxinAtt * decline * skill.attSpot.armorDecline - curAttr.toxinDef;
			var curAtt:Number = 0;
			if (att > 0){
				curAtt += att;
			}
			if (iceAtt > 0){
				curAtt += iceAtt;
			}
			if (fireAtt > 0){
				curAtt += fireAtt;
			}
			if (thundAtt > 0){
				curAtt += thundAtt;
			}
			if (toxinAtt > 0){
				curAtt += toxinAtt;
			}
			curAtt = curAtt - curAttr.armor; // 计算护甲减伤
			if (Math.random() < curAtt - int(curAtt)){
				curAtt = int(curAtt) + 1;
			}else{
				curAtt = int(curAtt);
			}
			
			// 破甲计算
			curAttr.armor -= attRole.curAttr.attArmor + skill.attSpot.attr.attArmor;
			if (curAttr.armor < 0 ){
				curAttr.armor = 0;
			}
			
			
			if (curAtt > 0){ // 扣血了,可以打断其动作
				// 清理原来动作
				if (attState != RoleState.ATT_NORMAL){
					attState = RoleState.ATT_NORMAL;
					curSkill = null;
				}
				
				curAttr.hp -= curAtt;
				if (curAttr.hp < 0){
					curAttr.hp = 0;
				}
				
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
				
				
				// 表现处理
				if ((curState == RoleState.STATE_NORMAL || curState == RoleState.STATE_STIFF) && skill.attSpot.isFly == false){ // 地面状态
					var stiffDecline:int = skill.attSpot.stiffFrame - skill.attSpot.stiffFrame * decline * skill.attSpot.stiffDecline;
					if (stiffDecline > 0){
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
					}
				}else{ // 浮空状态
					byAttInfo.stiffFrame = 0;
					byAttInfo.curStiffFrame = 0;
					curSkill = null;
					curState = RoleState.STATE_FLY;
					frameName = TAG_FU_KONG;
					curFrame = 1;
					byAttInfo.x = skill.attSpot.xFrame * attRole.curTurn;
					// 处理浮空递减
					byAttInfo.z = skill.attSpot.z - skill.attSpot.z * decline * skill.attSpot.zDecline;
					byAttInfo.minBounceZ = skill.attSpot.minBounceZ - skill.attSpot.minBounceZ * decline * skill.attSpot.zDecline;
				}
				curTurn = -attRole.curTurn;
				return true;
			}
			return false;
		}
		
		public function addHit(foeRole:RoleVo):void
		{
			if (comboInfo[foeRole]){
				comboInfo[foeRole].push(curSkillClass.frameName);
			}else{
				comboInfo[foeRole] = [curSkillClass.frameName];
			}
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
				maxComboRole = foeRole;
			}
		}
		
		public function removeHit(foeRole:RoleVo):void
		{
			delete comboInfo[foeRole];
			if (hitsDicr[foeRole] >= maxCombo){
				delete hitsDicr[foeRole];
				maxCombo = 0;
				for (var r:RoleVo in hitsDicr){
					if (hitsDicr[r] > maxCombo){
						maxCombo = hitsDicr[r];
						maxComboRole = r;
					}
				}
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
			
			if (isBlock){
				return;
			}
			
			var r:RoleVo;
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
					if (roleMc.role.totalFrames == curFrame){
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
						inFlood();
						curState = RoleState.STATE_NORMAL;
						reAction();
					}else{
						if (curFlyPower > 0 || roleMc.role.currentFrameLabel != "top" && curFrame < roleMc.role.totalFrames){
							curFrame ++;
						}
						curFlyPower -= WorldData.G;
					}
					break;
				}
				case RoleState.STATE_STIFF: // 硬直状态
				{
					if (byAttInfo.curStiffFrame == byAttInfo.stiffFrame){ // 硬直结束
						byAttInfo.hitDict = null;
						for (r in byAttRoleList) 
						{
							r.removeHit(this);
						}
						if (curAttr.hp == 0){
							curState = RoleState.STATE_DOWNING;
							frameName = TAG_DOWNING;
							curFrame = 1;
						}else{
							curState = RoleState.STATE_NORMAL;
							reAction();
						}
						curAttr.armor = curAttr.maxArmor;
					}else{
						if(byAttInfo.stiffFrame - byAttInfo.curStiffFrame <= 8){
							curFrame = 17 - (byAttInfo.stiffFrame - byAttInfo.curStiffFrame);
						}else{
							x += byAttInfo.x;
							if (roleMc.role.currentFrameLabel != "stop"){
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
					if (z >= 0){ // 落地反弹
						z = 0;
						curState = RoleState.STATE_BOUNCE;
						frameName = TAG_TAN_QI;
						curFrame = 1;
						byAttInfo.x = byAttInfo.x * 2 / 3; // x轴位移减少1/3
						byAttInfo.z = Math.min(byAttInfo.minBounceZ, -byAttInfo.z / 2); //弹起动力为落地动力的一半
					}else{
						if (byAttInfo.z <= 0){ // 上升阶段
							if (roleMc.role.currentFrameLabel != "up"){
								curFrame ++;
							}
						}else{ // 下降阶段
							if (curFrame < roleMc.role.totalFrames){
								curFrame ++;
							}
						}
						byAttInfo.z -= WorldData.G;
					}
					break;
				}
				case RoleState.STATE_BOUNCE: // 弹起状态
				{
					x += byAttInfo.x;
					z += byAttInfo.z;
					if (z >= 0){ // 落地
						if (byAttInfo.z > 20){ // 如果落地时,冲击力过大,那就需要再弹一次
							byAttInfo.z = -byAttInfo.z / 2;
							curFrame = 1;
							z = 0;
						}else{
							inFlood();
							curState = RoleState.STATE_FLOOD;
							frameName = TAG_DAO_DI;
							curFrame = 1;
						}
					}else{
						if (byAttInfo.z <= 0){ // 上升阶段
							if (roleMc.role.currentFrameLabel != "up"){
								curFrame ++;
							}
						}else{ // 下降阶段
							if (curFrame < roleMc.role.totalFrames){
								curFrame ++;
							}
						}
						byAttInfo.z -= WorldData.G;
					}
					break;
				}
				case RoleState.STATE_FLOOD: // 倒地状态
				{
					if (curFrame == roleMc.role.totalFrames){ // 倒地结束, 进入站起状态或死亡状态
						byAttInfo.hitDict = null;
						for (r in byAttRoleList) 
						{
							r.removeHit(this);
						}
						if (curAttr.hp == 0){
							curState = RoleState.STATE_DEATH;
							frameName = TAG_DEATH;
							curFrame = 1;
						}else{
							curState = RoleState.STATE_STAND_UP;
							frameName = TAG_ZHAN_QI;
							curFrame = 1;
						}
					}else{
						curFrame ++;
					}
					break;
				}
				case RoleState.STATE_STAND_UP: // 站起状态
				{
					if (curFrame == roleMc.role.totalFrames){ // 站起结束,设置2秒无敌,进入正常状态
						curState = RoleState.STATE_NORMAL;
						curInvincibleFrame = attr.invincibleFrame;
						curAttr.armor = curAttr.maxArmor;
						reAction();
					}else{
						curFrame ++;
					}
					break;
				}
				case RoleState.STATE_DOWNING: // 倒下状态
				{
					if (curFrame == roleMc.role.totalFrames){
						curState = RoleState.STATE_FLOOD;
						frameName = TAG_DAO_DI;
						curFrame = 1;
					}else{
						curFrame ++;
					}
					break;
				}
				case RoleState.STATE_DEATH: // 死亡状态
				{
					if (curFrame == roleMc.role.totalFrames){
						needDel = true;
					}else{
						curFrame ++;
					}
					break;
				}
				default:
				{
					break;
				}
			}
		}
	}
}