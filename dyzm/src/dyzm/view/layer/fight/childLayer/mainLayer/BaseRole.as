package dyzm.view.layer.fight.childLayer.mainLayer
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import asset.Shadow;
	
	import dyzm.data.role.RoleVo;
	import dyzm.view.layer.fight.item.BaseItem;
	
	public class BaseRole extends BaseItem
	{
		public var mc:MovieClip;
		public var shadow:Sprite;
		public var roleVo:RoleVo;
		
		public var turnContainer:Sprite;
		
		public var shadowSize:Object = {
			"站立":0.8,
			"走":0.8,
			"跑": 1.5,
			"跳":0.8
		};
		
		public function BaseRole(role:RoleVo)
		{
			turnContainer = new Sprite;
			this.addChild(turnContainer);
			
			roleVo = role;
			shadow = new Shadow();
			turnContainer.addChild(shadow);
			
			mc = new role.style();
			turnContainer.addChild(mc);
			
			roleVo.roleMc = mc;
			super();
		}
		override public function frameUpdate():void
		{
			super.frameUpdate();
			if (roleVo){
				this.x = roleVo.x;
				this.y = roleVo.y + roleVo.z;
				shadow.y = -roleVo.z;
				
				turnContainer.scaleX = roleVo.curTurn * roleVo.scaleX;
				turnContainer.scaleY = roleVo.scaleY;
				
				if (mc.currentFrameLabel != roleVo.frameName){
					mc.gotoAndStop(roleVo.frameName);
					mc.role.gotoAndStop(1);
					if (shadowSize[roleVo.frameName]){
						shadow.scaleX = shadowSize[roleVo.frameName];
					}else{
						shadow.scaleX = 1;
					}
				}
				if (mc.role.currentFrame != roleVo.curFrame){
					mc.role.gotoAndStop(roleVo.curFrame);
				}
				avatar();
			}
		}
		
		private function avatar():void
		{
			if (mc.role.weapon){
				if (roleVo.attr.equip && roleVo.attr.equip.weapon){
					if (roleVo.attr.equip.weapon.gem1){
						mc.role.weapon.gem1.addChild(roleVo.attr.equip.weapon.gem1.img);
					}
					if (roleVo.attr.equip.weapon.gem2){
						mc.role.weapon.gem2.addChild(roleVo.attr.equip.weapon.gem2.img);
					}
					if (roleVo.attr.equip.weapon.gem3){
						mc.role.weapon.gem3.addChild(roleVo.attr.equip.weapon.gem3.img);
					}
				}
			}
		}
	}
}