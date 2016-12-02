package dyzm.data
{
	import dyzm.data.attr.AttrVo;
	import dyzm.manager.Evt;

	/**
	 * 主角属性
	 * @author dj
	 */
	public class PlayerAttrData
	{
		/**
		 * 属性
		 */
		public static var attr:AttrVo;
		/**
		 * 等级
		 */
		public static var lv:int;
		/**
		 * 经验
		 */
		public static var exp:int;
		/**
		 * 灵力
		 */
		public static var gold:int;
		/**
		 * 魂力
		 */
		public static var soul:int;
		/**
		 * 剩余天数
		 */
		public static var day:int;
		
		/**
		 * 当前天数
		 */
		public static var curDay:int;
		
		/**
		 * 资源的使用流向
		 */
		public static var useInfo:Object;
		
		public static function init():void
		{
			// 属性
			attr = new AttrVo();
			Evt.on(WorldData.DAY_EVENT, null, nextDay);
		}
		
		public static function newGame():void
		{
			lv = 1;
			exp = 0;
			gold = int.MAX_VALUE;
			soul = 0;
			day = 100;
			curDay = 1;
			useInfo = {};
		}
		
		/**
		 * 存档时调用,获取存档数据
		 * @return 
		 */
		public static function getSave():Object
		{
			return {
				lv:lv,
				exp:exp,
				gold:gold,
				soul:soul,
				day:day,
				curDay:curDay,
				useInfo:useInfo
			};
		}
		
		/**
		 * 载入存档
		 * @param obj
		 */
		public static function setSave(obj:Object):void
		{
			lv = obj.lv;
			exp = obj.exp;
			gold = obj.gold;
			soul = obj.soul;
			day = obj.day;
			curDay = obj.curDay;
			useInfo = obj.useInfo;
		}
		
		public static function nextDay():void
		{
			day -= 1;
			curDay ++;
		}
		
		/**
		 * 使用灵力
		 * @param num 使用值
		 * @param type1 流向, 主分类
		 * @param type2 流向, 副分类
		 * @param type3 流向, 次分类
		 */
		public static function useGold(num:int, type1:String, type2:String, type3:String):void
		{
			gold -= num;
			
			// 资金流向记录
			useInfo["gold"] += num;
			useInfo[type1] = useInfo[type1] || {};
			useInfo[type1][type2] = useInfo[type1][type2] || {};
			useInfo[type1][type2][type3] = useInfo[type1][type2][type3] || {};
			if (useInfo[type1][type2][type3].gold){
				useInfo[type1][type2][type3].gold += num;
			}else{
				useInfo[type1][type2][type3].gold = num;
			}
		}
	}
}