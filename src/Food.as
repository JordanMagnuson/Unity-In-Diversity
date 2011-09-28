package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Food extends Entity
	{
		public const ORIGINAL_SIZE:Number = 142;
		
		//public var image:Image = new Image(Assets.TRIANGLE_142);
		public var image:Image;
		public var color:uint;
		
		public function Food(x:Number = 0, y:Number = 0, color:uint = 0xFFFFFF, size:Number = 142) 
		{
			super(x, y);
			type = 'food';
			this.color = color;
			
			// Create graphic
			image = Image.createCircle(size, color);
			image.centerOO();
			originX = size;
			originY = size;
			width = height = size * 2;
			graphic = image;
		}
		
		override public function update():void
		{
			//image.angle += 1;
			super.update();
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}