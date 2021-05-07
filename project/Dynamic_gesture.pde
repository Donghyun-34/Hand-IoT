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


//initialize 'gesture_code'
void gestureInit(){
  gesture_code.dy_code = gesture_code.st_code = "00";
  gesture_code.time_st = gesture_code.time_dy = -1;
}


String leapOnSwipeGesture(de.voidplus.leapmotion.SwipeGesture g, int state){
  PVector direction        = g.getDirection();
  
  String result="s9"; // s = Swipe , 0 = left, 1 = right , 9 = error
   
  for (de.voidplus.leapmotion.Hand hand : leap.getHands ()){
    
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
        gesture_code.time_dy = hand.getTimeVisible();
        return result;
      }// Swipe left
      
      else if(direction.array()[2]>0){
        result = "s1"; 
        //println(result); //test code
        gesture_code.dy_code = result;
        gesture_code.time_dy = hand.getTimeVisible();
        return result;
      } // Swipe right
     break;
  }
  
  }
  
  gesture_code.dy_code = result;
  return result;
}


// ======================================================
// 2. Circle Gesture

String leapOnCircleGesture(de.voidplus.leapmotion.CircleGesture g, int state){
  float   radius           = g.getRadius();
  int     direction        = g.getDirection();
  String result="c9"; // c = Circle , 0 = AntiCircleWise, 1 = CircleWise , 9 = error

  for (de.voidplus.leapmotion.Hand hand : leap.getHands ()) {

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
          gesture_code.time_dy = hand.getTimeVisible();
          return result;
      }
          
      else if(direction == 1){ // Clockwise/Right gesture
          result = "c1";
          //println(result); //test code
          gesture_code.dy_code = result;
          gesture_code.time_dy = hand.getTimeVisible();
          return result;
      }
      break;
  }
  
  }
  gesture_code.dy_code = result;
  return result;
}
