package dyzm.manager
{
	import flash.display.Stage;

	public class Cfg
	{
		/**
		 * 设计高
		 */
		public static var dh:int = 800;
		/**
		 * 设计宽
		 */
		public static var dw:int = 1280;
		
		public static var stage:Stage;
		
		/**
		 * 应用高
		 */
		public static var h:int;
		/**
		 * 应用宽
		 */
		public static var w:int;
		
		/**
		 * 舞台高
		 */
		public static var stageHeight:int;
		/**
		 * 舞台宽
		 */
		public static var stageWidth:int;
		/**
		 * 缩放比
		 */
		public static var scale:Number;
		
		/**
		 * 帧率
		 */
		public static var fps:int = 60;
		
		private static var keyId:int = 0;
		
		/**
		 * 是否显示被攻击块
		 */
		public static var showBy:Boolean = false;
		
		/**
		 * 是否显示攻击块
		 */
		public static var showAtt:Boolean = false;
		
		/**
		 * 全局keyId,用于obj中当唯一key
		 * @return 
		 */
		public static function getKeyId():int
		{
			return keyId++;
		}
	}
}