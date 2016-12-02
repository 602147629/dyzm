package dyzm.data.buff
{
	import dyzm.data.role.RoleVo;

	public class BaseBuff
	{
		/**
		 * 中的人
		 */
		public var target:RoleVo;
		/**
		 * 发起人
		 */
		public var source:RoleVo;
		public function BaseBuff()
		{
		}
		
		/**
		 * 帧率更新
		 */
		public function frameUpdate():void
		{
			
		}
		
		/**
		 * buff添加时调用
		 */
		public function add(_target:RoleVo,_source:RoleVo):void
		{
			target = target;
			source = _source;
		}
		
		/**
		 * buff移除时调用
		 */
		public function remove():void
		{
			
		}
	}
}