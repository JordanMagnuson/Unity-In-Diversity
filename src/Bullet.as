package  
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Bullet extends PolarMover
	{
		public const DEFAULT_SPEED:Number = 500;
		
		public var speed:Number;
		public var direction:Number;
		public var color:uint
		
		public var image:Image = Image.createRect(4, 20, Colors.WHITE, 1);
		
		public function Bullet(x:Number = 0, y:Number = 0, color:uint = 0xFFFFFF) 
		{
			super(x, y);
			type = 'bullet';			
			this.color = color;
			graphic = image;
		}
		
		override public function added():void
		{
			speed = DEFAULT_SPEED;
			direction = pointDirection(x, y, FP.world.mouseX, FP.world.mouseY);
			image.angle = direction - 90;
			image.color = color;
		}
		
		override public function update():void
		{
			move(FP.elapsed * speed, direction);
			//if (checkOffScreen()) 
				//destroy();
			wrap();
			super.update();
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		public function wrap():void
		{
			if (x < 0)
				x = Game.width;
			else if (x > Game.width)
				x = 0;		
			if (y < 0)
				y = Game.height;				
			else if (y > Game.height)
				y = 0;				
		}		
		
		public function checkOffScreen():Boolean
		{
			if (x < 0 - Global.SCREEN_EDGE_BUFFER) 
				return true;
			else if (x > Game.width + Global.SCREEN_EDGE_BUFFER)
				return true;
			else if (y < 0 - Global.SCREEN_EDGE_BUFFER)
				return true;
			else if (y > Game.height + Global.SCREEN_EDGE_BUFFER)
				return true;
			return false;
		}
		
	}

}