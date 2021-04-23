import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;

LeapMotion leap;
 
void setup(){
  size(800, 500);
  background(255);
  leap = new LeapMotion(this).allowGestures();  // All gestures
  // leap = new LeapMotion(this).allowGestures("circle, swipe, screen_tap, key_tap");
  // leap = new LeapMotion(this).allowGestures("swipe");  // Leap detects only swipe gestures
}

void draw(){
 background(0);
 //if(Iot Serial no signal){
   //trigger();
   static_gesture();
   
 //}
 long fps = leap.getId();
 text(fps, 70,70);

}
