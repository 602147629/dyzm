package dyzm.view.layer.fight.childLayer.mainLayer
{
	import dyzm.data.role.RoleSkinVo;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Asset;
	import dyzm.manager.Cfg;
	
	import laya.display.Sprite;
	import laya.maths.Matrix;
	import laya.resource.Texture;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	/**
	 * 人物显示类
	 * @author dj
	 */
	public class RoleView extends Sprite
	{
		public static const strList:Array = ["eye", "eye1", "rightArm", "rightHand", "leftArm", "leftHand", "body", "head", "head1", "rightLeg", "rightCrus", "leftCrus", "leftLeg", "weapon"];
		
		protected var eye:RolePart;
		protected var eye1:RolePart;
		protected var rightArm:RolePart;
		protected var rightHand:RolePart;
		protected var leftArm:RolePart;
		protected var leftHand:RolePart;
		protected var body:RolePart;
		protected var head:RolePart;
		protected var head1:RolePart;
		protected var rightLeg:RolePart;
		protected var rightCrus:RolePart;
		protected var leftCrus:RolePart;
		protected var leftLeg:RolePart;
		protected var weapon:RolePart;
		
		/**
		 * 人物所有数据
		 */
		public var data:Object;
		/**
		 * 当前播放的动作名称
		 */
		public var frameName:String;
		/**
		 * 人物动作数据
		 */
		public var roleObj:Object;
		/**
		 * 当前帧数据
		 */
		public var frameObj:Object;
		/**
		 * 当前子动画帧
		 */
		public var curFrame:int;
		
		/**
		 * 子动画总帧数
		 */
		public var totalFrames:int;
		
		/**
		 * 子动画帧标签
		 */
		public var label:String;
		
		/**
		 * 当前帧的被攻击区域,二维数组
		 */
		public var by:Object;
		
		/**
		 * 当前帧的攻击区域,二维数组
		 */
		public var att:Object;
		
		/**
		 * 用于被攻击块的显示
		 */
		public var byRect:RoleRect;
		
		/**
		 * 用于攻击块的显示
		 */
		public var attRect:RoleRect;

		public var isExplode:Boolean = false;
		
		public function RoleView()
		{
			super();
			
			eye = new RolePart();
			eye1 = new RolePart();
			rightArm = new RolePart();
			rightHand = new RolePart();
			leftArm = new RolePart();
			leftHand = new RolePart();
			body = new RolePart();
			head = new RolePart();
			head1 = new RolePart();
			rightLeg = new RolePart();
			rightCrus = new RolePart();
			leftCrus = new RolePart();
			leftLeg = new RolePart();
			weapon = new RolePart();
			
			
			this.addChild(weapon);
			this.addChild(leftLeg);
			this.addChild(leftCrus);
			this.addChild(rightCrus);
			this.addChild(rightLeg);
			this.addChild(head1);
			this.addChild(head);
			this.addChild(body);
			this.addChild(leftHand);
			this.addChild(leftArm);
			this.addChild(rightHand);
			this.addChild(rightArm);
			this.addChild(eye1);
			this.addChild(eye);
			
			if (Cfg.showAtt){
				attRect = new RoleRect();
				this.addChild(attRect);
				attRect.setColor("#ff0000");
			}
			
			if (Cfg.showBy){
				byRect = new RoleRect();
				this.addChild(byRect);
				attRect.setColor("#0000ff");
			}
		}
		
		/**
		 * 设置数据
		 * @param data
		 */
		public function setData(data:Object):void
		{
			this.data = data;
			isExplode = false;
			initPart();
			gotoAndStop(RoleVo.TAG_STOOD);
		}
		
		public function setSkinFromSkinVo(skinVo:RoleSkinVo):void
		{
			var len:int = strList.length;
			for (var i:int = 0; i < len; i++) 
			{
				this[strList[i]].img.texture = Asset.getRes(skinVo[strList[i]]);
			}
		}
		
		/**
		 * 初始化部件位置
		 */
		public function initPart():void
		{
			var part:Object = data["part"];
			var m:Matrix;
			var rolePart:RolePart;
			for each (var i:String in strList) 
			{
				rolePart = this[i];
				rolePart.alpha = 1;
				m = rolePart.img.transform;
				if (m == null){
					m = new Matrix();
				}
				m.a = part[i].matrix[0];
				m.b = part[i].matrix[1];
				m.c = part[i].matrix[2];
				m.d = part[i].matrix[3];
				m.tx = part[i].matrix[4];
				m.ty = part[i].matrix[5];
				rolePart.img.transform = m;
			}
		}
		
		/**
		 * 
		 * @param eye
		 * @param eye1
		 * @param rightArm
		 * @param rightHand
		 * @param leftArm
		 * @param leftHand
		 * @param body
		 * @param head
		 * @param head1
		 * @param rightLeg
		 * @param rightCrus
		 * @param leftCrus
		 * @param leftLeg
		 * @param weapon
		 */
		public function setSkin(eye:Texture, eye1:Texture, rightArm:Texture, rightHand:Texture, leftArm:Texture, leftHand:Texture, body:Texture, head:Texture, head1:Texture, rightLeg:Texture, rightCrus:Texture, leftCrus:Texture, leftLeg:Texture, weapon:Texture):void
		{
			this.eye.img.texture = eye;
			this.eye1.img.texture = eye1;
			this.rightArm.img.texture = rightArm;
			this.rightHand.img.texture = rightHand;
			this.leftArm.img.texture = leftArm;
			this.leftHand.img.texture = leftHand;
			this.body.img.texture = body;
			this.head.img.texture = head;
			this.head1.img.texture = head1;
			this.rightLeg.img.texture = rightLeg;
			this.rightCrus.img.texture = rightCrus;
			this.leftCrus.img.texture = leftCrus;
			this.leftLeg.img.texture = leftLeg;
			this.weapon.img.texture = weapon;
		}
		
		public function gotoAndStop(name:String):void
		{
			if (isExplode) return;
			
			frameName = name;
			roleObj = data[name];
			totalFrames = roleObj.length;
			childGotoAndStop(0);
		}
		
		/**
		 * @param frame 跳转到第frame帧,帧从0开始计算
		 */
		public function childGotoAndStop(frame:int):void
		{
			if (isExplode) return;
			
			if (frame >= totalFrames){
				frame = totalFrames - 1;
			}else if (frame < 0){
				frame = 0;
			}
			
			curFrame = frame;
			frameObj = roleObj[frame];
			label = frameObj["label"];
			eye.visible = false;
			eye1.visible = false;
			rightArm.visible = false;
			rightHand.visible = false;
			leftArm.visible = false;
			leftHand.visible = false;
			body.visible = false;
			head.visible = false;
			head1.visible = false;
			rightLeg.visible = false;
			rightCrus.visible = false;
			leftCrus.visible = false;
			leftLeg.visible = false;
			weapon.visible = false;
			
			var sp:Sprite;
			var m:Matrix;
			for(var name:String in frameObj){
				if (name != "by" && name != "att" && name!= "label"){
					sp = this[name];
					sp.visible = true;
					m = sp.transform;
					if (m == null){
						m = new Matrix();
					}
					m.a =  frameObj[name][0];
					m.b = frameObj[name][1];
					m.c = frameObj[name][2];
					m.d = frameObj[name][3];
					m.tx = frameObj[name][4];
					m.ty = frameObj[name][5];
					sp.transform = m;
				}
			}
			by = frameObj["by"];
			att = frameObj["att"];
			
			if (Cfg.showBy){
				byRect.setData(by);
			}
			
			if (Cfg.showAtt){
				attRect.setData(att);
			}
		}
		
		public function nextFrame():void
		{
			if (isExplode) return;
			curFrame ++;
			if (curFrame >= roleObj.length){
				curFrame = 0;
			}
			childGotoAndStop(curFrame);
		}
		
		/**
		 * 尸体爆炸
		 */
		public function explode(roleVo:RoleVo):void
		{
			isExplode = true;
			var len:int = strList.length;
			for (var i:int = 0; i < len; i++)
			{
				var part:RolePart = this[strList[i]];
				part.explode(roleVo);
			}
			frameUpdate();
		}
		
		public function frameUpdate():void
		{
			if (isExplode){
				var len:int = strList.length;
				for (var i:int = 0; i < len; i++)
				{
					var part:RolePart = this[strList[i]];
					part.frameUpdate();
				}
			}
		}
	}
}