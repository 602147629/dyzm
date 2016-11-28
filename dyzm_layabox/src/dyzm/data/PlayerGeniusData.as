package dyzm.data
{
	import dyzm.data.attr.GeniusVo;
	/**
	 * 玩家天赋数据
	 */
	public class PlayerGeniusData
	{
		public static var genius:GeniusVo;
		
		public static function init():void
		{
			genius = new GeniusVo();
		}
		
		public static function newGame():void
		{
			
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