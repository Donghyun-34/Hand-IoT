// ======================================================
// Table of Contents:
// ├─ 1. Swipe Gesture
// ├─ 2. Circle Gesture
// ======================================================

static class gesture_code {
     public static String dy_code = "00";
     public static String st_code = "00";
}


//initialize 'gesture_code'
void gestureInit(){
  gesture_code.dy_code = gesture_code.st_code = "00";
}

void leapOnSwipeGesture(de.voidplus.leapmotion.SwipeGesture g, int state){
  PVector direction        = g.getDirection();
  // s = Swipe , 0 = left, 1 = right , 9 = error
  float dir_now = direction.x;
  switch(state){
    case 1: // Start
      break;
      
    case 2: // Update
      if(dir_now > 0){//when right_swipe
        gesture_code.dy_code = "s1";
      }
      else if(dir_now < 0){//when left_swipe
        gesture_code.dy_code = "s0";
      }
      break;
      
    case 3: // Stop
      if(dir_now > 0){//when right_swipe
        gesture_code.dy_code = "s1";
      }
      else if(dir_now < 0){//when left_swipe
        gesture_code.dy_code = "s0";
      }
      break;
    }
}

// ======================================================
// 2. Circle Gesture

void leapOnCircleGesture(de.voidplus.leapmotion.CircleGesture g, int state){
  float   radius           = g.getRadius();
  int     direction        = g.getDirection();
  // c = Circle , 0 = AntiCircleWise, 1 = CircleWise , 9 = error

  if(radius < 70){
  switch(state){
    case 1: // Start
      break;
      
    case 2: // Update
      switch(direction){
        case 0: // Anticlockwise/Left gesture
          gesture_code.dy_code = "c0";
          break;
        case 1: // Clockwise/Right gesture
          gesture_code.dy_code = "c1";
          break;
      }
      break;
      
    case 3: // Stop
      switch(direction){
        case 0: // Anticlockwise/Left gesture
          gesture_code.dy_code = "c0";
          break;
        case 1: // Clockwise/Right gesture
          gesture_code.dy_code = "c1";
          break;
      }
      break;
  }
  }
}
