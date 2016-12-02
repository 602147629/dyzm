package dyzm.view.layer.index.childLayer.skillLayer
{
	import dyzm.data.PlayerSkillData;
	import dyzm.data.table.skill.SkillTable;
	import dyzm.data.table.skill.SkillTableVo;
	import dyzm.view.base.ui.BaseBtn;
	
	import laya.ui.Box;

	public class BaseSkillItem extends Box
	{

		private var btn:BaseBtn;
		public function BaseSkillItem()
		{
			btn = new BaseBtn();
			btn.size(520, 80);
			this.addChild(btn);
		}
		
		override public function set dataSource(value:*):void
		{
			if (value != null){
				var info:Object = PlayerSkillData.skillInfo[value.id];
				var tableVo:SkillTableVo = SkillTable.table[value.id];
				switch(info.type)
				{
					case -1:
					{
						btn.label = value.id + ":" + "未习得";
						break;
					}
					case 0:
					{
						btn.label = value.id + ":" + "未升级";
						break;
					}
					case 1:
					{
						btn.label = value.id + ":" + tableVo.up1Name;
						break;
					}
					case 2:
					{
						btn.label = value.id + ":" + tableVo.up2Name;
						break;
					}
						
					default:
					{
						break;
					}
				}
				btn.selected = value.selected;
			}
			super.dataSource = value;
		}
	}
}