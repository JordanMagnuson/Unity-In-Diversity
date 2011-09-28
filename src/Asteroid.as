package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Draw;
	
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
		public var health:Number;
		public var color:uint;
		public var speed:Number;
		public var direction:Number;
		public var rotationSpeed:Number;
		public var rotationDirection:Number;
		
		public var colorTween:ColorTween;
		
		public function Asteroid() 
		{
			type = 'asteroid';
			
			// Initialize variables
			size = MIN_SIZE + FP.random * (MAX_SIZE - MIN_SIZE);
			color = FP.choose(Colors.RED, Colors.BLUE, Colors.YELLOW);
			health = size;

			// Position
			do
			{
				x = FP.random * Game.width;
			} while (Math.abs(x - Global.player.x) < 100);
			do
			{
				y = FP.random * Game.height;
			} while (Math.abs(y - Global.player.y) < 100);				
			
			// Set initial speed and direction
			speed = 1 / size * 1000;
			direction = FP.random * 360;
			
			// Create graphic
			image = Image.createRect(size, size, color, 0.5);
			this.image.centerOO();
			setHitbox(image.width, image.height, image.originX, image.originY);
			graphic = image;
			
			// Tweens
			colorTween = new ColorTween();
			colorTween.color = color;
		}
		
		override public function added():void
		{
			addTween(colorTween);
		}
		
		override public function update():void
		{
			// Collide player
			var ce:CircleEntity = collide('circle_entity', x, y) as CircleEntity;
			//if (ce)
			//{
				//trace('collide: ' + ce.color);
			//}				
			
			// Color
			image.color = colorTween.color;
			
			// Move
			move(FP.elapsed * speed, direction);
			
			// Wrap
			wrap();
			
			super.update();
		}
		
		public function collidePlayer():void
		{
			//var ce:CircleEntity = collide('circle_entity', x, y) as CircleEntity;
			//if (ce)
			//{
				//b.destroy();
				//if (b.color == this.color)
					//damage();
			//}			
		}
		
		public function damage(amount:Number = 10):void
		{
			trace('asteroid damage');
			
			// Health
			health -= amount;
			if (health < Asteroid.MIN_SIZE)
			{
				destroy();
				return;
			}
				
			// Update image
			image = Image.createRect(int(health), int(health), color, 0.5);
			image.centerOO();
			setHitbox(image.width, image.height, image.originX, image.originY);	
			graphic = image;
			
			// Flash
			colorTween.tween(1, Colors.WHITE, color);
		}
		
		public function dropFood(size:Number):void
		{
			FP.world.add(new Food(x, y, color, size));
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
			FP.world.remove(this);
		}
		
		override public function render():void
		{
			super.render();
			//Draw.rect(x, y, size, size, color, 0.5);
			//Draw.circlePlus(x, y, radius, color, 0.5, true);
		}
		
	}

}