import de.voidplus.leapmotion.*;
import java.util.*;


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
 trigger();

 long fps = leap.getId();
 text(fps, 70,70);
 text("11",50,70);
}

void trigger() {
 float a=0;

 ArrayList count = new ArrayList();
 for (Hand hand : leap.getHands ()) { count = hand.getOutstretchedFingers();} // Counting Finger
 for(Hand hand : leap.getHands()){ 
  
    if(hand.getGrabStrength()==1.000){
        a = hand.getGrabStrength();
        System.out.println(TriggerPoint.arr);
        TriggerPoint.arr.add(a);
    }
    else{TriggerPoint.arr.add(a);}
    
    if(hand.getTimeVisible()<=1){TriggerPoint.arr.clear();}
    println(TriggerPoint.arr.size());
    text(a,50,50);
  }
}
