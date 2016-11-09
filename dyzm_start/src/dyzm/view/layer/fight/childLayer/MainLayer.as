package dyzm.view.layer.fight.childLayer
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import dyzm.data.FightData;
	import dyzm.data.vo.RoleVo;
	import dyzm.manager.EventManager;
	import dyzm.manager.GameConfig;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.layer.fight.HandleView;
	import dyzm.view.layer.fight.item.BaseFire;
	import dyzm.view.layer.fight.item.BaseRole;
	import dyzm.view.layer.fight.item.FoeRole;
	import dyzm.view.layer.fight.item.MainRole;

	public class MainLayer extends BaseLayer
	{
		/**
		 * 操作
		 */
		public var handleView:HandleView;
		/**
		 * 主角
		 */
		public static var mainRole:MainRole;
		/**
		 * 怪物
		 */
		public var foeList:Array;
		
		/**
		 * 火花
		 */
		public var fireDict:Dictionary;
		
		/**
		 * 自己
		 */
		public static var me:MainLayer;
		
		public function MainLayer()
		{
			me = this;
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		/**
		 * 当添加到舞台的时候,监听键盘事件,开始控制小人
		 * @param e
		 */
		public function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			// 初始化主角
			mainRole = new MainRole(FightData.mainRole);
			this.addChild(mainRole);
			
			handleView = new HandleView();
			handleView.start(this.stage, mainRole);
			
			// 初始化怪物
			foeList = [];
			for (var i:int = 0; i < FightData.foeList.length; i++) 
			{
				foeList[i] = new FoeRole(FightData.foeList[i]);
				this.addChild(foeList[i]);
			}
			fireDict = new Dictionary();
			EventManager.addEvent(RoleVo.ADD_FIRE_EVENT, addFire);
			
			EventManager.addEvent(RoleVo.REMOVE_FIRE_EVENT, removeFire);
		}
		
		/**
		 * 添加火花
		 * @param p 火花的显示位置
		 * @param fireType 火花类型
		 * @param y 火花排序坐标
		 * 
		 */
		public function addFire(p:Point, fireType:int, y:Number):void
		{
			var fire:BaseFire = new BaseFire(fireType, y);
			fire.x = p.x;
			fire.y = p.y;
			this.addChild(fire);
			fireDict[fire] = true;
		}
		
		public function removeFire(fire:BaseFire):void
		{
			delete fireDict[fire];
		}
		
		override public function frameUpdate():void
		{
			this.x = -mainRole.x + GameConfig.w / 2;
			this.y = -mainRole.roleVo.z * 0.3;
			
			super.frameUpdate();
			
			var sortArr:Array = [mainRole];
			mainRole.frameUpdate();
			for (var i:int = 0; i < foeList.length; i++) 
			{
				foeList[i].frameUpdate();
				sortArr.push(foeList[i]);
			}
			
			for (var fire:BaseFire in fireDict){
				sortArr.push(fire);
			}
				
			
			// 根据y轴排显示优先级
			sortArr.sort(sortY);
			
			for (var j:int = 0; j < sortArr.length; j++) 
			{
				this.setChildIndex(sortArr[j], 0);
			}
		}
		
		/**
		 * 根据y轴排序
		 * @param a
		 * @param b
		 * @return 
		 */
		public function sortY(a:Object, b:Object):Boolean
		{
			var ay:Number = getZ(a);
			var by:Number = getZ(b);
			if (by > ay){
				return -1;
			}
			return 0;
		}
		
		private function getZ(a:Object):Number
		{
			if (a is BaseRole){
				return a.roleVo.y;
			}else if (a is BaseFire){
				return a.yy;
			}
			return 0;
		}
	}
}