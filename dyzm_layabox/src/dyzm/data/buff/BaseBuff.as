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
		public var type:String;
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
		 * @param _target
		 * @param _source
		 * @return true表示添加成功
		 * 
		 */
		public function add(_target:RoleVo,_source:RoleVo):Boolean
		{
			target = _target;
			source = _source;
			return true;
		}
		
		/**
		 * buff移除时调用
		 */
		public function remove():void
		{
			target.removeBuff(this);
			target = null;
			source = null;
			BuffPool.inPool(this);
		}
	}
}