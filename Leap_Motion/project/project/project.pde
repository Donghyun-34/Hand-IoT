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
 //if(Iot Serial no signal){
   trigger();
 //}
 long fps = leap.getId();
 text(fps, 70,70);
}

void trigger() {
 int a = 0;
 long fps = leap.getId();
 ArrayList count = new ArrayList();
 for (Hand hand : leap.getHands ()) { count = hand.getOutstretchedFingers();} // Counting Finger
 for(Hand hand : leap.getHands()){ 
  
    if(hand.getGrabStrength()==1.000&&fps%25==0){//punch
        a = (int)hand.getGrabStrength();
        TriggerPoint.arr.add(a);
    }
    else if(fps%30==0) {TriggerPoint.arr.add(a);}//flat hand
    
    if(TriggerPoint.arr.size()==3){
    println(TriggerPoint.arr);
    println(TriggerPoint.arr2);
    boolean start = TriggerPoint.arr.equals(TriggerPoint.arr2);
    println(start);
    if(start == true){println("Success");}//connect Iot device here
    }
    

    if(hand.getTimeVisible()<=1||TriggerPoint.arr.size()==3){TriggerPoint.arr.clear();}

   
  }
}
