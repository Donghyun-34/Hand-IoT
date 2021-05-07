
static class Status{
  public static int stage = 1;
  public static long timeout_stamp = -1;
  public static long timetemp_stamp = -1;
}


static class Waiter{
  public static long start = -1;
  public static long ntime = -1;
}


void waiterInit(){
  Waiter.start = -1;
  Waiter.ntime = -1;
}


void statusInit(){
  Status.stage = 1;
  Status.timeout_stamp = -1;
  Status.timetemp_stamp = -1;
}


void setTimetemp(LeapMotion t_leap){
  if(Status.timetemp_stamp == -1){
    Status.timetemp_stamp = t_leap.getTimestamp();
  }
}


//function for waiting n seconds
//10000000 == 1 sec, but bit slower
boolean hand_waiting(LeapMotion t_leap, float wait_sec) {
  if( Waiter.start == -1 ){
    Waiter.start = t_leap.getTimestamp();
    Waiter.ntime = (long)(wait_sec * 1000000);
  }
  else if ( t_leap.getTimestamp() - Waiter.start >= Waiter.ntime){//wait(skip) for wait_sec time
    return true;
  }
  return false;
}
