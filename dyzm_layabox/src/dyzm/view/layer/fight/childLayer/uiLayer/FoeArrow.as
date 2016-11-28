package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.Res;
	import dyzm.data.FightData;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Asset;
	import dyzm.manager.Cfg;
	import dyzm.view.layer.fight.item.BaseItem;
	
	import laya.display.Sprite;
	
	/**
	 * 敌方箭头
	 * @author dj
	 */
	public class FoeArrow extends BaseItem
	{
		
		private var spr:Sprite;
		private var roleVo:RoleVo;
		private var index:int;
		public function FoeArrow(roleVo:RoleVo, index:int)
		{
			super();
			spr = new Sprite;
			spr.texture = Asset.getRes(Res.arrow);
			spr.pivotX = spr.texture.width;
			spr.pivotY = spr.texture.height / 2;
			this.addChild(spr);
			this.index = index;
			this.roleVo = roleVo;
		}
		
		override public function frameUpdate():void
		{
			if (FightData.foeList[index]){
				if (FightData.foeList[index] != roleVo){
					roleVo = FightData.foeList[index];
				}
				if (spr.parent == null){
					if (Math.abs(roleVo.x - FightData.mainRole.x) > Cfg.w / 2 + 50){
						this.addChild(spr);
					}
				}else{
					if (Math.abs(roleVo.x - FightData.mainRole.x) < Cfg.w / 2 + 50){
						this.removeChild(spr);
					}
				}
				if (spr.parent){
					if (roleVo.x > FightData.mainRole.x){
						spr.x = Cfg.w;
						spr.scaleX = 1;
					}else{
						spr.x = 0;
						spr.scaleX = -1;
					}
					spr.y = roleVo.y + -100;
				}
			}else{
				if (spr.parent){
					this.removeChild(spr);
				}
			}
		}
	}
}