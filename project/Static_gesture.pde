String static_gesture(){
  Controller controller = new Controller();
  Frame frame = controller.frame();
  String outstretched="";
  
  for(com.leapmotion.leap.Hand hand : frame.hands()){
    if(hand.isRight()==true){outstretched+="1";}// righthand
    else {outstretched+="0";} // lefthand
    for(com.leapmotion.leap.Finger finger : hand.fingers()) {
      if(finger.isExtended()==true){outstretched +="1";}
      else if(finger.isExtended()==false){outstretched +="0";}       
    }
    //gesture_code.time_st = hand.timeVisible();
  }
  gesture_code.st_code = outstretched;
  return outstretched;
}
