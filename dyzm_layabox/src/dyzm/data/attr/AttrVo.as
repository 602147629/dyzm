package dyzm.data.attr
{
	/**
	 * 人物属性,包括装备等
	 * @author dj
	 */
	public class AttrVo extends BaseAttrVo
	{
		/**
		 * 装备属性
		 */
		public var equip:AttrEquipVo;
		
		public function AttrVo()
		{
			equip = new AttrEquipVo;
		}
		
		/**
		 * 处理所有属性,计算出属性结果
		 */
		public function handle():void
		{
			// 基础属性
			toZero();
			
			moveSpeed = 4;
			runSpeed = 10;
			jumpPower = -30;
			critDmg = 1;
			
			// 装备属性
			equip.weapon.handle();
			equip.hat.handle();
			equip.glasses.handle();
			equip.belt.handle();
			equip.neck.handle();
			equip.ring.handle();
			
			add(equip.weapon);
			add(equip.hat);
			add(equip.glasses);
			add(equip.belt);
			add(equip.neck);
			add(equip.ring);
		}
	}
}