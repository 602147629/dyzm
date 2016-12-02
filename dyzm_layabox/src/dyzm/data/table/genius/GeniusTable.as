package dyzm.data.table.genius
{

	public class GeniusTable
	{
		public static var idToGenius:Object;
		public static function init():void
		{
			idToGenius = {};
			
			var tableVo:GeniusTableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "Blast4";
			tableVo.name = "爆炸!4";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "Blast7";
			tableVo.name = "爆炸!7";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "Blast10";
			tableVo.name = "爆炸!10";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "Blast15";
			tableVo.name = "爆炸!15";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "Blast20";
			tableVo.name = "爆炸!20";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "hpAbsorb";
			tableVo.name = "生命吸收";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "armorAbsorb";
			tableVo.name = "护甲吸收";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "destroy";
			tableVo.name = "破坏";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
			
			tableVo = new GeniusTableVo();
			tableVo.id = "erect";
			tableVo.name = "屹立";
			tableVo.needGold = 100;
			tableVo.needDay = 2;
			tableVo.needLv = 1;
			idToGenius[tableVo.id] = tableVo;
		}
	}
}