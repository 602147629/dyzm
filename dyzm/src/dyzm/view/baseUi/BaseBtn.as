package dyzm.view.baseUi
{
	import com.bit101.components.PushButton;
	
	import flash.display.DisplayObjectContainer;
	
	public class BaseBtn extends PushButton
	{
		public function BaseBtn(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, label:String="", defaultHandler:Function=null)
		{
			super(parent, xpos, ypos, label, defaultHandler);
		}
	}
}