package dyzm.view.layer.index
{
	import dyzm.MainScene;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.base.ui.BaseBtn;
	import dyzm.view.layer.fight.FightLayer;
	import dyzm.view.layer.index.childLayer.skillLayer.SkillLayer;
	
	import laya.display.Sprite;
	import laya.utils.Handler;

	public class IndexLayer extends BaseLayer
	{
		public var skillBtn:BaseBtn;
		public var fightBtn:BaseBtn;
		
		/**
		 * 技能界面
		 */
		public var skillLayer:SkillLayer;
		
		public var myLayer:Sprite;
		
		public var curChild:Sprite;
		
		public static var me:IndexLayer;
		public function IndexLayer()
		{
			super();
			me = this;
			myLayer = new Sprite();
			this.addChild(myLayer);
			
			skillBtn = new BaseBtn(null, "技能设置");
			skillBtn.x = 300;
			skillBtn.y = 400;
			skillBtn.clickHandler = new Handler(this, onSkillClick);
			myLayer.addChild(skillBtn);
			
			fightBtn = new BaseBtn(null, "开始战斗");
			fightBtn.x = 600;
			fightBtn.y = 400;
			fightBtn.clickHandler = new Handler(this, onFightClick);
			myLayer.addChild(fightBtn);
		}
		
		private function onFightClick():void
		{
			MainScene.me.gotoLayer(new FightLayer(1));
		}
		
		private function onSkillClick():void
		{
			if(skillLayer == null){
				skillLayer = new SkillLayer();
			}
			this.addChild(skillLayer);
			curChild = skillLayer;
			
			myLayer.visible = false;
		}
		
		public function closeChild(t:Sprite):void
		{
			if (curChild == t){
				this.removeChild(t);
				myLayer.visible = true;
			}
		}
	}
}