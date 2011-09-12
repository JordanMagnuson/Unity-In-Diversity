package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import flash.ui.Mouse;
	
	public class Main extends Engine
	{
		public function Main() 
		{
			super(800, 500, 60);
			FP.screen.color = Colors.BLACK;
			
			// Console for debugging
			FP.console.enable();		
			
			FP.world = Global.game = new Game;
			
			//Mouse.hide();
		}
		
		//override public function init():void
		//{
			//super.init();
		//}
	}
}