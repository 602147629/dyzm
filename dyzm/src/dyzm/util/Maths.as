package dyzm.util
{
	

	public class Maths
	{
		/**
		 * 获得 min-max之间的随机数,包括min和max
		 * @param min
		 * @param max
		 * @return 
		 * 
		 */
		public static function random(min:int, max:int):int
		{
			if (min > max){
				var a:int = min;
				min = max;
				max = a;
			}
			return Math.round(Math.random() * (max - min) + min);
		}
	}
}