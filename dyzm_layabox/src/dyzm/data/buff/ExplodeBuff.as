package dyzm.data.buff
{
	import dyzm.data.role.RoleVo;

	/**
	 * 尸体爆炸效果BUFF
	 * @author dj
	 */
	public class ExplodeBuff extends BaseBuff
	{
		public static const TYPE:String = "ExplodeBuff";
		public var r:int;
		public function ExplodeBuff()
		{
			type = TYPE;
			super();
		}
		
		override public function add(_target:RoleVo, _source:RoleVo):Boolean
		{
			if (_target.curAttr.hp <= 0){
				target = _target;
				source = _source;
				r = Math.random() * 5;
				return true;
			}else{
				return false;
			}
		}
		
		override public function frameUpdate():void
		{
			if (r < 0){
				target.explode();
				remove();
			}else{
				r --;
			}
		}
	}
}