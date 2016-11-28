package dyzm.view.layer.fight.childLayer.mainLayer
{
	import laya.display.Sprite;

	/**
	 * 人物部件
	 * @author dj
	 */
	public class RolePart extends Sprite
	{
		public var img:Sprite;
		public function RolePart()
		{
			img = new Sprite();
			this.addChild(img);
		}
	}
}