package dyzm.data.skill
{
	import dyzm.data.RoleState;
	import dyzm.data.SkillData;
	import dyzm.data.role.RoleVo;
	import dyzm.manager.Evt;
	
	import laya.maths.Point;
	
	public class SkillBlock extends BaseSkillVo
	{
		/**
		 * 技能唯一标识
		 */
		public static const id:String = "格挡";
		/**
		 * 名称
		 */
		public static const name:String = "格挡";
		
		/**
		 * 所属系
		 */
		public static const xi:int = SkillData.XI_TI;
		
		/**
		 * 启动状态
		 */
		public static const startState:int = SkillData.FLOOR;
		
		/**
		 * 帧名称
		 */
		public static const frameName:String = "格挡";
		
		/**
		 * 可以打断的后摇
		 */
		public const CAN_CANCEL_AFTER:Array = [];
		
		/**
		 * 该技能的后续技能可出招的时间范围
		 */
		public const SKILL_COMBO_TIME:int = 0;
		
		public function SkillBlock()
		{
			super();
			attSpot.isFly = false;
			attSpot.x = 300;
			attSpot.xFrame = 10;
			attSpot.z = -15;
			attSpot.upY = 40;
			attSpot.downY = 40;
			attSpot.stiffDecline = 0;
			attSpot.zDecline = 0;
			attSpot.attDecline = 0;
			attSpot.armorDecline = 0;
			attSpot.stiffFrame = 60;
			attSpot.curAttSpot = 1;
			attSpot.range = 8;
			attSpot.canTurn = false;
			
			attSpot.attFireRotation = 100;
			
			attSpot.foeActionToHead = AttInfo.YANG_TIAN;
			attSpot.foeAction = AttInfo.YANG_TIAN;
		}
		
		/**
		 * 技能检测, 在通过初步检测后调用,进入进一步判断
		 * 初步检测包括 是否符合技能的释放位置(地面,空中,跑步),并且不在被攻击状态
		 * @return ture=可以释放
		 */
		override public function startTest():Boolean
		{
			if (roleVo.attState == RoleState.ATT_ING){
				return false;
			}
			return true;
		}
		
		/**
		 * 技能开始
		 */
		override public function start():void
		{
			attSpot.attr.minAtt = roleVo.curAttr.minAtt;
			attSpot.attr.maxAtt = roleVo.curAttr.maxAtt;
			attSpot.attr.attArmor = roleVo.curAttr.attArmor;
			attSpot.attr.iceAtt = roleVo.curAttr.iceAtt;
			attSpot.attr.fireAtt = roleVo.curAttr.fireAtt;
			attSpot.attr.thundAtt = roleVo.curAttr.thundAtt;
			attSpot.attr.toxinAtt = roleVo.curAttr.toxinAtt;
			attSpot.attr.critDmg = roleVo.curAttr.critDmg;
			
			roleVo.frameName = RoleVo.TAG_BLOCK;
			roleVo.curFrame = 1;
			roleVo.attState = RoleState.ATT_ING;
			roleVo.isRuning = false;
		}
		
		override public function run():void
		{
		}
		
		public function byHit(attRole:RoleVo, skill:BaseSkillVo, a:int, firePoint:Point, b:int):Boolean
		{
			if (roleVo.curTurn != attRole.curTurn){
				var needArmor:int = skill.attSpot.attr.attArmor >> 1;
				if (needArmor <= roleVo.curAttr.armor){
					roleVo.curAttr.armor -= needArmor;
					Evt.event(RoleVo.ADD_FIRE_EVENT, [firePoint, skill.attSpot.defFireType, roleVo.y+1, skill.attSpot.attFireRotation * attRole.curTurn]);
					
					if (type == 1){// 反震,反弹护甲伤害(该伤害不会使目标硬直)
						attRole.curAttr.armor -= skill.attSpot.attr.attArmor;
						if (attRole.curAttr.armor < 0){
							attRole.curAttr.armor = 0;
						}
					}else if(type == 2){// 反击,对方受到一次攻击,对方会硬直,计算在连击内
						Point.TEMP.x = attRole.x;
						Point.TEMP.y = attRole.y + attRole.z - attRole.h/2;
						if (attRole.byHit(roleVo, this, 1, Point.TEMP, 1)){
							roleVo.addHit(attRole);
						}
					}
					return true;
				}
			}
			return false;
		}
	}
}


