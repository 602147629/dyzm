package dyzm.data
{
	public class BgData
	{
		
		// [图片路径,  起始出现位置X, 位置Y, 每隔多少像素出现一次, 透明度, x轴缩放, y轴缩放, x轴移动比例, y轴起始移动位置, y轴移动比例, z轴移动比例, y轴缩放比例]
		//		public static const bg1bg:Array = [
		//			["res/bg/1.png", 0, 500, 100, 1, 1, 1, 1, 0],
		//			["res/bg/1.png", 0, 0, 100, 1, 1, 1, 1, 0]
		//		];
		//		
		//		public static const bg1Front:Array = [
		//			["res/bg/1.png", 0, 800, 100, 1, 0.5, 0.5, 1, 0],
		//			["res/bg/1.png", 500, 800, 30, 1, 0.5, 0.5, 1, 0]
		//		];
		
		public static const bg1bg:Array = [
			["res/bg/bg1_1.png",	0,		-80, 	1591, 	1,	1, 	1,	0.2, 	700, 	0, 		0.2, 	0],
			["res/bg/bg1_1.png",	1592, 	-80, 	1591, 	1,	-1,	1, 	0.2, 	700, 	0, 		0.2, 	0], 
			["res/bg/bg1_2.png",	500, 	-20, 	3000, 	1,	1, 	1, 	0.05, 	700, 	0, 		0.1, 	0], 
			["res/bg/bg1_3.png",	0, 		133, 	1257, 	1,	1, 	1, 	0.5, 	700,  	0.05, 	0.3, 	0],
			["res/bg/bg1_4.png",	0, 		214, 	1591, 	1,	1, 	1, 	1, 		700, 	0, 		0.3, 	0]
		];
		public static const bg1Front:Array = [
			["res/bg/bg1_5.png",	0, 		690, 	868, 	1, 	1, 	1, 	1, 		700,	0.2, 	0.4,	0]
		];
		

			
		public function BgData()
		{
		}
	}
}