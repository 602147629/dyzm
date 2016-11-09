/**
 * 按键管理
 */
package dyzm.view.layer.fight
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	
	import dyzm.data.KeyData;
	import dyzm.view.layer.fight.item.MainRole;
	
	public class HandleView
	{
		private var _stage:Stage;
		private var _role:MainRole;
		
		private var curDir:int = 5;
		
		private var isDown:Boolean = false;
		private var isUp:Boolean = false;
		private var isLeft:Boolean = false;
		private var isRight:Boolean = false;
		private var isRuning:Boolean = false;
		
		private var leftTime:Number = 0;
		private var rightTime:Number = 0;
		
		public function HandleView()
		{
			
		}
		
		public function start(stage:Stage, role:MainRole):void
		{
			_stage = stage;
			_role = role;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case KeyData.up:
				case KeyData.down:
				case KeyData.left:
				case KeyData.right:
				{
					// 进行方向处理
					handleDirDown(e.keyCode);
					break;
				}
				case KeyData.jump:
				{
					_role.setJump();
					break;
				}
				case KeyData.skill_1:_role.setSkill(1);break;
				case KeyData.skill_2:_role.setSkill(2);break;
				case KeyData.skill_3:_role.setSkill(3);break;
				case KeyData.skill_4:_role.setSkill(4);break;
				case KeyData.skill_5:_role.setSkill(5);break;
				case KeyData.skill_6:_role.setSkill(6);break;
				case KeyData.skill_7:_role.setSkill(7);break;
				case KeyData.skill_8:_role.setSkill(8);break;
				default:
				{
					break;
				}
			}
			//			trace("e.keyCode", e.keyCode);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case KeyData.up:
				case KeyData.down:
				case KeyData.left:
				case KeyData.right:
				{
					// 进行方向处理
					handleDirUp(e.keyCode);
					break;
				}
					
				default:
				{
					break;
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
				case KeyData.up:
				{
					if (!isUp){
						isUp = true;
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
				case KeyData.down:
				{
					if (!isDown){
						isDown = true;
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
				case KeyData.left:
				{
					if (!isRuning){
						if (getTimer() - leftTime < 300){
							run = true;
						}
					}
					if (!isLeft){
						isLeft = true;
						leftTime = getTimer();
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
				case KeyData.right:
				{
					if (!isRuning){
						if (getTimer() - rightTime < 300){
							run = true;
						}
					}
					if (!isRight){
						isRight = true;
						rightTime = getTimer();
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
				case KeyData.up:
				{
					if (isUp){
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
				case KeyData.down:
				{
					if (isDown){
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
				case KeyData.left:
				{
					if (isLeft){
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
				case KeyData.right:
				{
					if (isRight){
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