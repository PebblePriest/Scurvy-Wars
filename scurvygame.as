package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import Balloon;
	import Particle;
	import PlayerUnit;
	import Bullet;
	import flash.display.SimpleButton;
	import com.greensock.plugins.EndArrayPlugin;
	
	
	
	
	public class scurvygame extends MovieClip {
		
		private var currentStage:MovieClip;//main level
		
		private var balloons:Array;//enemies array
		
		private var balloonsLayer:Sprite;//enemies image
		
		private var boxes = new Oboxes();//health bar associated, main base in sense

		private var speed:Number = 6;//how fast bullet moves/ character
		
		private var aDown:Boolean = false;//if you are pressing a 
		
		private var dDown:Boolean = false;// if you are pressing d
		
		public var vx:Number;
		
		public var vy:Number;
		
		public var bulletList:Array = [];//array for multiple bullets
		
		private var char:PlayerUnit = new PlayerUnit();	//character

		private var death = new Death();//death animation
		
		private var difficulty:Number;//difficulty number, to increase spawns
		
		private var difficultyRate:Number;
		
		private var balloonSpawnDelay:Number;//how long between spawns
		
		private var balloonSpawnCounter:Number;//how many enemies are present
		
		public var collisionHasOccured:Boolean = false;//tell is something has touched
		
		public var score:Number = 0;//score variable to store your points
		
		private var gameScore:TextField;//game score field
		
		private var healthScore:TextField;//health bar
		
		private var endscreen:MovieClip;//end screen
		
		private var charsize:Number;//for collision against edge of screen 
		
		private var xVel:Number = 0;//velocity while moving sideways
		
		private var hb:MovieClip;//health bar
		
		public var endthescreen:Boolean = false;//tells if the screen is end
		
		
		//private var bullet:Bullet = new Bullet();
		
		
		
		public function scurvygame() {
			// constructor code
			balloons = new Array();//enemies values
			difficultyRate = 0.3;
			difficulty = 1;
			balloonSpawnDelay = balloonSpawnCounter = 100;
			
			
			currentStage = new Level1();//adds the stage
			currentStage.x = 10;
			currentStage.y = 0;
			addChildAt(currentStage,0);
						
			gameScore = new TextField;//game score
			gameScore.width = 200;
			gameScore.text = "Score: 0";
			
			gameScore.x = 200;
			gameScore.y = 35;
			addChildAt(gameScore, 1);
			
			hb = new HealthBar();
			healthScore = new TextField;
			healthScore.width = 200;
			healthScore.text = "Health: "
			healthScore.x = 200;
			healthScore.y = 60;
			addChildAt(healthScore,1);
			
			hb.x = 330;//add the boxes
			hb.y = 100;
			addChildAt(hb, 1);
			
			boxes.x = 25;
			boxes.y = 270;
			addChildAt(boxes,1);
			
			char.x = 200;
			char.y = 225;
			addChild(char);
			charsize = char.width/2;
			
			
			
			
			balloonsLayer = new Sprite();
			addChild(balloonsLayer);
			
			
			
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addEventListener(Event.ADDED_TO_STAGE, addStage);
			addEventListener(Event.ENTER_FRAME, update);
			//endScreen();
		
		}
		public function addStage(evt:Event):void {//to get rid of an error, had to put all these here
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeysDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeysUp);
			stage.addEventListener(MouseEvent.CLICK, fire, false, 0, true);
			stage.addEventListener(Event.ENTER_FRAME, loop, false, 0 ,true);
			
			
		}
		public function loop(evt:Event):void{//creates bullets in array
			
			
				if(bulletList.length > 0)//if there are any bullets included in the array
			{
				for(var m:int = bulletList.length-1; m >= 0; m--)
				{
					
					
						bulletList[m].loop();
					
				}
			}
			for(var i:int = 0; i < balloonsLayer.numChildren;i++){//enemy collision, removing bullet
				if(balloonsLayer.getChildAt(i) is Balloon){
					var thisballoon:Balloon = balloonsLayer.getChildAt(i) as Balloon;
					for(var j:int = bulletList.length - 1; j >= 0; j--){
						if(thisballoon.hitTestObject(bulletList[j])){
							
					
						//trace("hit");
						thisballoon.status = "Dead";
						bulletList[j].parent.removeChild(bulletList[j]);
							}
					}
				}
			}
			
				
			
		}
		
		
		public function enterFrame(evt:Event):void
			{
				
				char.grav();
				
				if(aDown)
					char.x -= speed;
					
				
				if(dDown)
					char.x += speed;
			
					
				checkStageBoundaries();
				
			}
			public function onKeysDown(evt:KeyboardEvent):void
			{
			
				var charLabel:String = char.currentLabel;
				//trace(charLabel);
				
				if(evt.keyCode == 65){// a key
					aDown = true;
					
					dDown = false;
					
				}
				if(evt.keyCode == 68){//d key
					
					dDown = true;
					
					aDown = false;
					}// d key
				if(evt.keyCode == 32 && char.y + char.width / 2 ){//space bar
					
						char.gravity = -10;
					}
				char.movement(evt);	//applies animations
					
			}
			public function onKeysUp(evt:KeyboardEvent):void
			{
				if(evt.keyCode == 65)
				{
					aDown = false;
					// a key
				}
				if(evt.keyCode == 68)// d key
				{
					dDown = false;
				}
					char.stand(evt);
				
			}
			
			private function fire (evt:MouseEvent):void{
				
				var bullet:Bullet = new Bullet(stage, char.x, char.y, char.rotation);
				bullet.direction = char.getDirection();
				bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
				bulletList.push(bullet);//adds bullet to array
				addChild(bullet);
			
				
		
			}
			private function bulletRemoved(evt:Event):void{
				evt.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved);//removes the event listener
				bulletList.splice(bulletList.indexOf(evt.currentTarget),1);//remove bullet from array
			}
			
			
			private function checkStageBoundaries():void{
				
				if(char.x - charsize < 0)
					char.x = 0 + charsize;
				else if (char.x + charsize > 580)
					char.x = 580 - charsize;
				
			}
			private function makeBalloons():void
		{
			balloonSpawnCounter++;
			
			if (balloonSpawnCounter > balloonSpawnDelay)
			{
				balloonSpawnCounter = 0;
				balloonSpawnDelay -= difficultyRate;
				difficulty += difficultyRate;
				makeBalloon();
			}
		}
			private function makeBalloon():void
		{
			var i:int;
			for (i = 0; i < Math.floor(difficulty); i++)
			{
				var newBalloon:Balloon = new MouseBalloon();
				
				newBalloon.x = 600;
				newBalloon.y = 270;
				
				newBalloon.xVel = (-Math.random() * difficulty) - 5;
				
				newBalloon.bobValue = Math.random() * 0;
				
				newBalloon.addEventListener(Particle.PURGE_EVENT, purgeBalloonHandler);
				
				balloonsLayer.addChild(newBalloon);
				balloons.push(newBalloon);
			}
		}	private function purgeBalloonHandler(evt:Event):void
		{
			var targetBalloon:Particle = Particle(evt.target);
			purgeBalloon(targetBalloon);
		}
			private function purgeBalloon(targetBalloon:Particle):void
		{
			targetBalloon.removeEventListener(Particle.PURGE_EVENT, purgeBalloonHandler);
			if(targetBalloon.y > 300){//checks stage location to increase the score
				score += 10;
				gameScore.text = "Score: " + score;
				trace(score);
			}
			try
			{
				var i:int;
				for (i = 0; i < balloons.length; i++)
				{
					if (balloons[i].name == targetBalloon.name)
					{
						balloons.splice(i, 1);
						balloonsLayer.removeChild(targetBalloon);
						i = balloons.length;
					}
				}
			}
			catch(e:Error)
			{
				trace("Failed to delete balloon!", e);
			}
		}
		private function update(evt:Event):void
		{
			endscreen = new EndScreen();
			
			for each (var balloon:Particle in balloons)
			{
				balloon.update();
			}
			
			
			
			makeBalloons();
			 
			for(var i:int = 0; i < balloonsLayer.numChildren;i++){
				var counter:int;
			
				if(balloonsLayer.getChildAt(i) is Balloon){//this all results in the end screen
					var thisballoon:Balloon = balloonsLayer.getChildAt(i) as Balloon;
					
						if(thisballoon.hitTestObject(boxes)){//makes the enemies hit the boxes
							thisballoon.status = "HitCrate";
							hb.nextFrame();
							if(hb.currentFrame == 4)
							{
								
								addChildAt(endscreen,1);
								endscreen.x = 245;
								endscreen.y = 190;
								removeChild(healthScore);
								removeChild(boxes);
								removeChild(balloonsLayer);//Stop Game
								removeChild(char);
								removeChild(currentStage);
								removeEventListener(Event.ENTER_FRAME, enterFrame);
								removeEventListener(Event.ADDED_TO_STAGE, addStage);
								removeEventListener(Event.ENTER_FRAME, update);
								stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeysDown);
								stage.removeEventListener(KeyboardEvent.KEY_UP, onKeysUp);
								stage.removeEventListener(MouseEvent.CLICK, fire);
								stage.removeEventListener(Event.ENTER_FRAME, loop);
								death.x = 250;
								death.y = 225;
								addChild(death);
								death.gotoAndPlay(1);
								gameScore.x = 250;
								gameScore.y = 125;
								endthescreen = true;
								
								endscreen.resetbtn.addEventListener(MouseEvent.CLICK, restart);
							
								
								
								
							}
						
						
						
							
					}
				}
			}
		}	
		private function restart(event: MouseEvent): void{
			freshgame();
			removeEventListener(MouseEvent.CLICK, restart);
		}
		private function freshgame():void{
			 var game:scurvygame = new scurvygame();
			addChild(game);
		}	
			
		
		
		}
	}	
	