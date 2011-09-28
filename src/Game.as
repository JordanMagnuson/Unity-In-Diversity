package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import MouseController;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Game extends World
	{
		public static var width:Number;
		public static var height:Number;
		public var zoom:Number = 1;
		
		public var background:Entity = new Entity(0, 0, new Backdrop(Assets.BACKGROUND));
		public var asteroidAlarm:Alarm;
		
		/**
		 * Camera following information.
		 */
		public const FOLLOW_TRAIL:Number = 0;
		public const FOLLOW_RATE:Number = 1;			
		
		public function Game() 
		{
			width = 1600;
			height = 1000;
			asteroidAlarm = new Alarm(Global.asteroidAlarmTime, createAsteroid);
		}
		
		override public function begin():void
		{
			//add(new Entity(0, 0, new Backdrop(Assets.BACKGROUND)));
			add(Global.player = new Player(50, 50));
			add(Global.mouseController = new MouseController);
			generateLevel();
			addTween(asteroidAlarm, true);
			
			//FP.console.watch(Global.player.x, Global.player.y, Global.player.speed);
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.NUMPAD_ADD))
			{
				zoom += 0.1;
				zoomTo(zoom);
			}
			else if (Input.pressed(Key.NUMPAD_SUBTRACT))
			{
				zoom -= 0.1;
				zoomTo(zoom);
			}			
			
			cameraFollow();
			super.update();
		}
		
		public function zoomTo(val:int):void
		{
			trace('zoom: ' + zoom);
			FP.screen.scale = val;
			//if (!((val < 0 && FP.screen.scale <= Global.CAMERA_ZOOM_MIN) || (val > 0 && FP.screen.scale >= Global.CAMERA_ZOOM_MAX)))
			//{
				//FP.screen.scale = val;
				//width = Math.ceil(1 / FP.screen.scale * FP.width);
				//height = Math.ceil(1 / FP.screen.scale * FP.height);
				//snapToPlayer(level, player);
				//FP.console.log(FP.camera.x, FP.camera.y, width, height);
			//}
		}		
		
		public function createAsteroid():void
		{
			trace('create asteroid');
			add(new Asteroid);
			var newTime:Number = Global.asteroidAlarmTime - Global.ASTEROID_ALARM_CHANGE_TIME;
			if (newTime < Global.ASTEROID_ALARM_MIN_TIME)
				newTime = Global.ASTEROID_ALARM_MIN_TIME;
			asteroidAlarm.reset(newTime);
		}
		
		public function updateColorPercents():void
		{
			Global.totalColor = Global.totalRed + Global.totalYellow + Global.totalBlue;
			if (Global.totalColor < 1)
			{
				Global.percentRed = Global.percentYellow = Global.percentBlue = 1 / 3;
				return;
			}
				
			Global.percentRed = Global.totalRed / Global.totalColor;
			Global.percentYellow = Global.totalYellow / Global.totalColor;
			Global.percentBlue = Global.totalBlue / Global.totalColor;
			trace('total red: ' + Global.totalRed + ' = ' + Global.percentRed + '%');
			trace('total yellow: ' + Global.totalYellow + ' = ' + Global.percentYellow + '%');
			trace('total blue: ' + Global.totalBlue + ' = ' + Global.percentBlue + '%');			
		}
		
		public function resetLevel():void
		{
			
		}
		
		public function generateLevel():void
		{
			trace('generate level');
			
			// Generate asteroids
			Global.totalRed = 0;
			Global.totalYellow = 0;
			Global.totalBlue = 0;
			var a:Asteroid;
			for (var i:int = 0; i < 100; i++)
			{				
				add(a = new Asteroid);
			}
			updateColorPercents();
		}
		
		override public function render():void
		{
			background.render();
			
			super.render();
			var oldX:Number = FP.camera.x;
			var oldY:Number = FP.camera.y;
			var buffer:Number = 50;
			
			// The second part of these if queries, after the || is to have a small buffer on the other side, to avoid flashes passing the border
			
			// Left
			if (Global.player.x - buffer < FP.halfWidth || Global.player.x > (Game.width - buffer))
			{
				FP.camera.x = oldX + Game.width;
				FP.camera.y = oldY;
				super.render();
				
				// Top left corner
				if (Global.player.y - buffer < FP.halfHeight || Global.player.y > (Game.height - buffer))
				{
					FP.camera.x = oldX + Game.width;
					FP.camera.y = oldY + Game.height;
					super.render();					
				}
				// Bottom left corner
				if (Global.player.y + buffer > (Game.height - FP.halfHeight) || Global.player.y < buffer)
				{
					FP.camera.x = oldX + Game.width;
					FP.camera.y = oldY - Game.height;
					super.render();					
				}				
			}
			// Right
			if (Global.player.x + buffer > (Game.width - FP.halfWidth) || Global.player.x < buffer)
			{
				FP.camera.x = oldX - Game.width;
				FP.camera.y = oldY;
				super.render();
				
				// Top right corner
				if (Global.player.y - buffer < FP.halfHeight || Global.player.y > (Game.height - buffer))
				{
					FP.camera.x = oldX - Game.width;
					FP.camera.y = oldY + Game.height;
					super.render();					
				}
				// Bottom right corner
				if (Global.player.y + buffer > (Game.height - FP.halfHeight) || Global.player.y < buffer)
				{
					FP.camera.x = oldX - Game.width;
					FP.camera.y = oldY - Game.height;
					super.render();					
				}					
			}
			// Top
			if (Global.player.y - buffer < FP.halfHeight || Global.player.y > (Game.height - buffer))
			{
				FP.camera.x = oldX;
				FP.camera.y = oldY + Game.height;
				super.render();
			}
			// Bottom
			if (Global.player.y + buffer > (Game.height - FP.halfHeight) || Global.player.y < buffer)
			{
				FP.camera.x = oldX;
				FP.camera.y = oldY - Game.height;
				super.render();
			}			
			
			FP.camera.x = oldX;
			FP.camera.y = oldY;
			
		}
		
		/**
		 * Makes the camera follow the player object.
		 */
		private function cameraFollow():void
		{
			// make camera follow the player
			FP.point.x = FP.camera.x - targetX;
			FP.point.y = FP.camera.y - targetY;
			var dist:Number = FP.point.length;
			if (dist > FOLLOW_TRAIL) dist = FOLLOW_TRAIL;
			FP.point.normalize(dist * FOLLOW_RATE);
			FP.camera.x = int(targetX + FP.point.x);
			FP.camera.y = int(targetY + FP.point.y);
			
			// keep camera in room bounds
			//FP.camera.x = FP.clamp(FP.camera.x, 0, width - FP.width);
			//FP.camera.y = FP.clamp(FP.camera.y, 0, height - FP.height);
		}
		
		/**
		 * Getter functions used to get the position to place the camera when following the player.
		 */
		private function get targetX():Number { return Global.player.x - FP.width / 2; }
		private function get targetY():Number { return Global.player.y - FP.height / 2; }			
		
	}
}