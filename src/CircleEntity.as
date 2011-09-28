package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	import flash.display.BlendMode;
	import net.flashpunk.graphics.Image;
	
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
		public static const MAX_DISTANCE:Number = 400;
		public static const DISTANCE_CHANGE_SPEED:Number = 0.1;
		
		public var health:Number = 25;
		public var healthTarget:Number = 100;
		public var HEALTH_CHANGE_DIVISOR:Number = 100000;
		
		public var radius:Number;
		public var targetRadius:Number;
		public var distance:Number;
		public var targetDistance:Number;
		public var bulletSize:Number;
		
		public var orbitPoint:Point;
		public var direction:Number;
		public var color:uint;
		
		public var colorTween:ColorTween;
		
		public var maskImage:Image;
		public var maskBitmapData:BitmapData;
		public var maskOffset:Point = new Point;
		
		public function CircleEntity(orbitPointX:Number = 0, orbitPointY:Number = 0, direction:Number = 0, color:uint = 0xFFFFFF) 
		{
			this.type = 'circle_entity';
			this.radius = health;
			this.distance = health / 2;
			this.orbitPoint = new Point(orbitPointX, orbitPointY);
			this.direction = direction;
			this.color = color;
			
			colorTween = new ColorTween;
			colorTween.color = this.color;
			
			//maskImage = Image.createCircle(radius + distance);
			//maskImage.centerOrigin();
			//maskOffset.x = maskImage.width / 2;
			//maskOffset.y = maskImage.height / 2;
			//maskBitmapData = new BitmapData(maskImage.width, maskImage.height, true, 0);
			//maskImage.render(maskBitmapData, FP.zero, FP.zero);
			//
			//mask = new Pixelmask(maskBitmapData);
			
			
			//speed = 20;
			//super(FP.halfWidth, FP.halfHeight, speed);
			
		}
		
		override public function added():void
		{
			addTween(colorTween);
			super.added();
		}
		
		override public function update():void
		{
			// Super
			super.update();
			
			// Health
			health -= Global.healthDropPerFrame;
			
			// Food
			var f:Food = collide('food', x, y) as Food;
			if (f)
			{
				trace('collide food');
				if (f.color == this.color)
				{
					f.destroy();
					health += 10;
					Global.player.redCircle.flashColor(f.color);
					Global.player.yellowCircle.flashColor(f.color);
					Global.player.blueCircle.flashColor(f.color);
				}
			}
			
			// Position
			orbitPoint.x = Global.player.x;
			orbitPoint.y = Global.player.y;
			this.x = orbitPoint.x + distance * Math.cos(direction * Math.PI / 180);
			this.y = orbitPoint.y - distance * Math.sin(direction * Math.PI / 180);	// Minus here, because negative is up	
			
			// Radius and Distance
			updateRadius();
			updateDistance();
			
			// Rotate
			direction += Global.rotationSpeed;
			
			// Hitbox
			//mask = new Pixelmask(Image.createCircle(distance));
			originX = radius;
			originY = radius;
			width = height = radius * 2;			
			
			// Bullet size
			bulletSize = Math.ceil(width / 10);
		}
		
		public function flashColor(color:uint, duration:Number = 2):void
		{
			colorTween.tween(duration, color, this.color);
		}
		
		public function fireBullet():void
		{
			trace('fire bullet');
			FP.world.add(new Bullet(x, y, color, bulletSize));
		}
		
		public function updateRadius():void
		{
			targetRadius = health;
			var radiusChange:Number = targetRadius - radius;
			radius += RADIUS_CHANGE_SPEED * FP.sign(radiusChange);
			if (radius < MIN_RADIUS)
				radius = MIN_RADIUS;
			else if (radius > MAX_RADIUS)
				radius = MAX_RADIUS;			
		}
		
		public function updateDistance():void
		{
			targetDistance = health / 2;
			var distanceChange:Number = targetDistance - distance;
			distance += DISTANCE_CHANGE_SPEED * FP.sign(distanceChange);
			if (distance < MIN_DISTANCE)
				distance = MIN_DISTANCE;
			else if (distance > MAX_DISTANCE)
				distance = MAX_DISTANCE;				
		}
		
		//public function updateRadiusDistance():void
		//{
			//trace('change: ' + change);
			//
			 //Return to defaults if within buffer range of balanced
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
			//
			 //Radius
			//targetRadius = MIN_RADIUS + (health * (MAX_RADIUS - MIN_RADIUS));	
		//}
		
		override public function render():void
		{
			//Draw.blend = BlendMode.ADD;
			
			// Outline
			Draw.circlePlus(Global.player.x, Global.player.y, radius + distance, color, 1, false, 3);
			
			// Center
			Draw.circlePlus(x, y, radius, colorTween.color, 0.5, true);
		}		
		
	}

}