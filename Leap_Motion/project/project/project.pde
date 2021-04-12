import de.voidplus.leapmotion.*;
import java.util.*;
import java.util.Arrays;


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
 long fps = leap.getId();
 ArrayList count = new ArrayList();
 for (Hand hand : leap.getHands ()) { count = hand.getOutstretchedFingers();} // Counting Finger
 for(Hand hand : leap.getHands()){ 
  
    if(hand.getGrabStrength()==1.000&&fps%10==0){
        a = hand.getGrabStrength();
        TriggerPoint.arr.add(a);
    }
    else if(fps%30==0) {TriggerPoint.arr.add(a);}
    
    if(TriggerPoint.arr.size()==3){
      println(TriggerPoint.arr);
      println(TriggerPoint.arr2);
      boolean start = Arrays.equals(TriggerPoint.arr.toArray(), TriggerPoint.arr2.toArray());
      println(start);
      if(start == true){println("Success");}
    }
    
    if(hand.getTimeVisible()<=1||TriggerPoint.arr.size()==3){TriggerPoint.arr.clear();}   
  }
}
