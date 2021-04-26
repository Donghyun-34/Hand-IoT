import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;

LeapMotion leap;
 
void setup(){
  size(800, 500);
  background(255);
  leap = new LeapMotion(this);
  leap.allowGestures("swipe, circle");
  // leap = new LeapMotion(this).allowGestures("circle, swipe, screen_tap, key_tap");
  // leap = new LeapMotion(this).allowGestures("swipe");  // Leap detects only swipe gestures
}

void draw(){
 background(0);
 //if(Iot Serial no signal){
 long fps = leap.getId();
 text(fps, 70,70);
 if( trigger() ){
   hand_waiting(leap,0.5);
   static_gesture();
   
   println("dy_code : ", gesture_code.dy_code, "   st_code : ", gesture_code.st_code);
   gesture_code.dy_code = gesture_code.st_code = "00";
  }
}
