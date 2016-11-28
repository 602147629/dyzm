package dyzm.data
{
	import flash.net.SharedObject;

	public class PlayerKeyData
	{
		// 左手方向
		public static var up:int = 87; // w
		public static var down:int = 83; // s
		public static var right:int = 68; // a
		public static var left:int = 65; // d
		
		public static var skill_1:int = 74; // j
		public static var skill_2:int = 75; // k
		public static var skill_3:int = 76; // l
		public static var skill_4:int = 85; // u
		public static var skill_5:int = 73; // i
		public static var skill_6:int = 79; // o
		
		/**
		 * 是否使用全局按键设置
		 */
		public static var isGlobal:Boolean = true; // o
		
		public static var keyCodeToShow:Object = {
			
		};
		
		public static function init():void
		{
			for (var i:int = 0; i < 255; i++) 
			{
				keyCodeToShow[i] = String.fromCharCode(i);
			}
			keyCodeToShow[38] = "↑";
			keyCodeToShow[40] = "↓";
			keyCodeToShow[37] = "←";
			keyCodeToShow[39] = "→";
			keyCodeToShow[32] = "空格";
		}
		
		public static function newGame():void
		{
			getGlobalKey();
		}
		
		public static function getGlobalKey():void
		{
			// 按键设置不受存档限制,跨存档有效
			var sharedObject:SharedObject = SharedObject.getLocal("keyData");
			if (sharedObject.data.up != null){
				up = sharedObject.data.up;
				down = sharedObject.data.down;
				right = sharedObject.data.right;
				left = sharedObject.data.left;
				skill_1 = sharedObject.data.skill_1;
				skill_2 = sharedObject.data.skill_2;
				skill_3 = sharedObject.data.skill_3;
				skill_4 = sharedObject.data.skill_4;
				skill_5 = sharedObject.data.skill_5;
				skill_6 = sharedObject.data.skill_6;
			}
		}
		public static function saveKey():void
		{
			var sharedObject:SharedObject = SharedObject.getLocal("keyData");
			sharedObject.data.up = up;
			sharedObject.data.down = down;
			sharedObject.data.right = right;
			sharedObject.data.left = left;
			sharedObject.data.skill_1 = skill_1;
			sharedObject.data.skill_2 = skill_2;
			sharedObject.data.skill_3 = skill_3;
			sharedObject.data.skill_4 = skill_4;
			sharedObject.data.skill_5 = skill_5;
			sharedObject.data.skill_6 = skill_6;
			sharedObject.flush();
		}
		
		/**
		 * 存档时调用,获取存档数据
		 * @return 
		 */
		public static function getSave():Object
		{
			var obj:Object = {
				up:up,
				down:down,
				right:right,
				left:left,
				skill_1:skill_1,
				skill_2:skill_2,
				skill_3:skill_3,
				skill_4:skill_4,
				skill_5:skill_5,
				skill_6:skill_6,
				isGlobal:isGlobal
			}
			return obj;
		}
		
		/**
		 * 载入存档
		 * @param obj
		 */
		public static function setSave(data:Object):void
		{
			if (!data.isGlobal){
				up = data.up;
				down = data.down;
				right = data.right;
				left = data.left;
				skill_1 = data.skill_1;
				skill_2 = data.skill_2;
				skill_3 = data.skill_3;
				skill_4 = data.skill_4;
				skill_5 = data.skill_5;
				skill_6 = data.skill_6;
				isGlobal = data.isGlobal
			}else{
				getGlobalKey();
			}
		}
	}
}