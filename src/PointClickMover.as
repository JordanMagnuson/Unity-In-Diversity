package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PointClickMover extends Entity
	{
		public var speed:Number;
		public var moveKey:int;
		public var destination:Point;
		public var motionTween:LinearMotion;
		
		public function PointClickMover(x:Number = 0, y:Number = 0, graphic:Graphic = null, speed:Number = 500, moveKey:int = 0) 
		{
			super(x, y, graphic);
			this.speed = speed;
			this.moveKey = Key.SPACE;
			this.destination = new Point(x, y);
			this.motionTween = new LinearMotion;
		}
		
		override public function added():void
		{
			addTween(motionTween);
			motionTween.x = x;
			motionTween.y = y;
			//motionTween.setMotion(x, y, destination.x, destination.y, 1, Ease.quadInOut);
		}
		
		override public function update():void
		{
			x = motionTween.x;
			y = motionTween.y;
			
			if (Input.mousePressed && Input.check(moveKey))
			{
				destination.x = FP.world.mouseX;
				destination.y = FP.world.mouseY;
				trace('location: ' + x + ', ' + y);
				trace('destination: ' + destination);
			}
			
			motionTween.setMotionSpeed(x, y, destination.x, destination.y, speed);
			
			super.update();
		}
		
	}

}