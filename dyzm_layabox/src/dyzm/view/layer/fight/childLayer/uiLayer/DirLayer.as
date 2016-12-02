package dyzm.view.layer.fight.childLayer.uiLayer
{
	import dyzm.data.PlayerKeyData;
	import dyzm.manager.Cfg;
	import dyzm.manager.Evt;
	import dyzm.view.base.ui.BaseDirBarUI;
	import dyzm.view.layer.fight.FightLayer;
	import dyzm.view.layer.fight.childLayer.mainLayer.HandleView;
	
	import laya.events.Event;
	import laya.ui.Button;
	import laya.ui.Label;

	public class DirLayer extends BaseDirBarUI
	{
		public var txt:Label;
		public var curBtn:Button;
		public function DirLayer()
		{
			super();
			
			this.on(Event.CLICK, this, onClick);
			
			draw();
			
			Evt.on(HandleView.DIR_KEY_DOWN_EVNET, this, onDirDown);
			Evt.on(HandleView.DIR_KEY_UP_EVNET, this, onDirUp);
			
			align();
		}
		
		public function align():void
		{
			this.x = Cfg.w;
			this.y = 0;
		}
		
		private function onDirDown(key:String):void
		{
			this[key + "Btn"].selected = true;
		}
		
		private function onDirUp(key:String):void
		{
			this[key + "Btn"].selected = false;
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
			upBtn.label = PlayerKeyData.keyCodeToShow[PlayerKeyData.up];
			downBtn.label = PlayerKeyData.keyCodeToShow[PlayerKeyData.down];
			leftBtn.label = PlayerKeyData.keyCodeToShow[PlayerKeyData.left];
			rightBtn.label = PlayerKeyData.keyCodeToShow[PlayerKeyData.right];
			
			upBtn.selected = false;
			downBtn.selected = false;
			leftBtn.selected = false;
			rightBtn.selected = false;
		}
	}
}