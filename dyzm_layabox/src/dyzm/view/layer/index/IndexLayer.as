package dyzm.view.layer.index
{
	import dyzm.MainScene;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.baseUi.BaseBtn;
	import dyzm.view.layer.fight.FightLayer;
	
	import laya.utils.Handler;

	public class IndexLayer extends BaseLayer
	{
		public var skillBtn:BaseBtn;
		public var fightBtn:BaseBtn;
		public function IndexLayer()
		{
			super();
			skillBtn = new BaseBtn(null, "技能设置");
			skillBtn.x = 300;
			skillBtn.y = 400;
			skillBtn.clickHandler = new Handler(this, onSkillClick);
			this.addChild(skillBtn);
			
			fightBtn = new BaseBtn(null, "开始战斗");
			fightBtn.x = 600;
			fightBtn.y = 400;
			fightBtn.clickHandler = new Handler(this, onFightClick);
			this.addChild(fightBtn);
		}
		
		private function onFightClick():void
		{
			MainScene.me.gotoLayer(new FightLayer(1));
		}
		
		private function onSkillClick():void
		{
			
		}
	}
}