package dyzm.view.layer.fight.childLayer.uiLayer
{
	
	import dyzm.data.PlayerKeyData;
	import dyzm.manager.Cfg;
	import dyzm.manager.Evt;
	import dyzm.view.base.ui.BaseSkillBerUI;
	import dyzm.view.layer.fight.FightLayer;
	import dyzm.view.layer.fight.childLayer.mainLayer.HandleView;
	
	import laya.events.Event;
	import laya.ui.Button;
	import laya.ui.Label;
	
	/**
	 * 技能条
	 * @author dj
	 */
	public class SkillLayer extends BaseSkillBerUI
	{
		public var txt:Label;
		public var curBtn:Button;
		public function SkillLayer()
		{
			super();
			this.on(Event.CLICK, this, onClick);
			
			draw();

			Evt.on(HandleView.SKILL_KEY_DOWN_EVNET, this, onSkillDown);
			Evt.on(HandleView.SKILL_KEY_UP_EVNET, this, onSkillUp);
		}
		
		private function onSkillDown(skillId:int):void
		{
			this["skill_" + skillId].selected = true;
		}
		
		private function onSkillUp(skillId:int):void
		{
			this["skill_" + skillId].selected = false;
		}
		
		private function onClick(e:Event):void
		{
			Evt.event(FightLayer.STOP_FIGHT_EVENT);
			
			if (txt == null){
				txt = new Label();
				txt.y = Cfg.h/2;
			}
			txt.text = "请输入该按钮的按键";
			txt.fontSize = 48;
			txt.color = "#ff0000";
			txt.align = "center";
			txt.x = Cfg.w/2 - txt.width / 2;
			this.parent.addChild(txt);
			
			curBtn = e.target as Button;
			curBtn.selected = true;
			Laya.stage.on(Event.KEY_DOWN, this, onKeyDown);
		}
		
		private function onKeyDown(e:Event):void
		{
			Laya.stage.off(Event.KEY_DOWN, this, onKeyDown);
			
			PlayerKeyData[curBtn.name] = e.keyCode;
			draw();
			
			this.parent.removeChild(txt);
			
			PlayerKeyData.saveKey();
			
			Evt.event(FightLayer.RE_FIGHT_EVENT);
		}
		
		private function draw():void
		{
			for (var i:int = 1; i <= 6; i++) 
			{
				this["skill_" + i].selected = false;
				this["skill_" + i].label = PlayerKeyData.keyCodeToShow[PlayerKeyData["skill_" + i]];
			}
		}
	}
}