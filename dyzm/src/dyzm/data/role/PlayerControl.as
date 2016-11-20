package dyzm.data.role
{
	import dyzm.data.RoleState;
	import dyzm.data.skill.BaseSkillVo;
	import dyzm.view.layer.fight.childLayer.mainLayer.HandleView;

	public class PlayerControl extends RoleVo
	{
		public var keyToSkill:KeyToSkillVo;
		
		public function PlayerControl()
		{
			keyToSkill = new KeyToSkillVo(this);
			super();
		}
		
		override public function reAction():void
		{
			super.reAction();
			if (attState == RoleState.ATT_NORMAL || attState == RoleState.ATT_AFTER_CANCEL){ //如果在可以打断的后摇中,如果有方向,则执行
				if (curState == RoleState.STATE_NORMAL){
					setDir(curDir);
				}
			}
		}
		
		/**
		 * 设置方向
		 * @param isRun
		 */
		public function setDir(dir:int):void
		{
			curDir = dir;
			if (curState != RoleState.STATE_NORMAL && curState != RoleState.STATE_AIR) return;
			if (isBlock == true) return;
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
			
			if (attState == RoleState.ATT_AFTER_CANCEL){
				attState = RoleState.ATT_NORMAL;
				curSkill = null;
			}
			if (attState == RoleState.ATT_NORMAL && curState == RoleState.STATE_NORMAL){
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
			
			var mx:Number = curAttr.moveSpeed;
			if (isRuning){
				mx = curAttr.runSpeed;
			}
			var my:Number = mx / 2;
			
			if (dir == 7 || dir == 8 || dir == 9){ // 上
				curMoveSpeedY = -my;
			}else if (dir == 1 || dir == 2 || dir == 3){ // 下
				curMoveSpeedY = my;
			}
			
			if (dir == 1 || dir == 4 || dir == 7){ // 左
				if (curSkill == null || curSkill.attSpot.canTurn){
					curTurn = -1;
				}
				curMoveSpeedX = -mx;
			}else if (dir == 3 || dir == 6 || dir == 9){ // 右
				if (curSkill == null || curSkill.attSpot.canTurn){
					curTurn = 1;
				}
				curMoveSpeedX = mx;
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
		 * 攻击
		 * @param id 快捷键id
		 */
		public function setSkill(id:int):Boolean
		{
			if (isBlock) return false;
			var bindObj:Object;
			var skillObj:Object;
			var curForm:int;
			if (curState == RoleState.STATE_NORMAL && isRuning == false){ // 地面正常状态
				curForm = 1;
				bindObj = keyToSkill.skillFloorBind;
				skillObj = keyToSkill.skillFloorVo;
			}else if (curState == RoleState.STATE_NORMAL && isRuning == true){ // 地面跑步状态
				curForm = 2
				bindObj = keyToSkill.skillRunBind;
				skillObj = keyToSkill.skillRunVo;
				if (bindObj[id] == null){ // 如果跑步状态没有绑定技能,那么使用正常状态的
					curForm = 1;
					bindObj = keyToSkill.skillFloorBind;
					skillObj = keyToSkill.skillFloorVo;
				}
			}else if (curState == RoleState.STATE_AIR){ // 空中状态
				curForm = 3
				bindObj = keyToSkill.skillSkyBind;
				skillObj = keyToSkill.skillSkyVo;
			}else{
				return false;
			}
			
			var c:int = skillCombo;
			if (skillComboAllTime == 0 || skillId != id || curForm != attForm){ //已经过了连招时间或发招不同,不进行连招判断
				c = 0;
			}
			if (bindObj[id] && bindObj[id][c]){
				var skill:BaseSkillVo = skillObj[id][c];
				var isCan:Boolean = skill.startTest();
				if (isCan){ // 检测通过,该技能可以释放
					if (skillComboAllTime == 0 || skillId != id || curForm != attForm){
						skillCombo = 0;
					}
					curSkill = skill;
					curSkillClass = bindObj[id][c];
					skillId = id;
					skill.start(); //启动技能
					attForm = curForm;
					return true;
				}
			}
			return false;
		}
		
		override public function frameUpdate():void
		{
			if (isBlock && !HandleView.skillKeyDownInfo[keyToSkill.blockId]){
				isBlock = false;
				reAction();
			}
			super.frameUpdate();
		}
		
		
	}
}