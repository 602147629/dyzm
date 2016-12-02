package dyzm.data
{
	import dyzm.data.attr.GeniusVo;
	import dyzm.data.table.genius.GeniusTable;
	import dyzm.data.table.genius.GeniusTableVo;
	import dyzm.manager.Evt;

	/**
	 * 玩家天赋数据
	 */
	public class PlayerGeniusData
	{
		/**
		 * 天赋发生变化时派发事件,参数为 [GeniusTableVo, 是否升级]
		 */
		public static const GENIUS_UPDATE_EVENT:String = "GENIUS_UPDATE_EVENT";
		
		public static var genius:GeniusVo;
		
		/**
		 * 正在解锁的天赋
		 */
		public static var make:String = null;
		/**
		 * 已经学习了多少天
		 */
		public static var day:int = 0;
		
		public static function init():void
		{
			genius = new GeniusVo();
		}
		
		public static function newGame():void
		{
			
		}
		
		/**
		 * 解锁天赋
		 * @param id 天赋id
		 * @param isTrue 是否确定学习,和之前学习的不同时使用
		 */
		public static function upGenius(id:String, isTrue:Boolean):String
		{
			if (genius[id] != false) return "天赋已经开启";
			var tableVo:GeniusTableVo = GeniusTable.idToGenius[id];
			if (make == id){ // 继续学习
				Evt.once(WorldData.STOP_MOVING_DAY, null, stopMovingDay);
				Evt.once(WorldData.DAY_EVENT, null, upSkilling);
				WorldData.startTimeMove(3);
			}else {
				if (isTrue || make == null){
					if (PlayerAttrData.lv < tableVo.needLv){
						return "未达到需要等级";
					}
					if (PlayerAttrData.gold < tableVo.needGold){
						return "灵力不足,无法学习";
					}
					PlayerAttrData.useGold(tableVo.needGold, "天赋", "学习", id);
					make = id;
					day = 0;
					Evt.once(WorldData.STOP_MOVING_DAY, null, stopMovingDay);
					Evt.once(WorldData.DAY_EVENT, null, upSkilling);
					WorldData.startTimeMove(3);
				}else{
					return "需要先完成" + GeniusTable.idToGenius[make].name + "的学习";
				}
			}
			return null;
		}
		
		/**
		 * 时间停止运行
		 */
		private static function stopMovingDay():void
		{
			Evt.off(WorldData.STOP_MOVING_DAY, null, stopMovingDay);
			Evt.off(WorldData.DAY_EVENT, null, upSkilling);
		}
		
		public static function upSkilling():void
		{
			day ++;
			var tableVo:GeniusTableVo = GeniusTable.idToGenius[make];
			if (day >= tableVo.needDay){
				make = null;
				day = 0;
				genius[make] = true;
				WorldData.stopTimeMove();
				Evt.event(GENIUS_UPDATE_EVENT, [tableVo, true]);
			}else{
				if (WorldData.moving){
					Evt.once(WorldData.DAY_EVENT, null, upSkilling);
				}
				Evt.event(GENIUS_UPDATE_EVENT, [tableVo, false]);
			}
		}
		
		/**
		 * 存档时调用,获取存档数据
		 * @return 
		 */
		public static function getSave():Object
		{
			return {
				blast4:genius.blast4,
				blast7:genius.blast7,
				blast10:genius.blast10,
				blast15:genius.blast15,
				blast20:genius.blast20,
				hpAbsorb:genius.hpAbsorb,
				armorAbsorb:genius.armorAbsorb,
				destroy:genius.destroy,
				erect:genius.erect
			};
		}
		
		/**
		 * 载入存档
		 * @param obj
		 */
		public static function setSave(obj:Object):void
		{
			genius.blast4 = obj.blast4;
			genius.blast7 = obj.blast7;
			genius.blast10 = obj.blast10;
			genius.blast15 = obj.blast15;
			genius.blast20 = obj.blast20;
			genius.hpAbsorb = obj.hpAbsorb;
			genius.armorAbsorb = obj.armorAbsorb;
			genius.destroy = obj.destroy;
			genius.erect = obj.erect
		}
	}
}