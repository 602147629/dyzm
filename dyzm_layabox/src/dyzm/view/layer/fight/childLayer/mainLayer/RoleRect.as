package dyzm.view.layer.fight.childLayer.mainLayer
{
	import laya.display.Sprite;
	
	public class RoleRect extends Sprite
	{
		public var rectList:Object;
		public var color:String = "#0000ff";
		public function RoleRect()
		{
			rectList = [];
			super();
		}
		
		public function setColor(c:String):void
		{
			color = c;
		}
		
		public function setData(data:Object):void
		{
			var i:int, j:int, sp:Sprite;
			for (i in rectList) 
			{
				for (j = 0; j < rectList[i].length; j++) 
				{
					rectList[i][j].visible = false;
				}
				
			}
			
			for (i in data) 
			{
				if (rectList[i] == null){
					rectList[i] = [];
				}
				for (j = 0; j < data[i].length; j++) 
				{
					if (rectList[i][j] == null){
						sp = rectList[i][j] = new Sprite();
						sp.alpha = 0.5;
						this.addChild(sp);
					}else{
						sp = rectList[i][j];
						sp.visible = true;
					}
					sp.graphics.clear();
					sp.graphics.drawRect(data[i][j][0], data[i][j][1], data[i][j][2], data[i][j][3], color);
				}
			}
		}
	}
}