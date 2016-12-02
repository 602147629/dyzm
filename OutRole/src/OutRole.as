package
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class OutRole extends Sprite
	{
		public static var swfsUrl:String = "res/";
		public static var me:Sprite;
		public static var outUrl:Array = ["E:/dyzm/layaboxTest/src/res/role/", "E:/dyzm/laya/laya/assets/role/", "C:/1/"];
		public const strList:Array = ["eye", "eye1", "rightArm", "rightHand", "leftArm", "leftHand", "body", "head", "head1", "rightLeg", "rightCrus", "leftCrus", "leftLeg", "weapon"];
		public function OutRole()
		{
			me = this;
			var mc:MovieClip;
			var file:File = File.applicationDirectory.resolvePath(swfsUrl);
			h(file.getDirectoryListing());
//			var sp:Sprite = new Sprite();
//			sp.graphics.beginFill(0xff0000, 1);
//			sp.graphics.drawRect(0,0,100,100);
//			sp.x = 100;
//			sp.y = 100;
//			sp.rotation = 100;
//			var a:Matrix = sp.transform.matrix;
//			a.a=-0.17364501953125, a.b=0.98480224609375, a.c=-0.98480224609375, a.d=-0.17364501953125, a.tx=100, a.ty=100;
//			sp.transform.matrix = a;
//			trace(a, sp.rotation);
//			this.addChild(sp);
		}
		
		private function h(fileArray):void
		{
			for (var i:int = 0; i < fileArray.length; i++) 
			{
				if (fileArray[i].isDirectory){
					h(fileArray[i].getDirectoryListing());
				}else if (fileArray[i].extension == "swf"){
					load(fileArray[i].url, fileArray[i].name);
				}
			}
		}
		
		private function load(url:String, fileName:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			var app:ApplicationDomain = new ApplicationDomain;
			loader.load(new URLRequest(url), new LoaderContext(false, app));
			function onLoadComplete(event:Event):void
			{
				var obj:Object = {};
				obj["part"] = {};
				var list:Vector.<String> = app.getQualifiedDefinitionNames();
				for (var i:int = 0; i < list.length; i++)
				{
					var mc:MovieClip = new (app.getDefinition(list[i]) as Class);
					if (list[i].substr(0, "asset::".length) == "asset::"){
						onRole(mc, url, obj, app);
					}else if (list[i].substr(0, "rolePart::".length) == "rolePart::"){
						var name:String = list[i].substr("rolePart::".length);
						onPart(mc, url, obj["part"], name);
					}
				}
				saveObj(obj, url, fileName);
			}
		}
		
		/**
		 * 读取部件属性
		 * @param part
		 * @param url
		 */
		private function onPart(part:MovieClip, url:String, obj:Object, name:String):void
		{
			var item:DisplayObject = part.img;
			obj[name] = {
				"matrix":[
					item.transform.matrix.a,
					item.transform.matrix.b,
					item.transform.matrix.c,
					item.transform.matrix.d,
					item.transform.matrix.tx,
					item.transform.matrix.ty
				]
			};
			obj[name]["equip"] = {};
			for (var i:int = 1; i < part.numChildren; i++) 
			{
				var dis:DisplayObject = part.getChildAt(i);
				obj[name]["equip"][dis.name] = [
					dis.transform.matrix.a,
					dis.transform.matrix.b,
					dis.transform.matrix.c,
					dis.transform.matrix.d,
					dis.transform.matrix.tx,
					dis.transform.matrix.ty
				];
			}
		}
		
		/**
		 * 读取人物属性
		 * @param role
		 * @param url
		 * 
		 */
		private function onRole(role:MovieClip, url:String, obj:Object, app:ApplicationDomain):void
		{
			
			var actions:Array = role.currentLabels;
			var allFrame:int = 0;
			for (var j:int = 0; j < actions.length; j++) 
			{
				var actionName:String = actions[j].name;
				obj[actionName] = [];
				role.gotoAndStop(actionName);
				var action:MovieClip = role.role;
				allFrame = action.totalFrames;
				for (var k:int = 0; k < allFrame; k++) 
				{
					action.gotoAndStop(k+1);
					obj[actionName][k] = {};
					if (action.currentFrameLabel){
						obj[actionName][k]["label"] = action.currentFrameLabel;
					}
					var i:int, a:int, c:Class, str:String;
					for (i=0; i < action.numChildren; i++) 
					{
						var item:DisplayObject = action.getChildAt(i);
						for (a = 0; a < strList.length; a++) 
						{
							c = app.getDefinition("rolePart::" + strList[a]) as Class;
							str = strList[a];
							if (item as c){
								obj[actionName][k][str] = [
									item.transform.matrix.a,
									item.transform.matrix.b,
									item.transform.matrix.c,
									item.transform.matrix.d,
									item.transform.matrix.tx,
									item.transform.matrix.ty];
								break;
							}
						}
					}
					onByAndAtt(obj[actionName][k], action);
				}
			}
		}
		
		private function onByAndAtt(obj:Object, action:MovieClip):void
		{
			var index1:int = 1;
			var index2:int = 1;
			while(index1 <= 10){
				index2 = 1;
				while(true){
					var by:Sprite = action["by_" + index1 + "_" + index2];
					if (by){
						if (obj["by"] == null){
							obj["by"] = {};
						}
						if (obj["by"][index1] == null){
							obj["by"][index1] = [];
						}
						obj["by"][index1][index2-1] = [by.x, by.y, by.width, by.height];
						index2 ++;
					}else{
						break;
					}
				}
				index1 ++;
			}
			
			index1 = 1;
			index2 = 1;
			while(index1 <= 10){
				index2 = 1;
				while(true){
					var att:Sprite = action["att_" + index1 + "_" + index2];
					if (att){
						if (obj["att"] == null){
							obj["att"] = {};
						}
						if (obj["att"][index1] == null){
							obj["att"][index1] = [];
						}
						obj["att"][index1][index2-1] = [att.x, att.y, att.width, att.height];
						index2 ++;
					}else{
						break;
					}
				}
				index1 ++;
			}
		}
		
		private function saveObj(obj:Object, url:String, fileName:String):void
		{
			var json:String = JSON.stringify(obj);
			fileName = fileName.replace(".swf", ".json");
			for (var i:String in outUrl) 
			{
				var file:File = new File(outUrl[i] + fileName);
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.WRITE);
				fs.writeUTFBytes(json);
			}
		}
	}
}