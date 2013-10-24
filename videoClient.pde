import processing.video.*;
import processing.net.*;

Movie stimulus;
Client myClient;
boolean moviePlaying = false;
float timeOffset;


void setup()
{
  size(1024, 768);
  stimulus = new Movie(this, "CheeziPuffs.mov");
  myClient = new Client(this, "127.0.0.1", 5204);
  
}


void draw()
{
  println("AVAILABLE = " + myClient.available());
  if(myClient.available() > 0)
    {
      String[] incomingMessages = splitTokens(myClient.readString());
      println(incomingMessages);
      float currentServerMovieTime = 0;
      if(incomingMessages[0].equals("play") != true && incomingMessages.length > 0)
        {
        if(incomingMessages.length > 1)
          {
            currentServerMovieTime = float(incomingMessages[1]);
          }else{
            currentServerMovieTime = float(incomingMessages[0]);
          }
         println(currentServerMovieTime);
        }else if(incomingMessages[0].equals("play"))
        {
          stimulus.play();
          moviePlaying = true;
        }
        
      if(moviePlaying == true)
        {
          timeOffset = stimulus.time() - currentServerMovieTime;
          println("TIME OFFSET = " + timeOffset + " CURRENT CLIENT TIME = " + stimulus.time() + " CURRENT SERVER MOVIE TIME = " + currentServerMovieTime);
        }
    }
 
 if (stimulus.available() == true) 
      {
        stimulus.read();
      }
      
   image(stimulus, 0, 0, width, height);
   text(stimulus.time(), width/2, height/2);
   text(timeOffset, width/2, height/2 +40);

}


