package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.data.WorldData;
	import dyzm.data.role.RoleVo;
	
	import laya.display.Sprite;
	
	/**
	 * 人物部件
	 * @author dj
	 */
	public class RolePart extends Sprite
	{
		public var img:Sprite;
		public var explodeZ:int;
		public var explodeX:int;
		public var explodeCurZ:int;
		public var explodeR:int;
		public function RolePart()
		{
			img = new Sprite();
			this.addChild(img);
		}
		
		/**
		 * 尸体爆炸
		 */
		public function explode(roleVo:RoleVo):void
		{
			explodeCurZ = roleVo.z - 100;
			explodeR = Math.random() * 10;
			explodeZ = -20 + (-15 * Math.random());
			explodeX = roleVo.curTurn * (roleVo.byAttInfo.x * Math.random() * 1.5);
		}
		
		public function frameUpdate():void
		{
			if (explodeCurZ < 0){
				this.rotation += explodeR;
				this.x += explodeX;
				this.y += explodeZ;  
				explodeCurZ += explodeZ;
				explodeZ -= WorldData.G;
			}else if (explodeZ > 10){
				explodeZ = - (explodeZ >> 1);
				explodeCurZ = -1;
			}else{
				this.alpha -= 0.02;
			}
		}
	}
}