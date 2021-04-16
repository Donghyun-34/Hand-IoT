import de.voidplus.leapmotion.*;
import java.util.*;

// ======================================================
// Table of Contents:
// ├─ 1. Swipe Gesture
// ├─ 2. Circle Gesture

// ======================================================
String static_gesture(){
  Controller controller = new Controller();
  Frame frame = controller.frame();
  String outstretched="";
  
  for(com.leapmotion.leap.Hand hand : frame.hands()){
    if(hand.isRight()==true){outstretched+="1";}// righthand
    else {outstretched+="0";} // lefthand
    for(com.leapmotion.leap.Finger finger : hand.fingers()) {
      com.leapmotion.leap.Finger.Type fingerType = finger.type();
      if(finger.isExtended()==true){outstretched +="1";}
      else if(finger.isExtended()==false){outstretched +="0";}       
    }
    //println(outstretched);
  }
  return outstretched;
}


void leapOnSwipeGesture(de.voidplus.leapmotion.SwipeGesture g, int state){
  int     id               = g.getId();
  de.voidplus.leapmotion.Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector positionStart    = g.getStartPosition();
  PVector direction        = g.getDirection();
  float   speed            = g.getSpeed();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();

  ArrayList count = new ArrayList();
   
  for (de.voidplus.leapmotion.Hand hand : leap.getHands ()) {
   
      count = hand.getOutstretchedFingers();
  }

  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      println(static_gesture() + " Fingers" + " SwipeGesture: " + id); 
      break;
  }
}


// ======================================================
// 2. Circle Gesture

void leapOnCircleGesture(de.voidplus.leapmotion.CircleGesture g, int state){
  int     id               = g.getId();
  de.voidplus.leapmotion.Finger  finger           = g.getFinger();
  PVector positionCenter   = g.getCenter();
  float   radius           = g.getRadius();
  float   progress         = g.getProgress();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  int     direction        = g.getDirection();

  ArrayList count = new ArrayList();//finger count
  for (de.voidplus.leapmotion.Hand hand : leap.getHands ()) {count = hand.getOutstretchedFingers();}

  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      println("CircleGesture: " + id);
      switch(direction){
        case 0: // Anticlockwise/Left gesture
          println("Anticlockwise");
          break;
        case 1: // Clockwise/Right gesture
          println(static_gesture() + " Fingers"  + " Clockwise");
     
          break;
      }
      break;
  }
  switch(direction){
    case 0: // Anticlockwise/Left gesture
      break;
    case 1: // Clockwise/Right gesture
      break;
  }
  
  if(count.size()==2 && state==1){
    println("Happy Time");
  }
}
