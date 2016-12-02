package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.data.FightData;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Cfg;
	import dyzm.manager.Evt;
	import dyzm.util.Dict;
	import dyzm.view.base.BaseLayer;
	
	import laya.maths.Point;

	public class MainLayer extends BaseLayer
	{
		/**
		 * 操作
		 */
		public var handleView:HandleView;
		/**
		 * 主角
		 */
		public static var mainRole:PlayerRole;
		/**
		 * 怪物
		 */
		public var foeList:Vector.<FoeRole>;
		/**
		 * 火花
		 */
		public var fireDict:Dict;
		/**
		 * 自己
		 */
		public static var me:MainLayer;
		
		public static var baseFirePool:Array = [];
		public static var dmgNumPool:Array = [];
		
		public function MainLayer()
		{
			me = this;
			super();
			// 初始化主角
			mainRole = new PlayerRole(FightData.mainRole);
			this.addChild(mainRole);
			
			handleView = new HandleView();
			handleView.start(mainRole);
			
			// 初始化怪物
			foeList = new Vector.<FoeRole>;
			for (var i:int = 0; i < FightData.foeList.length; i++) 
			{
				foeList[i] = new FoeRole(FightData.foeList[i]);
				this.addChild(foeList[i]);
			}
			fireDict = new Dict();
			
			Evt.on(RoleVo.ADD_FIRE_EVENT, this, addFire);
			
			frameUpdate();
		}
		
		/**
		 * 添加火花
		 * @param p 火花的显示位置
		 * @param fireType 火花类型
		 * @param y 火花排序坐标
		 * @param fireRotation 火花角度
		 * @param type 扣血类型:"hp"或"armor"
		 * @param num 扣血值
		 * @param isCrit 是否暴击
		 */
		public function addFire(p:Point, fireType:int, y:Number, fireRotation:int, type:String, num:int, isCrit:Boolean):void
		{
			var fire:BaseFire = getBaseFire();
			fire.playFire(fireType, y, fireRotation);
			fire.x = p.x;
			fire.y = p.y;
			this.addChild(fire);
			fireDict.setData(fire, true);
			var a:DmgNum = getDmgNum();
			a.x = p.x;
			a.y = p.y;
			a.setDmg(type, num, isCrit);
			this.addChild(a);
		}
		
		private function getBaseFire():BaseFire
		{
			if (baseFirePool.length == 0){
				return new BaseFire;
			}
			return baseFirePool.shift();
		}
		
		public function inPoolBaseFire(baseFire:BaseFire):void
		{
			fireDict.delData(baseFire);
			baseFirePool.push(baseFire);
			this.removeChild(baseFire);
		}
		
		private function getDmgNum():DmgNum
		{
			if (dmgNumPool.length == 0){
				return new DmgNum;
			}
			return dmgNumPool.shift();
		}
		
		public function inPoolDmgNum(dmgNum:DmgNum):void
		{
			dmgNumPool.push(dmgNum);
			this.removeChild(dmgNum);
		}
		
		override public function frameUpdate():void
		{
			this.x = -mainRole.x + Cfg.w / 2;
			this.y = -mainRole.roleVo.z * 0.3;
			
			super.frameUpdate();
			
			var sortArr:Array = [mainRole];
			mainRole.frameUpdate();
			
			for (var i:int = 0; i < foeList.length; i++) 
			{
				if (foeList[i].roleVo.needDel){
					if (FightData.foeList[i]){
						foeList[i].setRole(FightData.foeList[i]);
					}
				}else{
					foeList[i].frameUpdate();
					sortArr.push(foeList[i]);
				}
			}
			
			for each (var fire:BaseFire in fireDict.idToObj){
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