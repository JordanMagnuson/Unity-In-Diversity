package  
{
	import MouseController;
	/**
	 * ...
	 * @author ...
	 */
	public class Global 
	{	
		public static const SCREEN_EDGE_BUFFER:Number = 100;	// Buffer at edge of screen, before destroying entities
		
		// Global variables
		public static var level:Number = 0;
		public static var numberOfAsteroids:Number;
		
		// Level variables
		public static var totalRed:Number;
		public static var totalBlue:Number;
		public static var totalYellow:Number;
		public static var totalColor:Number;
		
		public static var percentRed:Number;
		public static var percentBlue:Number;
		public static var percentYellow:Number;
		public static const PERCENT_BUFFER:Number = 0.02;	// If the percentages are balanced within this amount, will be considered balanced. eg if .1, color will be considered to be in balanced from .23 to .43, rather than just at .33
		
		public static var asteroidAlarmTime:Number = 5;
		public static const ASTEROID_ALARM_CHANGE_TIME:Number = 0.1
		public static const ASTEROID_ALARM_MIN_TIME:Number = 0.1;
		
		// Level entities
		public static var game:Game;
		public static var player:Player;
		public static var mouseController:MouseController;
	}

}