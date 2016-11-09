package dyzm.manager
{
	import flash.display.Stage;
	
	import dyzm.MainScene;

	public class GameConfig
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
		 * 缩放比
		 */
		public static var scale:Number;
		
		/**
		 * 主场景
		 */
		public static var mainScene:MainScene;
		
		/**
		 * 帧率
		 */
		public static var fps:int = 60;
	}
}