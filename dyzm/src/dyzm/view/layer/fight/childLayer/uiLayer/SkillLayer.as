package dyzm.view.layer.fight.childLayer.uiLayer
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import dyzm.data.KeyData;
	import dyzm.manager.EventManager;
	import dyzm.manager.GameConfig;
	import dyzm.view.layer.fight.FightLayer;
	import dyzm.view.layer.fight.item.BaseItem;
	
	import ui.DirBar;
	import ui.SkillBar;
	
	/**
	 * 技能条
	 * @author dj
	 */
	public class SkillLayer extends BaseItem
	{
		public var skillBar:SkillBar;
		public var dirBar:DirBar;
		public var txt:TextField;
		private var curBtn:Sprite;
		public function SkillLayer()
		{
			skillBar = new SkillBar();
			skillBar.x = 0;
			skillBar.y = GameConfig.h;
			this.addChild(skillBar);
			skillBar.addEventListener(MouseEvent.CLICK, onClick);
			
			
			
			dirBar = new DirBar();
			dirBar.x = GameConfig.w;
			dirBar.y = GameConfig.h;
			this.addChild(dirBar);
			dirBar.addEventListener(MouseEvent.CLICK, onClick);
			
			draw();
		}
		
		private function onClick(e:MouseEvent):void
		{
			EventManager.dispatchEvent(FightLayer.STOP_FIGHT_EVENT);
			
			if (txt == null){
				txt = new TextField();
				txt.y = GameConfig.h/2;
				txt.mouseEnabled = false;
			}
			txt.text = "请输入该按钮的按键";
			var textFormat:TextFormat = txt.getTextFormat();
			textFormat.size = 48;
			textFormat.color = 0xff0000;
			textFormat.align = TextFormatAlign.CENTER;
			txt.setTextFormat(textFormat);
			txt.width = txt.textWidth + 10;
			txt.x = GameConfig.w/2 - txt.width / 2;
			this.addChild(txt);
			
			curBtn = e.target as Sprite;
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			KeyData[curBtn.name] = event.keyCode;
			draw();
			
			this.removeChild(txt);
			
			EventManager.dispatchEvent(FightLayer.RE_FIGHT_EVENT);
			
			KeyData.saveKey();
		}
		
		private function draw():void
		{
			for (var i:int = 1; i <= 6; i++) 
			{
				skillBar["skill_" + i].txt.text = KeyData.keyCodeToShow[KeyData["skill_" + i]];
				skillBar["skill_" + i].mouseChildren = false;
			}
			
			dirBar.up.txt.text = KeyData.keyCodeToShow[KeyData.up];
			dirBar.down.txt.text = KeyData.keyCodeToShow[KeyData.down];
			dirBar.left.txt.text = KeyData.keyCodeToShow[KeyData.left];
			dirBar.right.txt.text = KeyData.keyCodeToShow[KeyData.right];
			
			dirBar.up.mouseChildren = false;
			dirBar.down.mouseChildren = false;
			dirBar.left.mouseChildren = false;
			dirBar.right.mouseChildren = false;
		}
	}
}