package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Player extends TopDownMover
	{
		public var redCircle:CircleEntity;
		public var blueCircle:CircleEntity;
		public var yellowCircle:CircleEntity;
		
		public function Player(x:Number = 0, y:Number = 0) 
		{
			super(x, y, Image.createCircle(4, Colors.GREEN));
			FP.world.add(redCircle = new CircleEntity(x, y, 90, Colors.RED));
			FP.world.add(yellowCircle = new CircleEntity(x, y, 210, Colors.YELLOW));
			FP.world.add(blueCircle = new CircleEntity(x, y, 330, Colors.BLUE));
			layer = -100;
			
			FP.console.watch('speed', 'destination');
		}
		
		override public function added():void
		{
			trace('player added');
			super.added();
		}
		
		override public function update():void
		{
			//if (x < 0) x = FP.width;
			super.update();
		}
		
		public function wrap():void
		{
			//if (x
		}
		
		override public function render():void
		{
			//Draw.circlePlus(x, y, redCircle.radius +redCircle.distance, Colors.RED, 1, false, 3);
			//Draw.circlePlus(x, y, yellowCircle.radius +yellowCircle.distance, Colors.YELLOW, 1, false, 3);
			//Draw.circlePlus(x, y, blueCircle.radius + blueCircle.distance, Colors.BLUE, 1, false, 3);
			//super.render();
			redCircle.render();
			blueCircle.render();
			yellowCircle.render();
		}
		
	}

}