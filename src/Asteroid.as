package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Asteroid extends PolarMover
	{
		public static const MAX_SIZE:Number = 100;
		public static const MIN_SIZE:Number = 10;
		public static const MAX_ROT_SPEED:Number = 30;
		public static const MIN_ROT_SPEED:Number = 5;
		
		public var image:Image;
		
		public var size:Number;
		public var color:uint;
		public var speed:Number;
		public var direction:Number;
		public var rotationSpeed:Number;
		public var rotationDirection:Number;
		
		public function Asteroid() 
		{
			type = 'asteroid';
			
			// Initialize variables
			size = MIN_SIZE + FP.random * (MAX_SIZE - MIN_SIZE);
			color = FP.choose(Colors.RED, Colors.BLUE, Colors.YELLOW);
			//x = FP.random * Game.width;
			//y = FP.random * Game.height;
			do
			{
				x = FP.random * Game.width;
			} while (Math.abs(x - Global.player.x) < 100);
			do
			{
				y = FP.random * Game.height;
			} while (Math.abs(y - Global.player.y) < 100);				
			
			speed = 50;
			direction = FP.random * 360;
			
			// Create graphic
			image = Image.createRect(size, size, color, 0.5);
			this.image.centerOO();
			setHitbox(image.width, image.height, image.originX, image.originY);
			graphic = image;
		}
		
		override public function update():void
		{
			// Bullet collide
			var b:Bullet = collide('bullet', x, y) as Bullet;
			if (b)
			{
				b.destroy();
				if (b.color == this.color)
					destroy();
			}
			
			// Move
			move(FP.elapsed * speed, direction);
			
			// Wrap
			wrap();
			
			super.update();
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
		
		public function destroy():void
		{
			if (color == Colors.RED) 
				Global.totalRed += size;			
			else if (color == Colors.YELLOW) 
				Global.totalYellow += size;
			else if (color == Colors.BLUE) 
				Global.totalBlue += size;				
			Global.game.updateColorPercents();
			
			FP.world.remove(this);
		}
		
	}

}