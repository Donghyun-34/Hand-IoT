static class TriggerPoint {
     public static float when_fist = -1;
     public static float when_open = -1;
}

boolean trigger() {
  for(de.voidplus.leapmotion.Hand hand : leap.getHands()){
    
    if(hand.getGrabStrength()==1.000){// if fist-hand
      TriggerPoint.when_fist = hand.getTimeVisible();
    }
    if(hand.getGrabStrength()==0.000){ // if open-hand
      TriggerPoint.when_open = hand.getTimeVisible();
    }
    
    float t_delta = TriggerPoint.when_open - TriggerPoint.when_fist; //time difference
    if(TriggerPoint.when_fist > 0 && TriggerPoint.when_open > 0 && TriggerPoint.when_open > TriggerPoint.when_fist){
      if(t_delta <= 1){// when trigger happened
        println("True!!");
        TriggerPoint.when_fist = TriggerPoint.when_open = -1;
        return true;
      }      
      else{
        println("Fales :(....");
        break;
      }
    }
  }
  return false;
}
