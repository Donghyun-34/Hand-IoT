void trigger() {
 int a = 0;
 long fps = leap.getId();
 ArrayList count = new ArrayList();
 for (de.voidplus.leapmotion.Hand hand : leap.getHands ()) { count = hand.getOutstretchedFingers();} // Counting Finger
 for(de.voidplus.leapmotion.Hand hand : leap.getHands()){    
    if(hand.getGrabStrength()==1.000&&fps%25==0){//punch
        a = (int)hand.getGrabStrength();
        TriggerPoint.arr.add(a);
    }
    else if(fps%30==0) {TriggerPoint.arr.add(a);}//flat hand
    
    if(TriggerPoint.arr.size()==3){
    println(TriggerPoint.arr);
    println(TriggerPoint.arr2);
    boolean start = TriggerPoint.arr.equals(TriggerPoint.arr2);
    println(start);
    if(start == true){println("Success");}//connect Iot device here
    }
    if(hand.getTimeVisible()<=1||TriggerPoint.arr.size()==3){TriggerPoint.arr.clear();}//arr clear
  }
}
