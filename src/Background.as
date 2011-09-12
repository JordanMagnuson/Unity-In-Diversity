package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Background extends Entity
	{
		public var backdrop:Backdrop = new Backdrop(Assets.BACKGROUND);
		
		public function Background() 
		{
			graphic = backdrop;
		}
		
	}

}