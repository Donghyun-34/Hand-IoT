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
