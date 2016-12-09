package dyzm.data.buff
{
	

	/**
	 * 碎甲debuff, 该目标只会恢复一半的护甲
	 * @author dj
	 */
	public class BrokenBuff extends BaseBuff
	{
		public static const TYPE:String = "BrokenBuff";
		
		public function BrokenBuff()
		{
			type = TYPE;
			super();
		}
		
		override public function frameUpdate():void
		{
			if (target.curAttr.armor == target.curAttr.maxArmor){
				target.curAttr.armor = target.curAttr.armor >> 1;
				remove();
			}
		}
	}
}