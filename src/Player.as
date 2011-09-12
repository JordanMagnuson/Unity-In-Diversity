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
		
		public var circle01:CircleEntity;
		public var circle02:CircleEntity;
		public var circle03:CircleEntity;
		
		public function Player(x:Number = 0, y:Number = 0) 
		{
			super(500, x, y, Image.createCircle(4, Colors.GREEN));
			FP.world.add(circle01 = new CircleEntity(x, y, 90, Colors.RED));
			FP.world.add(circle02 = new CircleEntity(x, y, 210, Colors.YELLOW));
			FP.world.add(circle03 = new CircleEntity(x, y, 330, Colors.BLUE));			
		}
		
		override public function added():void
		{
			trace('player added');
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
			//Draw.circlePlus(x, y, 4, Colors.RED, 1, true);
			//super.render();
			circle01.render();
			circle02.render();
			circle03.render();
		}
		
	}

}