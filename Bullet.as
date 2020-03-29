package  {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import PlayerUnit;
	
	public class Bullet extends MovieClip{
			
		private var stageRef:Stage;//if bullet leaves border
		private var speed:Number = 10; //speed of bullet movement
		private var xVel:Number = 0; //x velocity
		private var yVel:Number = 0; //y velocity
		private var rotationInRadians = 0;
		public var direction:Number;
	
	
		
		public function Bullet(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number){
			// constructor code
				this.stageRef = stageRef;
			
				
				
				
				this.x = X ;
				this.y = Y + 10;
			
			/*else if (direction == 1){
a				this.y = Y + 30;aad
			/*/
			
			
			this.rotation = rotationInDegrees;
			this.rotationInRadians = rotationInDegrees * Math.PI / 180; //converts degrees to radians, for purpose of trig
		}
		public function setDirection (sentDirection:Number):void{
			
			direction = sentDirection;
			
			
		}
		
		public function loop():void{
			xVel = Math.cos(rotationInRadians) * speed;//get the xVel from speed and rotation
			yVel = Math.sin(rotationInRadians) * speed;//same for yVel
			
			
			x += xVel * direction;//to tell which way the character is facing
			//update the bullet position
			y += yVel;
			
			
			/*setDirection();*/
		
			if(x > 580 || x < 1 || y > stageRef.stageHeight || y < 0)
			{
				this.parent.removeChild(this);//remove bullet when it hits edge of screen 
			}
			
			//if(PlayerUnit.getDirection() == -1)
			//{
			//	direction = 
			//}
		}
		
		
		//code for most of this found on https://as3gametuts.com/2013/07/10/top-down-rpg-shooter-4-shooting/
	}
	
}
