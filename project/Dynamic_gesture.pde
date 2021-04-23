import de.voidplus.leapmotion.*;
import java.util.*;

// ======================================================
// Table of Contents:
// ├─ 1. Swipe Gesture
// ├─ 2. Circle Gesture

// ======================================================

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
   
  for (de.voidplus.leapmotion.Hand hand : leap.getHands ()) {  count = hand.getOutstretchedFingers();}
  
  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      //use yaw to detect direction direction.array()[2] = yaw
      if(direction.array()[2]<0){println(" left SwipeGesture ");}
      else if(direction.array()[2]>0){println(" right SwipeGesture ");}
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
  
  if(count.size()==2 && state==1){
    println("Happy Time");
  }
}
