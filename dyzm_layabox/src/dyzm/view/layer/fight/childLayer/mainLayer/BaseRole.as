package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.Res;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Asset;
	import dyzm.view.layer.fight.item.BaseItem;
	
	import laya.display.Sprite;
	
	public class BaseRole extends BaseItem
	{
		public var mc:RoleView;
		public var shadow:Sprite;
		public var roleVo:RoleVo;
		
		/**
		 * 翻转容器
		 */
		public var turnContainer:Sprite;
		
		public static var shadowSize:Object;
		public function BaseRole(role:RoleVo)
		{
			super();
			if (shadowSize == null){
				shadowSize = {};
				shadowSize[RoleVo.TAG_STOOD] = 0.8;
				shadowSize[RoleVo.TAG_MOVE] = 0.8;
				shadowSize[RoleVo.TAG_RUN] = 1.5;
				shadowSize[RoleVo.TAG_JUMP] = 0.8;
				shadowSize[RoleVo.TAG_DEATH] = 2;
				shadowSize[RoleVo.TAG_DOWNING] = 2.5;
			}
			turnContainer = new Sprite; 
			this.addChild(turnContainer);
			
			roleVo = role;
			shadow = new Sprite();
			shadow.texture = Asset.getRes(Res.shadow);
			shadow.pivotX = shadow.texture.width / 2;
			shadow.pivotY = shadow.texture.height / 2;
			turnContainer.addChild(shadow);
			
			mc = new RoleView();
			mc.setData(Asset.getRes(role.style));
			mc.setSkinFromSkinVo(role.skin);

			turnContainer.addChild(mc);
			
			roleVo.roleMc = mc;
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
				
				if (mc.frameName != roleVo.frameName){
					mc.gotoAndStop(roleVo.frameName);
					if (shadowSize[roleVo.frameName]){
						shadow.scaleX = shadowSize[roleVo.frameName];
					}else{
						shadow.scaleX = 1;
					}
				}
				if (mc.curFrame != roleVo.curFrame){
					mc.childGotoAndStop(roleVo.curFrame - 1);
				}
//				avatar();
			}
		}
		
//		private function avatar():void
//		{
//			if (mc.role.weapon){
//				if (roleVo.attr.equip && roleVo.attr.equip.weapon){
//					if (roleVo.attr.equip.weapon.gem1){
//						mc.role.weapon.gem1.addChild(roleVo.attr.equip.weapon.gem1.img);
//					}
//					if (roleVo.attr.equip.weapon.gem2){
//						mc.role.weapon.gem2.addChild(roleVo.attr.equip.weapon.gem2.img);
//					}
//					if (roleVo.attr.equip.weapon.gem3){
//						mc.role.weapon.gem3.addChild(roleVo.attr.equip.weapon.gem3.img);
//					}
//				}
//			}
//		}
	}
}