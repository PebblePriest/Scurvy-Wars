package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	public class PlayerUnit extends MovieClip {
		private var unit:MovieClip;
		public var gravity:int = 0;
		public var dock:int = 80;
		private var speed:Number = 6;
		private var aDown:Boolean = false;
		private var dDown:Boolean = false;
	
		
		
		public function PlayerUnit() {
			// constructor code
			
			unit = new player();//character
			addChild(unit);
			
			
		}
		
		public function grav():void
			{
				//trace(gravity);
				unit.y += gravity;//applies gravity to the character
				if(unit.y + unit.height/2 < dock)
				gravity++;
				else 
				{
					gravity = 0;
					unit.y = dock - unit.height / 2;
				}
				
				
				
			}
							
			
			
		
			public function movement(evt:KeyboardEvent):void//applies character animation
			{
				var unitLabel:String = unit.currentLabel;
				//trace(unitLabel);
				
				if(evt.keyCode == 65){// walking animation for left through a key
					aDown = true;
					unit.gotoAndStop("WalkLeft");
					dDown = false;
					
				}
				if(evt.keyCode == 68){//walking animation for right through d key
					
				
					dDown = true;
					unit.gotoAndStop("WalkRight")
					aDown = false;
					
					}// d key
				if(evt.keyCode == 32 && unit.y + unit.width / 2 ){//jumping animation through spacebar
					{
						unit.gravity = -10;
						unit.gotoAndStop("Jump");
					}
				
				
				}
				
			}
			public function stand(evt:KeyboardEvent):void//stops animation
			{
				if(evt.keyCode == 65)
				{
					aDown = false;
					unit.gotoAndStop("Stand")// a key
				}
				if(evt.keyCode == 68)// d key
				{
					dDown = false;
					unit.gotoAndStop("Stand2")
				}
				
				
			}
			public function getDirection():Number{//helps apply direction for bullets to move, passed to main file so it can be passed to bullet
				var direct:Number;
				if(aDown == true)
				{
					direct = -1;
				}
				else if(dDown == true)
					{
						direct = 1;
					}
				
				return direct;
				
				
			}
		}
		
		
			
	}
	

