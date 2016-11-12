package dyzm.view.layer.fight.childLayer.mainLayer
{
	import flash.display.Sprite;
	
	import dyzm.data.FightData;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.GameConfig;
	import dyzm.view.layer.fight.item.BaseItem;
	
	import ui.Arrow;
	
	/**
	 * 敌方箭头
	 * @author dj
	 */
	public class FoeArrow extends BaseItem
	{

		private var spr:Arrow;
		private var roleVo:Arrow;
		public function FoeArrow(roleVo:RoleVo)
		{
			spr = new Arrow;
			this.addChild(spr);
			super();
		}
		
		override public function frameUpdate():void
		{
			if (spr.parent == null){
				if (Math.abs(roleVo.x - FightData.mainRole.x) > GameConfig.w / 2 + 50){
					this.addChild(spr);
				}
			}else{
				if (Math.abs(roleVo.x - FightData.mainRole.x) < GameConfig.w / 2 + 50){
					this.removeChild(spr);
				}
			}
			
			if (spr.parent){
				spr.x = FightData.mainRole.x + GameConfig.w / 2;
				spr.y = roleVo.y;
			}
		}
	}
}