package dyzm.data
{
	import flash.net.SharedObject;

	public class KeyData
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
		
		public static var keyCodeToShow:Object = {
			
		};
		
		public static function init():void
		{
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
			
			for (var i:int = 0; i < 255; i++) 
			{
				keyCodeToShow[i] = String.fromCharCode(i);
			}
			keyCodeToShow[38] = "↑";
			keyCodeToShow[40] = "↓";
			keyCodeToShow[37] = "←";
			keyCodeToShow[39] = "→";
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
	}
}