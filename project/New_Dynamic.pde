class LeapListener extends Listener {

    //Method for detection 
    public void onFrame(Controller controller) {
        Frame frame = controller.frame();
        //GESTURE
        GestureList gestures = frame.gestures();
        for (int i = 0; i < gestures.count(); i++) {
            com.leapmotion.leap.Gesture gesture = gestures.get(i);
            switch (gesture.type()) {
            case TYPE_CIRCLE:
                com.leapmotion.leap.CircleGesture circle = new com.leapmotion.leap.CircleGesture(gesture);

                String clockWiseness;
                if (circle.pointable().direction().angleTo(circle.normal()) <= Math.PI/4 ) {
                    clockWiseness = "clockwise";
                } else {
                    clockWiseness = "counter-clockwise";
                }

                double sweptAngle = 0;
                if (circle.state() != com.leapmotion.leap.Gesture.State.STATE_START) {
                    com.leapmotion.leap.CircleGesture previous = new com.leapmotion.leap.CircleGesture(controller.frame(1).gesture(circle.id()));
                    sweptAngle = (circle.progress() - previous.progress()) * 2 * Math.PI;
                } 
                if(circle.state() ==com.leapmotion.leap.Gesture.State.STATE_STOP){
                System.out.println(" State: " + circle.state()
                                    // Progress = how many times did you make the circle
                                    + " Progress " + circle.progress()
                                    + " Direction: " + clockWiseness); 
                                  }
                break;

            case TYPE_SWIPE:
                com.leapmotion.leap.SwipeGesture swipe = new com.leapmotion.leap.SwipeGesture(gesture);
                if(swipe.state() ==com.leapmotion.leap.Gesture.State.STATE_STOP){
                  System.out.println("Swipe ID: " + swipe.id()
                                + " State: " + swipe.state()
                                + " Direction: " + swipe.direction());
                }
                break;


            default:
                    System.out.println("Unkown gesture");
                    break;
            }

        }

    }
}





//ppp
/***
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
        if ( !gesture_code.rec_flag ){
          break;
        }
        else if(direction.array()[1]<0){
          gesture_code.rec_flag = false;
          gesture_code.dy_code = "s0";
          result = "s0";
          //gesture_code.time_dy = hand.getTimeVisible();
        }// Swipe left

        else if(direction.array()[1]>0){
          gesture_code.rec_flag = false;
          gesture_code.dy_code = "s1";
          result = "s1";
          //gesture_code.time_dy = hand.getTimeVisible();
        }// Swipe right
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

  ArrayList count = new ArrayList();//finger count
  for (de.voidplus.leapmotion.Hand hand : leap.getHands ()) {

    switch(state){
      case 1: // Start
        break;
      case 2: // Update
        break;
      case 3: // Stop
        if ( !gesture_code.rec_flag ){
          break;
        }
        else if(direction == 0){ // Anticlockwise/Left gesture
          gesture_code.rec_flag = false;
          gesture_code.dy_code = "c0";
          result = "c0";
          //gesture_code.time_dy = hand.getTimeVisible();
        }
        else if(direction == 1){ // Clockwise/Right gesture
          gesture_code.rec_flag = false;
          gesture_code.dy_code = "c1";
          result = "c1";
          //gesture_code.time_dy = hand.getTimeVisible();
      }
      break;
    }
  }
  gesture_code.dy_code = result;
  return result;
}
***/
