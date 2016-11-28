package laya.d3.core.particleShuriKen.module {
	import laya.d3.math.Vector4;
	
	/**
	 * <code>ColorOverLifetime</code> 类用于粒子的生命周期颜色。
	 */
	public class ColorOverLifetime {
		/**@private */
		private var _color:GradientColor;
		
		/**是否启用。*/
		public var enbale:Boolean;
		
		/**
		 *获取颜色。
		 */
		public function get color():GradientColor {
			return _color;
		}
		
		/**
		 * 创建一个 <code>ColorOverLifetime</code> 实例。
		 */
		public function ColorOverLifetime(color:GradientColor) {
			_color = color;
		}
	
	}

}