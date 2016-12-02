package dyzm.view.manager
{
	import dyzm.Res;
	import dyzm.manager.Cfg;
	
	import laya.ui.Image;
	
	public class BlackBg extends Image
	{
		public static var me:BlackBg;
		public function BlackBg()
		{
			super();
			me = this;
			this.skin = Res.blackBg;
			this.sizeGrid = "2,2,2,2";
			this.size(Cfg.w, Cfg.h);
			this.mouseEnabled = true;
			this.mouseThrough = false;
		}
	}
}