package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import flash.ui.Mouse;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class MouseController extends Entity
	{
		//public var breadImage:Image = new Image(Assets.CURSOR_BREAD);
		//public var handImage:Image = new Image(Assets.CURSOR_HAND);
		public var nearestCircleEntity:CircleEntity;
		
		public function MouseController() 
		{
			//breadImage.centerOO();
			//handImage.centerOO();
			type = 'mouse_controller';
			layer = -1000;
		}
		
		override public function update():void
		{
			x = FP.world.mouseX;
			y = FP.world.mouseY;
			
			//var overlapAsteroid:Asteroid = collide('asteroid', x, y) as Asteroid;
			//
			//if (overlapAsteroid)
			//{
				//if (Input.mousePressed)
					//overlapAsteroid.destroy();
			//}			
			
			if (Input.mousePressed)
			{
				nearestCircleEntity = FP.world.nearestToEntity('circle_entity', this, false) as CircleEntity;
				nearestCircleEntity.fireBullet();
			}
			
			super.update();
		}		
	}

}