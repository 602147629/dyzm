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
		
		public var shadowSize:Object = {
			"站立":0.8,
			"走":0.8,
			"跑": 1.5,
			"跳":0.8
		}
		public function BaseRole(role:RoleVo)
		{
			roleVo = role;
			shadow = new Shadow();
			this.addChild(shadow);
			super();
		}
		
		override public function frameUpdate():void
		{
			super.frameUpdate();
			if (roleVo){
				this.x = roleVo.x;
				this.y = roleVo.y + roleVo.z;
				shadow.y = -roleVo.z;
				
				this.scaleX = roleVo.curTurn * roleVo.scaleX;
				this.scaleY = roleVo.scaleY;
				
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
			}
		}
	}
}