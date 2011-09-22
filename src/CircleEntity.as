package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CircleEntity extends Entity
	{	
		public static const DEFAULT_RADIUS:Number = 20;
		public static const MIN_RADIUS:Number = 1;
		public static const MAX_RADIUS:Number = 400;
		public static const RADIUS_CHANGE_SPEED:Number = 0.03;
		
		public static const DEFAULT_DISTANCE:Number = 10
		public static const MIN_DISTANCE:Number = 10;
		public static const MAX_DISTANCE:Number = 50;
		public static const DISTANCE_CHANGE_SPEED:Number = 0.1;
		
		public var health:Number = 25;
		public var healthTarget:Number = 100;
		public var HEALTH_CHANGE_DIVISOR:Number = 100000;
		
		public var radius:Number;
		public var targetRadius:Number;
		public var distance:Number;
		public var targetDistance:Number;
		
		public var orbitPoint:Point;
		public var direction:Number;
		public var color:uint;
		
		public function CircleEntity(orbitPointX:Number = 0, orbitPointY:Number = 0, direction:Number = 0, color:uint = 0xFFFFFF) 
		{
			this.type = 'circle_entity';
			this.radius = health;
			this.distance = health / 2;
			this.orbitPoint = new Point(orbitPointX, orbitPointY);
			this.direction = direction;
			this.color = color;
			//speed = 20;
			//super(FP.halfWidth, FP.halfHeight, speed);
			
		}
		
		override public function added():void
		{
			super.added();
		}
		
		override public function update():void
		{
			super.update();
			
			// Health
			health -= Global.HEALTH_DROP_PER_FRAME;
			
			// Position
			orbitPoint.x = Global.player.x;
			orbitPoint.y = Global.player.y;
			this.x = orbitPoint.x + distance * Math.cos(direction * Math.PI / 180);
			this.y = orbitPoint.y - distance * Math.sin(direction * Math.PI / 180);	// Minus here, because negative is up	
			
			// Radius and Distance
			updateRadiusDistance();
		
			//orbitRadius = distance;
		}
		
		public function fireBullet():void
		{
			trace('fire bullet');
			FP.world.add(new Bullet(x, y, color));
		}
		
		public function updateRadiusDistance():void
		{
			//trace('change: ' + change);
			
			// Return to defaults if within buffer range of balanced
			//if (Math.abs(change) < Global.PERCENT_BUFFER)
			//{
				//if (radius < DEFAULT_RADIUS - RADIUS_CHANGE_SPEED)
					//radius += RADIUS_CHANGE_SPEED;
				//else if (radius > DEFAULT_RADIUS + RADIUS_CHANGE_SPEED)
					//radius -= RADIUS_CHANGE_SPEED;
				//else
					//radius = DEFAULT_RADIUS;
					//
				//if (distance < DEFAULT_DISTANCE - DISTANCE_CHANGE_SPEED)
					//distance += DISTANCE_CHANGE_SPEED;
				//else if (distance > DEFAULT_DISTANCE + DISTANCE_CHANGE_SPEED)
					//distance -= DISTANCE_CHANGE_SPEED;	
				//else
					//distance = DEFAULT_DISTANCE;
					//
				//return;
			//}
			
			// Radius
			//targetRadius = MIN_RADIUS + (health * (MAX_RADIUS - MIN_RADIUS));
			targetRadius = health;
			var radiusChange:Number = targetRadius - radius;
			radius += RADIUS_CHANGE_SPEED * FP.sign(radiusChange);
			if (radius < MIN_RADIUS)
				radius = MIN_RADIUS;
			else if (radius > MAX_RADIUS)
				radius = MAX_RADIUS;
			
			// Distance
			targetDistance = health / 2;
			var distanceChange:Number = targetDistance - distance;
			distance += DISTANCE_CHANGE_SPEED * FP.sign(distanceChange);
			if (distance < MIN_DISTANCE)
				distance = MIN_DISTANCE;
			else if (distance > MAX_DISTANCE)
				distance = MAX_DISTANCE;		
		}
		
		override public function render():void
		{
			Draw.circlePlus(x, y, radius, color, 0.5, true);
		}		
		
	}

}