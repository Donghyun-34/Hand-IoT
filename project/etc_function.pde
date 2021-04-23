import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;

//function for waiting n seconds
//10000000 == 1 sec, but bit slower
void hand_waiting(LeapMotion t_leap, float wait_sec) {
  //println(t_leap.getTimestamp());
  long init = t_leap.getTimestamp();
  long ntime = (long)(wait_sec * 1000000);
  //wait for wait_sec time
  for(long i = t_leap.getTimestamp(); i - init <= ntime; i = t_leap.getTimestamp());
}
