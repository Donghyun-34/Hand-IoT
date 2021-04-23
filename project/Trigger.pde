import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;


//need to polish this sh!t


static class TriggerPoint {
     public static float when_fist = -1;
     public static float when_open = -1;
}

boolean trigger() {
  for(de.voidplus.leapmotion.Hand hand : leap.getHands()){
    //println("got hand!!  str : ",hand.getGrabStrength());
    
    if(hand.getGrabStrength()==1.000){// if fist-hand
      TriggerPoint.when_fist = hand.getTimeVisible();
      //println("FIST!! - ", when_fist);
    }
    if(hand.getGrabStrength()==0.000){ // if open-hand
      TriggerPoint.when_open = hand.getTimeVisible();
      //println("OPEN!! - ", when_open);
    }
    
    float t_delta = TriggerPoint.when_open - TriggerPoint.when_fist; //time difference
    //println(t_delta, " ", TriggerPoint.when_fist, " ", TriggerPoint.when_open); 
    if(TriggerPoint.when_fist > 0 && TriggerPoint.when_open > 0 && TriggerPoint.when_open > TriggerPoint.when_fist){
      //println("stage1!!");
      if(t_delta <= 1){// when trigger happened
        println("True!!");
        TriggerPoint.when_fist = TriggerPoint.when_open = -1;
        return true;
      }      
      else{
        println("Fales :(....");
        //println("Delta : ", t_delta);
        break;
      }
    }
  }
  return false;
}
