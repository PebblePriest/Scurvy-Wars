package   {
	
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import scurvygame;
	import flash.events.Event;
	import com.greensock.*; 
	import com.greensock.easing.*;
	
	
	public class scurvydoc extends MovieClip {
		private var startMenu:StartScreen = new StartScreen();
		private var startClip:introclip = new introclip();
		
		public function scurvydoc() {
			// constructor code
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			createStartMenu();
		}
		
		private function createStartMenu():void{
			
			
			addChild(startMenu);
			
			
			
			startMenu.startButton.addEventListener(MouseEvent.CLICK, startGameHandler);//Links the button press to the intro clip
		}
		
		private function startGameHandler(evt:MouseEvent):void
		{	
			removeChild(startMenu);//removes start screen
			
			addChild(startClip);//add intro clip
			startClip.x = 200;
			startClip.y = 200;
			startClip.gotoAndPlay(1);
			TweenMax.to(startClip, 1, {delay:11.5, colorMatrixFilter:{colorize:0xff0000, amount:1, contrast:3}});
			
			addEventListener(Event.ENTER_FRAME, update);//looks for when to stop the intro clip
			
			//removeChild(evt.currentTarget.parent);
			
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);
			
			
		}
		
		private function update(evt:Event):void{
			if(startClip.currentFrame == 300){//end of the intro clip animation
				
				removeChild(startClip);//removes intro
				
				createGame();//runs game
			}
		}
		
		private function createGame():void
		{
			var game:scurvygame = new scurvygame();
			
			addChild(game);
		}
	}
	
}
