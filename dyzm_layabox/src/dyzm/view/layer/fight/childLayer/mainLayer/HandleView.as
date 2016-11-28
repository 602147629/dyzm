/**
 * 按键管理
 */
package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.data.PlayerKeyData;
	import dyzm.manager.Evt;
	
	import laya.events.Event;
	
	public class HandleView
	{
		public static const DIR_KEY_DOWN_EVNET:String = "DIR_KEY_DOWN_EVNET";
		public static const DIR_KEY_UP_EVNET:String = "DIR_KEY_UP_EVNET";
		
		public static const SKILL_KEY_DOWN_EVNET:String = "SKILL_KEY_DOWN_EVNET";
		public static const SKILL_KEY_UP_EVNET:String = "SKILL_KEY_UP_EVNET";
		private var _role:PlayerRole;
		
		private var curDir:int = 5;
		
		private var isDown:Boolean = false;
		private var isUp:Boolean = false;
		private var isLeft:Boolean = false;
		private var isRight:Boolean = false;
		private var isRuning:Boolean = false;
		
		private var upTime:Number = 0;
		private var downTime:Number = 0;
		private var leftTime:Number = 0;
		private var rightTime:Number = 0;
		
		public static var skillKeyDownInfo:Object;
		
		public function HandleView()
		{
			skillKeyDownInfo = {};
			for (var i:int = 1; i <= 6; i++) 
			{
				skillKeyDownInfo[i] = false;
			}
		}
		
		public function start(role:PlayerRole):void
		{
			_role = role;
			Laya.stage.on(Event.KEY_DOWN, this, onKeyDown);
			Laya.stage.on(Event.KEY_UP, this, onKeyUp);
		}
		
		private function onKeyDown(e:*=null):void
		{
			var skillId:int = 0;
			switch(e.keyCode)
			{
				case PlayerKeyData.up:
				case PlayerKeyData.down:
				case PlayerKeyData.left:
				case PlayerKeyData.right:
				{
					// 进行方向处理
					handleDirDown(e.keyCode);
					break;
				}
				case PlayerKeyData.skill_1:_role.setSkill(1);skillId=1;break;
				case PlayerKeyData.skill_2:_role.setSkill(2);skillId=2;break;
				case PlayerKeyData.skill_3:_role.setSkill(3);skillId=3;break;
				case PlayerKeyData.skill_4:_role.setSkill(4);skillId=4;break;
				case PlayerKeyData.skill_5:_role.setSkill(5);skillId=5;break;
				case PlayerKeyData.skill_6:_role.setSkill(6);skillId=6;break;
				default:
				{
					break;
				}
			}
			if (skillId != 0){
				if (!skillKeyDownInfo[skillId])
				{
					skillKeyDownInfo[skillId] = true;
					Evt.event(SKILL_KEY_DOWN_EVNET, skillId);
				}
			}
		}
		
		private function onKeyUp(e:*=null):void
		{
			var skillId:int = 0;
			switch(e.keyCode)
			{
				case PlayerKeyData.up:
				case PlayerKeyData.down:
				case PlayerKeyData.left:
				case PlayerKeyData.right:
				{
					// 进行方向处理
					handleDirUp(e.keyCode);
					break;
				}
				case PlayerKeyData.skill_1:skillId=1;break;
				case PlayerKeyData.skill_2:skillId=2;break;
				case PlayerKeyData.skill_3:skillId=3;break;
				case PlayerKeyData.skill_4:skillId=4;break;
				case PlayerKeyData.skill_5:skillId=5;break;
				case PlayerKeyData.skill_6:skillId=6;break;
				default:
				{
					break;
				}
			}
			if (skillId != 0){
				if (skillKeyDownInfo[skillId])
				{
					skillKeyDownInfo[skillId] = false;
					Evt.event(SKILL_KEY_UP_EVNET, skillId);
				}
			}
		}
		
		
		/**
		 * 方向处理
		 * @param keyCode
		 */		
		private function handleDirDown(keyCode:int):void
		{
			var oldDir:int = curDir;
			var run:Boolean = false;
			switch(keyCode)
			{
				case PlayerKeyData.up:
				{
					if (!isRuning){
						if (Laya.timer.currTimer - upTime < 300){
							run = true;
						}
					}
					if (!isUp){
						isUp = true;
						upTime = Laya.timer.currTimer;
						Evt.event(DIR_KEY_DOWN_EVNET, "up");
						switch(oldDir)
						{
							case 1: curDir = 7; break;
							case 2: curDir = 8; break;
							case 3: curDir = 9; break;
							case 4: curDir = 7; break;
							case 5: curDir = 8; break;
							case 6: curDir = 9; break;
							case 7: break;
							case 8: break;
							case 9: break;
						}
					}
					break;
				}
				case PlayerKeyData.down:
				{
					if (!isRuning){
						if (Laya.timer.currTimer - downTime < 300){
							run = true;
						}
					}
					if (!isDown){
						Evt.event(DIR_KEY_DOWN_EVNET, "down");
						isDown = true;
						downTime = Laya.timer.currTimer;
						switch(oldDir)
						{
							case 1: break;
							case 2: break;
							case 3: break;
							case 4: curDir = 1; break;
							case 5: curDir = 2; break;
							case 6: curDir = 3; break;
							case 7: curDir = 1; break;
							case 8: curDir = 2; break;
							case 9: curDir = 3; break;
						}
					}
					break;
				}
				case PlayerKeyData.left:
				{
					if (!isRuning){
						if (Laya.timer.currTimer - leftTime < 300){
							run = true;
						}
					}
					if (!isLeft){
						Evt.event(DIR_KEY_DOWN_EVNET, "left");
						isLeft = true;
						leftTime = Laya.timer.currTimer;
						switch(oldDir)
						{
							
							case 1: break;
							case 2: curDir = 1; break;
							case 3: curDir = 1; break;
							case 4: break;
							case 5: curDir = 4; break;
							case 6: curDir = 4; break;
							case 7: break;
							case 8: curDir = 7; break;
							case 9: curDir = 7; break;
						}
						
					}
					break;
				}
				case PlayerKeyData.right:
				{
					if (!isRuning){
						if (Laya.timer.currTimer - rightTime < 300){
							run = true;
						}
					}
					if (!isRight){
						Evt.event(DIR_KEY_DOWN_EVNET, "right");
						isRight = true;
						rightTime = Laya.timer.currTimer;
						switch(oldDir)
						{
							case 1: curDir = 3; break;
							case 2: curDir = 3; break;
							case 3: break;
							case 4: curDir = 6; break;
							case 5: curDir = 6; break;
							case 6: break;
							case 7: curDir = 9; break;
							case 8: curDir = 9; break;
							case 9: break;
						}
					}
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			if (curDir != oldDir){
				_role.setDir(curDir);
			}
			
			if (run && !isRuning){
				isRuning = true;
				_role.setRun(true);
			}
		}
		
		
		private function handleDirUp(keyCode:int):void
		{
			var oldDir:int = curDir;
			switch(keyCode)
			{
				case PlayerKeyData.up:
				{
					if (isUp){
						Evt.event(DIR_KEY_UP_EVNET, "up");
						isUp = false;
						switch(oldDir)
						{
							case 1: break;
							case 2: break;
							case 3: break;
							case 4: break;
							case 5: break;
							case 6: break;
							case 7: if (isDown){curDir = 1}else{curDir = 4}; break;
							case 8: if (isDown){curDir = 2}else{curDir = 5}; break;
							case 9: if (isDown){curDir = 3}else{curDir = 6}; break;
						}
					}
					break;
				}
				case PlayerKeyData.down:
				{
					if (isDown){
						Evt.event(DIR_KEY_UP_EVNET, "down");
						isDown = false;
						switch(oldDir)
						{
							case 1: if (isUp){curDir = 7}else{curDir = 4}; break;
							case 2: if (isUp){curDir = 8}else{curDir = 5}; break;
							case 3: if (isUp){curDir = 9}else{curDir = 6}; break;
							case 4: break;
							case 5: break;
							case 6: break;
							case 7: break;
							case 8: break;
							case 9: break;
						}
					}
					break;
				}
				case PlayerKeyData.left:
				{
					if (isLeft){
						Evt.event(DIR_KEY_UP_EVNET, "left");
						isLeft = false;
						switch(oldDir)
						{
							case 1: if (isRight){curDir = 3}else{curDir = 2};break;
							case 2: break;
							case 3: break;
							case 4: if (isRight){curDir = 6}else{curDir = 5};break;
							case 5: break;
							case 6: break;
							case 7: if (isRight){curDir = 9}else{curDir = 8};break;
							case 8: break;
							case 9: break;
						}
					}
					break;
				}
				case PlayerKeyData.right:
				{
					if (isRight){
						Evt.event(DIR_KEY_UP_EVNET, "right");
						isRight = false;
						switch(oldDir)
						{
							case 1: break;
							case 2: break;
							case 3: if (isLeft){curDir = 1}else{curDir = 2}; break;
							case 4: break;
							case 5: break;
							case 6: if (isLeft){curDir = 4}else{curDir = 5}; break;
							case 7: break;
							case 8: break;
							case 9: if (isLeft){curDir = 7}else{curDir = 8}; break;
						}
					}
					break;
				}
					
				default:
				{
					break;
				}
			}
			if (curDir != oldDir){
				_role.setDir(curDir);
			}
			
			if (curDir == 5 && isRuning){
				isRuning = false;
				_role.setRun(false);
			}
		}
	}
} 