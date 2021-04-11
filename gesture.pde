import de.voidplus.leapmotion.*;
import java.util.*;

// ======================================================
// Table of Contents:
// ├─ 1. Swipe Gesture
// ├─ 2. Circle Gesture

// ======================================================

void leapOnSwipeGesture(de.voidplus.leapmotion.SwipeGesture g, int state){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector positionStart    = g.getStartPosition();
  PVector direction        = g.getDirection();
  float   speed            = g.getSpeed();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();

  ArrayList count = new ArrayList();
   
  for (Hand hand : leap.getHands ()) {
   
      count = hand.getOutstretchedFingers();
  }

  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      println(count.size() + " Fingers" + " SwipeGesture: " + id); 
      break;
  }
}


// ======================================================
// 2. Circle Gesture

void leapOnCircleGesture(de.voidplus.leapmotion.CircleGesture g, int state){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector positionCenter   = g.getCenter();
  float   radius           = g.getRadius();
  float   progress         = g.getProgress();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  int     direction        = g.getDirection();

ArrayList count = new ArrayList();
   
  for (Hand hand : leap.getHands ()) {
  
      count = hand.getOutstretchedFingers();
  }


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
          println(count.size() + " Fingers"  + " Clockwise");
     
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
