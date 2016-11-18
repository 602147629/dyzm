package dyzm.view.baseUi
{
	import com.bit101.components.Knob;
	import com.bit101.components.Panel;
	import com.bit101.components.ProgressBar;
	import com.bit101.components.RotarySelector;
	import com.bit101.components.Window;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class UiTest extends Sprite
	{
		public function UiTest()
		{
			super();
		}
		
		/**
		 * 仪表盘
		 */
		public function testRotarySelector():void
		{
			function fun():void
			{
				trace("仪表盘 改变");
			}
			var rotarySelector:RotarySelector = new RotarySelector(this, 200, 200, "cd", fun);
			
			// 设置有多少个指针,最多10个
			rotarySelector.numChoices = 10;
			// 设置选中仪表盘中的哪个指针
			rotarySelector.choice = 1;
			// 设置指示显示模式
			// ALPHABETIC = 字母模式
			// NUMERIC = 数字模式
			// "NONE = 不显示
			// ROMAN = 罗马字符
			rotarySelector.labelMode = RotarySelector.ALPHABETIC;
			rotarySelector.labelMode = RotarySelector.NUMERIC;
			rotarySelector.labelMode = RotarySelector.NONE;
			rotarySelector.labelMode = RotarySelector.ROMAN;
		}
		
		/**
		 * 可拖动容器
		 */
		public function testWindow():void
		{
			var win:Window = new Window(this, 200, 200, "装备栏");
			// 设置窗口大小
			win.setSize(300, 500);
			// 是否开启边缘阴影
			win.shadow = true;
			// 设置颜色
			win.color = 0xff0000;
			// 设置标题
			win.title = "装备栏";
			// 是否可以拖动
			win.draggable = true;
			// 是否有最小化按钮
			win.hasMinimizeButton = true;
			// 是否最小化
			win.minimized = true;
			// 关闭按钮
			win.hasCloseButton = true;
			
			win.addEventListener(Event.CLOSE, onClose);
			
			function onClose(e:Event):void
			{
				trace("关闭窗口");
			}
		}
		
		public function testPanel():void
		{
			var win:Panel = new Panel(this, 200, 200);
			// 设置窗口大小
			win.setSize(300, 500);
			// 是否开启边缘阴影
			win.shadow = true;
			// 设置颜色
			win.color = 0xff0000;
			// 设置格子大小
			win.gridSize = 20;
			// 是否显示格子
			win.showGrid = true;
			// 格子线条颜色
			win.gridColor = 0x000000;
		}
		
		/**
		 * 圆形拖动进度条
		 */
		public function testKnob():void
		{
			var win:Knob = new Knob(this, 200, 200);
			// 设置窗口大小
			win.setSize(300, 500);
			win.maximum = 10;
			win.radius = 100;
			// 设置拖动方式
//			win.mode = Knob.HORIZONTAL;
//			win.mode = Knob.ROTATE;
//			win.mode = Knob.VERTICAL;
		}
		
		public function testProgressBar():void
		{
			var win:ProgressBar = new ProgressBar(this, 200, 200);
			// 设置窗口大小
			win.setSize(300, 30);
			win.maximum = 100;
			win.value = 30;
			// 设置拖动方式
			//			win.mode = Knob.HORIZONTAL;
			//			win.mode = Knob.ROTATE;
			//			win.mode = Knob.VERTICAL;
			
			win.addEventListener(Event.CLOSE, onClose);
			
			function onClose(e:Event):void
			{
				trace("关闭窗口");
			}
		}
	}
}