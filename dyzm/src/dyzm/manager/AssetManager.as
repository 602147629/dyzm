package dyzm.manager
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class AssetManager
	{
		
		public static var needLoad:int = 0;
		public static var imgPool:Object = {};
		
		public static const COMPLETE:String = "AssetManager.COMPLETE";
		public function AssetManager()
		{
		}
		
		
		public static function loadImg(url:String):void
		{
			if (imgPool[url]) return;
			
			needLoad ++;
			var loader:Loader = new Loader();
			var urlReq:URLRequest = new URLRequest(url);
			loader.load(urlReq);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImg);
			
			function onCompleteImg(e:Event):void
			{
				needLoad --;
				var loaderInfo:LoaderInfo = e.target as LoaderInfo;
				imgPool[url] = (loaderInfo.loader.content as Bitmap).bitmapData;
				if (needLoad == 0){
					EventManager.dispatchEvent(COMPLETE);
				}
			}
		}
	}
}