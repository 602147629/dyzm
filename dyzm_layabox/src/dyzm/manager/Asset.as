package dyzm.manager
{
	import laya.net.Loader;
	import laya.net.URL;
	import laya.utils.Handler;

	public class Asset
	{
		
		public static var needLoad:int = 0;
		public static var loading:Object = {};
		public static var res:Object = {};
		public static const COMPLETE:String = "AssetManager.COMPLETE";
		
		public static function loadImg(url:String):void
		{
			if (!url) throw ("url 错误");
			var furl:String = URL.formatURL(url);
			if (loading[furl]) return;
			loading[furl] = true;
			Laya.loader.load(url, new Handler(null, onComplete, [furl]), null, Loader.IMAGE);
			needLoad ++;
			
		}
		
		public static function loadAtlas(url:String):void
		{
			if (!url) throw ("url 错误");
			var furl:String = URL.formatURL(url);
			if (loading[furl]) return;
			loading[furl] = true;
			Laya.loader.load(url, new Handler(null, onComplete, [furl]), null, Loader.ATLAS);
			needLoad ++;
		}
		
		public static function loadJson(url:String):void
		{
			if (!url) throw ("url 错误");
			var furl:String = URL.formatURL(url);
			if (loading[furl]) return;
			loading[furl] = true;
			Laya.loader.load(url, new Handler(null, onComplete, [furl]), null, Loader.JSON);
			needLoad ++;
		}
		
		public static function onComplete(url:String, t:*=null):void
		{
			if (!Loader.getRes(url)){
				res[url] = t;
			}
			
			needLoad --;
			if (needLoad == 0){
				Evt.event(COMPLETE);
			}
		}
		
		public static function getRes(url:String):*
		{
			var a:* = Loader.getRes(url);
			return a || res[URL.formatURL(url)];
		}
	}
}