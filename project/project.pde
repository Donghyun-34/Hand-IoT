import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;
import http.requests.*;


LeapMotion leap;
String baseURL="http://192.168.244.201/gpio1/";

ArrayList<String> ban_stid = new ArrayList<String>( Arrays.asList("111111", "100000", "011111", "000000", "00") );
ArrayList<String> err_dyid = new ArrayList<String>( Arrays.asList("s9", "c9") );
ArrayList<String> do_dyid = new ArrayList<String>( Arrays.asList("s1", "s0", "c1", "c0") );
static final long _TIMEOUT_ = 5000000; // set time for timeout
static final long _TIMESG_ = 1000000; // set time for static_gesture recongization
static final long _TIMEDG_ = 500000; // set time for static_gesture recongization
 
 
void setup(){
  size(800, 500);
  background(255);
  leap = new LeapMotion(this);
  leap.allowGestures("swipe, circle");
}

void draw(){
 background(0);
 long fps = leap.getId();
 text(fps, 70,70);
 
 switch(Status.stage){
   case 1 :
     if( trigger() ){
       println("Stage 1 Pass ");
       Status.stage = 2;
       Status.timeout_stamp = leap.getTimestamp();
       gesture_code.rec_flag = true;
       gestureInit();
     }
     break;
   
   case 2 : //where static_gesture is tested
     //hand_waiting(leap,0.5);
     if ( leap.getTimestamp() - Status.timeout_stamp > _TIMEOUT_ ){
       println("Stage 2 Time-out ");
       statusInit();
       break;
     }
     
     setTimetemp(leap);
     if ( leap.getTimestamp() - Status.timetemp_stamp > _TIMESG_ && !ban_stid.contains( static_gesture() ) ){
       println("Stage 2 pass, st_code : ", gesture_code.st_code);
       gesture_code.rec_flag = true;
       Status.stage = 3;
     }
     
   case 3 : //where dynamic_gesture is tested
     if ( leap.getTimestamp() - Status.timeout_stamp > _TIMEOUT_ ){
       println("Stage 3 Time-out, st_code : ", gesture_code.st_code);
       if( err_dyid.contains( gesture_code.dy_code ) ){
         println("dy_err : ", gesture_code.dy_code);
       }
       statusInit();
       break;
     }
     setTimetemp(leap);
     if( leap.getTimestamp() - Status.timetemp_stamp > _TIMEDG_ && do_dyid.contains( gesture_code.dy_code ) ){
       gesture_code.rec_flag = false;
       //do stuff here
       println("do stuff here, dy_code : ", gesture_code.dy_code);
       
       if(gesture_code.st_code=="001100" && gesture_code.dy_code=="s0"){
         println(gesture_code.st_code);
         print(gesture_code.dy_code);
         GetRequest get = new GetRequest(baseURL+"1"); 
         get.send();
         println("Reponse Content: " + get.getContent());
       }
       else if(gesture_code.st_code=="001111" && gesture_code.dy_code=="s1"){
         GetRequest get = new GetRequest(baseURL+"0"); 
         get.send();
         println("Reponse Content: " + get.getContent());
       }
       statusInit();
       break;
     }
 }
 
}
