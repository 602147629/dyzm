package dyzm.util
{
	import flash.utils.getDefinitionByName;

	public class ClassUtil
	{
		public function ClassUtil()
		{
		}
		public static function getClass(name:String):Class
		{
			return getDefinitionByName(name) as Class;
		}
	}
}