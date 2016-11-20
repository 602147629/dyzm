package dyzm.view.layer.index
{
	import flash.events.Event;
	
	import dyzm.MainScene;
	import dyzm.view.base.BaseLayer;
	import dyzm.view.baseUi.BaseBtn;
	import dyzm.view.layer.fight.FightLayer;

	public class IndexLayer extends BaseLayer
	{
		public var skillBtn:BaseBtn;
		public var fightBtn:BaseBtn;
		public function IndexLayer()
		{
			super();
			skillBtn = new BaseBtn(this, 200, 400, "技能设置", onSkillClick);
			skillBtn.setSize(100, 40);
			
			fightBtn = new BaseBtn(this, 350, 400, "开始战斗", onFightClick);
			fightBtn.setSize(100, 40);
		}
		
		private function onFightClick(e:Event):void
		{
			MainScene.me.gotoLayer(new FightLayer(1));
		}
		
		private function onSkillClick(e:Event):void
		{
			
		}
	}
}