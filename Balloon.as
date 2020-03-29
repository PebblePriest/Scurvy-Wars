package 
{
	import flash.display.MovieClip;
	import Particle;
	import flash.events.Event;	
	
	public class Balloon extends Particle
	{
		
		public var bobValue:Number;
		public var status:String;
		
		public function Balloon()
		{
			status = "OK";
			bobValue = 3;
			
			xVel = 0;
			yVel = 0;
			airResistance = 1;
			gravity = 0;
			gotoAndStop(1);
		}
		
		public function destroy():void
		{
			gotoAndPlay(2);
			gravity = 0.75;
			status = "Dead";
		}
		
		public override function update():void
		{
			if (status != "Dead")
			{
				yVel = Math.sin(1) * bobValue;
			}
			else{
				yVel++;
				xVel++;
			}
			
			super.update();
			
			if (status == "HitCrate")
			{
				trace("Filthy Pirate Escaped!");
				
				dispatchEvent(new Event(Particle.PURGE_EVENT, true, false));
			}
		}
	}
}