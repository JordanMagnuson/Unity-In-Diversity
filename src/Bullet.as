package  
{
	import net.flashpunk.Entity;
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
		public var size:Number;
		
		public var image:Image;
		
		public function Bullet(x:Number = 0, y:Number = 0, color:uint = 0xFFFFFF, size:Number = 1) 
		{
			super(x, y);
			type = 'bullet';			
			this.color = color;
			this.size = size;
			this.image = Image.createRect(size, size * 5, Colors.WHITE, 1);
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
			// Move
			move(FP.elapsed * speed, direction);
			
			// Offscreen
			if (checkOffScreen())
				destroy();
				
			// Collide asteroid
			var a:Asteroid = collide('asteroid', x, y) as Asteroid;
			if (a)
			{
				destroy();
				if (a.color == this.color)
				{
					a.dropFood(size * 2);
					a.damage(size * 2);
				}
			}
				
			// Wrap	
			wrap();
			
			// Super
			super.update();
		}
		
		public function checkOffScreen():Boolean
		{
			var dy:Number = Math.abs(y - Global.player.y);
			if (dy > Game.height / 2)
				dy = Game.height - dy;		
			if (dy > FP.height / 2)
				return true;
				
			var dx:Number = Math.abs(x - Global.player.x);
			if (dx > Game.width / 2)
				dx = Game.width - dx;
			if (dx > FP.width / 2)
				return true;
				
			return false;
		}
		
		/**
		 * Updated distanceFrom to take wrapping world into account.
		 * @param	e
		 * @param	useHitboxes
		 * @return
		 */
		override public function distanceFrom(e:Entity, useHitboxes:Boolean = false):Number
		{
			var dx:Number = Math.abs(x - e.x);
			if (dx > Game.width / 2)
				dx = Game.width - dx;
			var dy:Number = Math.abs(y - e.y);
			if (dy > Game.height / 2)
				dy = Game.height - dy;
			return Math.sqrt(dx * dx + dy * dy);
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
		
		//public function checkOffScreen():Boolean
		//{
			//if (x < 0 - Global.SCREEN_EDGE_BUFFER) 
				//return true;
			//else if (x > Game.width + Global.SCREEN_EDGE_BUFFER)
				//return true;
			//else if (y < 0 - Global.SCREEN_EDGE_BUFFER)
				//return true;
			//else if (y > Game.height + Global.SCREEN_EDGE_BUFFER)
				//return true;
			//return false;
		//}
		
	}

}