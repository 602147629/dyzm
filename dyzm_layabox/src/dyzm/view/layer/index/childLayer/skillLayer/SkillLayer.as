package dyzm.view.layer.index.childLayer.skillLayer
{
	import dyzm.data.PlayerSkillData;
	import dyzm.data.WorldData;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	import dyzm.manager.Cfg;
	import dyzm.manager.Evt;
	import dyzm.manager.Msg;
	import dyzm.view.layer.index.IndexLayer;
	
	import laya.events.Event;
	import laya.utils.Handler;
	
	public class SkillLayer extends BaseSkillLayerUI
	{
		/**
		 * 所有技能数据缓存
		 */
		public static var allList:Array;
		
		/**
		 * 技能条
		 */
		public var skillBar:SkillBar;
		public var curSelectedIndex:int = -1;
		
		/**
		 * 当前选中的数据
		 */
		public var curData:Object;
		
		/**
		 * 当前选中的技能数据
		 */
		public var curSkillInfo:Object;
		
		/**
		 * 当前选中的升级方向
		 */
		public var selectUp:int;
		
		public function SkillLayer()
		{
			super();
			skillBar = new SkillBar();
			this.addChild(skillBar);
			
			skillList.itemRender = BaseSkillItem;
			
			var i:int, len:int;
			if (allList == null){
				allList = [];
				var list:Array = PlayerSkillData.skillAllList;
				len = list.length;
				for (i = 0; i < len; i++) 
				{
					allList[i] = {id:list[i], selected:false};
				}
			}else{
				len = allList.length;
				for (i = 1; i < len; i++) 
				{
					allList[i].selected = false;
				}
			}
			allList[0].selected = true;
			
			skillList.array = allList;
			skillList.selectEnable = true;
			skillList.selectHandler = new Handler(this, onSelect);
			
			closeBtn.on(Event.CLICK, this, onClose);
			
			up1Btn.on(Event.CLICK, this, onUp1Btn);
			
			up2Btn.on(Event.CLICK, this, onUp2Btn);
			
			upBtn.on(Event.CLICK, this, onUpBtn);
			
			onSelect(0);
			
			align();
		}
		
		private function onClose(e:Event):void
		{
			IndexLayer.me.closeChild(this);
		}
		
		private function onSelect(index:int):void
		{
			if (curSelectedIndex != -1){
				curData.selected = false;
				skillList.setItem(curSelectedIndex, curData);
			}
			curSelectedIndex = index;
			curData = skillList.getItem(index);
			curData.selected = true;
			skillList.setItem(index, curData);
			
			// 设置右版面
			mainBtn.label = curData.id;
			var tableVo:SkillTableVo = SkillTable.table[curData.id];
			skillInfo.text = tableVo.info;
			
			curSkillInfo = PlayerSkillData.skillInfo[curData.id];
			up1Btn.label = tableVo.up1Name;
			up2Btn.label = tableVo.up2Name;
			switch(curSkillInfo.type)
			{
				case -1:
				{
					selectUp = 0;
					break;
				}
					
				case 0:
				{
					if (curSkillInfo.make == 2){
						selectUp = 2;
					}else{
						selectUp = 1;
					}
					break;
				}
					
				case 1:
				{
					if (curSkillInfo.make == 2){
						selectUp = 2;
					}else{
						selectUp = 1;
					}
					break;
				}
					
				case 2:
				{
					if (curSkillInfo.make == 1){
						selectUp = 1;
					}else{
						selectUp = 2;
					}
					break;
				}
				default:
				{
					break;
				}
			}
			
			setUp();
		}
		
		/**
		 * 设置升级
		 * @param select 1 || 2 || -1
		 */
		private function setUp():void
		{
			var tableVo:SkillTableVo = SkillTable.table[curData.id];
			var infoAddStr:String = null;
			if (curSkillInfo.opened.indexOf(1) == -1){
				if (curSkillInfo.make == 1){
					up1Open.text = "升级中";
					infoAddStr = "升级还需要"+ (tableVo.up1Day - curSkillInfo.day) + "天";
				}else{
					up1Open.text = "未学会";
					infoAddStr = "升级需要:\n灵力" + tableVo.up1Gold + "\n时间" + tableVo.up1Day +"天";
				}
			}else{
				if (curSkillInfo.type == 1){
					up1Open.text = "已启用";
				}else{
					up1Open.text = "可用";
				}
			}
			
			if (curSkillInfo.opened.indexOf(2) == -1){
				if (curSkillInfo.make == 2){
					up2Open.text = "升级中";
				}else{
					up2Open.text = "未学会";
				}
			}else{
				if (curSkillInfo.type == 2){
					up2Open.text = "已启用";
				}else{
					up2Open.text = "可用";
				}
			}
			var infoText:String = "";
			if (selectUp == 1){
				up1Btn.disabled = false;
				up2Btn.disabled = false;
				selected1Img.visible = true;
				selected2Img.visible = false;
				if (curSkillInfo.type == 1){
					upBtn.visible = false;
				}else if (curSkillInfo.make == 1){
					upBtn.visible = true;
					upBtn.label = "升级";
					infoAddStr = "升级还需要练习"+ (tableVo.up1Day - curSkillInfo.day) + "天";
				}else if (curSkillInfo.opened.indexOf(1) == -1){
					upBtn.visible = true;
					upBtn.label = "升级";
					infoAddStr = "升级需要:\n灵力" + tableVo.up1Gold + "\n练习" + tableVo.up1Day +"天";
				}else{
					upBtn.visible = true;
					upBtn.label = "开启";
				}
				if (infoAddStr){
					upInfo.text = tableVo.up1Info + "\n\n" + infoAddStr;
				}else{
					upInfo.text = tableVo.up1Info;
				}
			}else if(selectUp == 2){
				up1Btn.disabled = false;
				up2Btn.disabled = false;
				selected1Img.visible = false;
				selected2Img.visible = true;
				upInfo.text = tableVo.up2Info + "\n\n" + infoAddStr;
				if (curSkillInfo.type == 2){
					upBtn.visible = false;
				}else if (curSkillInfo.make == 2){
					upBtn.visible = true;
					upBtn.label = "升级";
					infoAddStr = "升级还需要练习"+ (tableVo.up2Day - curSkillInfo.day) + "天";
				}else if (curSkillInfo.opened.indexOf(2) == -1){
					upBtn.visible = true;
					upBtn.label = "升级";
					infoAddStr = "升级需要:\n灵力" + tableVo.up2Gold + "\n练习" + tableVo.up2Day +"天";
				}else{
					upBtn.visible = true;
					upBtn.label = "开启";
				}
				if (infoAddStr){
					upInfo.text = tableVo.up2Info + "\n\n" + infoAddStr;
				}else{
					upInfo.text = tableVo.up2Info;
				}
			}else{
				up1Btn.disabled = true;
				up2Btn.disabled = true;
				selected1Img.visible = false;
				selected2Img.visible = false;
				upBtn.visible = true;
				upBtn.label = "练习";
				if (curSkillInfo.make == 0){
					upInfo.text = "升级需要练习"+ (tableVo.needDay - curSkillInfo.day) + "天";
				}else{
					upInfo.text = "升级需要:\n灵力" + tableVo.needGold + "\n练习" + tableVo.needDay +"天";
				}
			}
		}
		
		private function onUp1Btn(e:Event):void
		{
			selectUp = 1;
			setUp();
		}
		
		private function onUp2Btn(e:Event):void
		{
			selectUp = 2;
			setUp();
		}
		
		/**
		 * 升级按钮,按下后开始练习,如果是未开始练习的技能则扣除灵力点
		 * @param e
		 */
		private function onUpBtn(e:Event):void
		{
			var str:String = PlayerSkillData.upSkill(curData.id, selectUp);
			if (str != null){
				Msg.show(str);
			}else{
				Evt.once(PlayerSkillData.SKILL_UPDATE_EVENT, this, onSkillUpdate);
				setUp();
			}
		}
		
		private function onSkillUpdate(tableVo:SkillTableVo, isUp:Boolean):void
		{
			if (isUp){
				onSelect(curSelectedIndex);
			}else{
				skillList.setItem(curSelectedIndex, curData);
				setUp();
			}
			
			if (WorldData.moving){
				Evt.once(PlayerSkillData.SKILL_UPDATE_EVENT, this, onSkillUpdate);
			}
		}
		
		/**
		 * 对齐
		 */
		public function align():void
		{
			img1.x = 75;
			img1.y = 50;
			
			img2.x = Cfg.w - 75 - img2.width;
			img2.y = 50;
			
			this.width = Cfg.w;
			this.height = Cfg.h;
		}
	}
}