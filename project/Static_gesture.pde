import de.voidplus.leapmotion.*;
import java.util.*;

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