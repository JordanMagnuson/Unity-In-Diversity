package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class TopDownMover extends Entity
	{
		public var speed:Number;
		public var image:Image;
		
		public function TopDownMover(speed:Number, x:Number = 0, y:Number = 0, image:Image = null) 
		{
			super(x, y, image);
			this.image = image;
			this.speed = speed;
			type = 'top_down_mover';
			layer = -1;
			
			// Initialize image, hitbox
			this.image.centerOO();
			setHitbox(image.width, image.height, image.originX, image.originY);

			Input.define('U', Key.UP, Key.W);
			Input.define('D', Key.DOWN, Key.S);
			Input.define('L', Key.LEFT, Key.A);
			Input.define('R', Key.RIGHT, Key.D);
		}
		
		override public function update():void
		{
			var xMove:Number = 0;
			var yMove:Number = 0;
			
			// Determine move distance
			if (Input.check('U'))
				if (Input.check('L'))  
				{
					yMove = -speed * Math.sin(Math.PI/4) * FP.elapsed;					
					xMove = -speed * Math.cos(Math.PI / 4) * FP.elapsed;
				}
				else if (Input.check('R'))
				{
					yMove = -speed * Math.sin(Math.PI/4) * FP.elapsed;					
					xMove = speed * Math.cos(Math.PI/4) * FP.elapsed;					
				}
				else
					yMove = -speed * FP.elapsed;
			else if (Input.check('D'))
				if (Input.check('L')) 
				{
					yMove = speed * Math.sin(Math.PI/4) * FP.elapsed;					
					xMove = -speed * Math.cos(Math.PI/4) * FP.elapsed;
				}
				else if (Input.check('R'))
				{
					yMove = speed * Math.sin(Math.PI/4) * FP.elapsed;					
					xMove = speed * Math.cos(Math.PI/4) * FP.elapsed;					
				}
				else
					yMove = speed * FP.elapsed;
			else if (Input.check('L'))
				xMove = -speed * FP.elapsed;
			else if (Input.check('R'))
				xMove = speed * FP.elapsed;
			
			// Check collisions
			for (var i:int = 0; i <= Math.abs(xMove); i++)
			{
				if (!collide('solid', x + 1 * FP.sign(xMove), y))
					x = x + 1 * FP.sign(xMove);
			}
			for (i = 0; i <= Math.abs(yMove); i++)
			{
				if (!collide('solid', x, y + 1 * FP.sign(yMove)))
					y = y + 1 * FP.sign(yMove);
			}			
			
			// Wrap
			if (x < 0)
				x = Game.width;
			else if (x > Game.width)
				x = 0;		
			if (y < 0)
				y = Game.height;				
			else if (y > Game.height)
				y = 0;			
			
			super.update();
		}
		
	}

}