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
		public static const MIN_RADIUS:Number = 10;
		public static const MAX_RADIUS:Number = 40;
		public static const RADIUS_CHANGE_SPEED:Number = 0.05;
		
		public static const DEFAULT_DISTANCE:Number = 10
		public static const MIN_DISTANCE:Number = 10;
		public static const MAX_DISTANCE:Number = 50;
		public static const DISTANCE_CHANGE_SPEED:Number = 0.2;
		
		
		public var radius:Number;
		public var orbitPoint:Point;
		public var distance:Number;
		public var direction:Number;
		public var color:uint;
		
		public function CircleEntity(orbitPointX:Number = 0, orbitPointY:Number = 0, direction:Number = 0, color:uint = 0xFFFFFF) 
		{
			this.type = 'circle_entity';
			this.radius = DEFAULT_RADIUS;
			this.distance = DEFAULT_DISTANCE;
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
			
			var change:Number;
			switch (color)
			{
				case Colors.RED:
					change = (Global.percentRed - 1 / 3);
					break;
				case Colors.YELLOW:
					change = (Global.percentYellow - 1 / 3);
					break;
				case Colors.BLUE:
					change = (Global.percentBlue - 1 / 3);
					break;
				default:
					break;
			}
			
			// Return to defaults if within buffer range of balanced
			if (Math.abs(change) < Global.PERCENT_BUFFER)
			{
				if (radius < DEFAULT_RADIUS - RADIUS_CHANGE_SPEED)
					radius += RADIUS_CHANGE_SPEED;
				else if (radius > DEFAULT_RADIUS + RADIUS_CHANGE_SPEED)
					radius -= RADIUS_CHANGE_SPEED;
				else
					radius = DEFAULT_RADIUS;
					
				if (distance < DEFAULT_DISTANCE - DISTANCE_CHANGE_SPEED)
					distance += DISTANCE_CHANGE_SPEED;
				else if (distance > DEFAULT_DISTANCE + DISTANCE_CHANGE_SPEED)
					distance -= DISTANCE_CHANGE_SPEED;	
				else
					distance = DEFAULT_DISTANCE;
					
				return;
			}
			
			// Radius
			radius += RADIUS_CHANGE_SPEED * FP.sign(change);
			if (radius < MIN_RADIUS)
				radius = MIN_RADIUS;
			else if (radius > MAX_RADIUS)
				radius = MAX_RADIUS;
			
			// Distance
			distance -= DISTANCE_CHANGE_SPEED * FP.sign(change);
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