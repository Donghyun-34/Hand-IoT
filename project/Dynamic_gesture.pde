// ======================================================
// Table of Contents:
// ├─ 1. Swipe Gesture
// ├─ 2. Circle Gesture

// ======================================================

static class gesture_code {
     public static String dy_code = "00";
     public static String st_code = "00";
     public static float time_st = -1;
     public static float time_dy = -1;
}



String leapOnSwipeGesture(de.voidplus.leapmotion.SwipeGesture g, int state){
  int     id               = g.getId();
  de.voidplus.leapmotion.Finger  finger           = g.getFinger();
  PVector position         = g.getPosition();
  PVector positionStart    = g.getStartPosition();
  PVector direction        = g.getDirection();
  float   speed            = g.getSpeed();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  
  String result="s9"; // s = Swipe , 0 = left, 1 = right , 9 = error
  ArrayList count = new ArrayList();
   
  for (de.voidplus.leapmotion.Hand hand : leap.getHands ()) {  count = hand.getOutstretchedFingers();}
  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      //use yaw to detect direction direction.array()[2] = yaw
      if(direction.array()[2]<0){ 
        result = "s0"; 
        //println(result); //test code
        gesture_code.dy_code = result;
        ////////////gesture_code.time_dy =.getTimeVisible();
        return result;
      }// Swipe left
      
      else if(direction.array()[2]>0){
        result = "s1"; 
        //println(result); //test code
        gesture_code.dy_code = result;
        return result;
      } // Swipe right
     break;
  }
  gesture_code.dy_code = result;
  return result;
}


// ======================================================
// 2. Circle Gesture

String leapOnCircleGesture(de.voidplus.leapmotion.CircleGesture g, int state){
  int     id               = g.getId();
  de.voidplus.leapmotion.Finger  finger           = g.getFinger();
  PVector positionCenter   = g.getCenter();
  float   radius           = g.getRadius();
  float   progress         = g.getProgress();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  int     direction        = g.getDirection();
  String result="c9"; // c = Circle , 0 = AntiCircleWise, 1 = CircleWise , 9 = error

  ArrayList count = new ArrayList();//finger count
  for (de.voidplus.leapmotion.Hand hand : leap.getHands ()) {count = hand.getOutstretchedFingers();}

  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      if(direction == 0){ // Anticlockwise/Left gesture
          result = "c0";
          //println(result); //test code
          gesture_code.dy_code = result;
          return result;
      }
          
      else if(direction == 1){ // Clockwise/Right gesture
          result = "c1";
          //println(result); //test code
          gesture_code.dy_code = result;
          return result;
      }
      break;
  }
  gesture_code.dy_code = result;
  return result;
}
