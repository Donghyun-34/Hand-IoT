import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;

LeapMotion leap;
ArrayList<String> ban_stid = new ArrayList<String>( Arrays.asList("011111", "111111", "000000", "011111", "00") );
 
void setup(){
  size(800, 500);
  background(255);
  leap = new LeapMotion(this);
  leap.allowGestures("swipe, circle");
}

void draw(){
 background(0);
 long fps = leap.getId();
 text(fps, 70,70);
 
 switch(Status.stage){
   case 1 :
     if( trigger() ){
       Status.stage = 2;
       Status.time_stamp = leap.getTimestamp();
       gestureInit();
     }
     break;
   
   case 2 :
     //hand_waiting(leap,0.5);
     if ( leap.getTimestamp() - Status.time_stamp > 2000000 ){
       println("Stage 2 Time-out ");
       Status.stage = 1;
       Status.time_stamp = -1;
       break;
     }
     else if ( !ban_stid.contains( static_gesture() ) && gesture_code.dy_code != "00" ){
       println("dy_code : ", gesture_code.dy_code, "   st_code : ", gesture_code.st_code);
       //do next stuff here
       Status.stage = 1;
     }
     break;
   
 }
 
}
