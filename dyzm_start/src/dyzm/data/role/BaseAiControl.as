package dyzm.data.role
{
	import flash.geom.Point;
	
	import dyzm.data.RoleState;
	import dyzm.util.Maths;
	
	public class BaseAiControl extends RoleVo
	{
		/**
		 * 停顿状态
		 */
		public static const AI_STATE_STOP:int = 0;
		/**
		 * 移动状态
		 */
		public static const AI_STATE_MOVING:int = 1;
		
		/**
		 * 攻击状态
		 */
		public static const AI_STATE_ATT:int = 2;
		
		/**
		 * 当前状态
		 */
		public var aiState:int = 0;
		
		/**
		 * 当前时间
		 */
		public var curTime:int = 0;
		
		/**
		 * 移动需要的时间
		 */
		public var curMoveTime:int = 0;
		
		/**
		 * 寻路停顿时间, 单位帧
		 */
		public var findMoveStopTime:int = 60;
		
		/**
		 * 攻击开始前停顿时间, 单位帧
		 */
		public var attStartStopTime:int = 60;
		
		/**
		 * 寻路X轴最大偏差,单位像素
		 */
		public var findMoveMaxX:int = 90;
		/**
		 * 寻路X轴最小偏差,单位像素
		 */
		public var findMoveMinX:int = 30;
		
		
		/**
		 * 寻路Y轴最大偏差,单位像素
		 */
		public var findMoveMaxY:int = 40;
		/**
		 * 寻路Y轴最小偏差,单位像素
		 */
		public var findMoveMinY:int = 0;
		
		/**
		 * 敌方数组
		 */
		public var foeList:Array;
		
		
		public var toPos:Point = new Point;
		
		public var movePos:Point = new Point;
		
		public var curTarget:RoleVo;
		
		
		public function BaseAiControl()
		{
		}
		
		public function start(foeList:Array):void
		{
			this.foeList = foeList;
		}
		
		override public function reAction():void
		{
			super.reAction();
			if (attState == RoleState.ATT_NORMAL || attState == RoleState.ATT_AFTER_CANCEL){ //如果在可以打断的后摇中,如果有方向,则执行
				if (curState == RoleState.STATE_NORMAL){
					curTime = 0;
					aiState = AI_STATE_STOP;
					curMoveSpeedX = 0;
					curMoveSpeedY = 0;
					frameName = TAG_STOOD;
					curFrame = 1;
				}
			}
		}
		
		public function aiFrameUpdate():void
		{
			if (curState != RoleState.STATE_NORMAL && curState != RoleState.STATE_AIR) return;
			
			if (curTarget && curTarget.x < x){
				curTurn = -1;
			}else{
				curTurn = 1;
			}
			curTime ++;
			var b:Boolean;
			switch(aiState)
			{
				case AI_STATE_STOP:
				{
					if (curTime > attStartStopTime){
						b = attTest();
						if (b) return;
					}
					
					if (curTime >findMoveStopTime){
						move();
					}
					break;
				}
					
				case AI_STATE_MOVING:
				{
					curMoveTime --
					if (curMoveTime < 0){
						curTime = 0;
						aiState = AI_STATE_STOP;
						curMoveSpeedX = 0;
						curMoveSpeedY = 0;
						frameName = TAG_STOOD;
						curFrame = 1;
					}
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		override public function frameUpdate():void
		{
			aiFrameUpdate();
			super.frameUpdate();
		}
		
		/**
		 * 攻击检测, 由子类覆盖
		 * 需要如果开始攻击,需要修改aiState=STATE_ATT
		 * @return true = 开始攻击
		 */
		public function attTest():Boolean
		{
			return false;
		}
		
		/**
		 * 开始移动
		 */
		public function move():void
		{
			aiState = AI_STATE_MOVING;
			var foe:RoleVo;
			var myPos:Point = new Point(x, y);
			var fosPos:Point = new Point();
			var min:Number = Number.MAX_VALUE;
			var distance:Number;
			for (var i:int = 0; i < foeList.length; i++) 
			{
				foe = foeList[i];
				fosPos.x = foe.x;
				fosPos.y = foe.y;
				distance = Point.distance(myPos, fosPos);
				if (distance < min){
					distance = min;
					curTarget = foe;
				}
			}
			if (curTarget){
				if (Math.random() < 0.5){
					toPos.x = curTarget.x + Maths.random(findMoveMinX, findMoveMaxX);
				}else{
					toPos.x = curTarget.x + Maths.random(findMoveMinX, findMoveMaxX);
				}
				if (Math.random() < 0.5){
					toPos.y = curTarget.y + Maths.random(findMoveMinY, findMoveMaxY);
				}else{
					toPos.y = curTarget.y + Maths.random(findMoveMinY, findMoveMaxY);
				}
			}
			movePos = toPos.subtract(myPos);
			var xFrame:int = Math.abs(movePos.x / moveSpeedX);
			var yFrame:int = Math.abs(movePos.y / moveSpeedY);
			curMoveTime = xFrame > yFrame ? xFrame : yFrame;
			curMoveSpeedX = movePos.x / curMoveTime;
			curMoveSpeedY = movePos.y / curMoveTime;
			frameName = TAG_MOVE;
			curFrame = 1;
		}
	}
}