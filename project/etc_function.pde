import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;

//function for waiting n seconds
//need polish here, too; checking hand ID & hand_mia exeption
void hand_waiting(float n_time) {
  for(de.voidplus.leapmotion.Hand hand : leap.getHands()){
    float start_time = hand.getTimeVisible();
    for(float i  = hand.getTimeVisible();i - start_time <= n_time; i  = hand.getTimeVisible()){
      //Spinning!!! N!!
    }
  }
}
