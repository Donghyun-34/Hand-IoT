import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;
import http.requests.*;
import java.net.*;


LeapMotion leap;
Device[] device = new Device[6];
int count=0;
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
  ArrayList<String> file_name = new ArrayList();
  
  leap.allowGestures("swipe, circle");
  file_name = readMetaDataJson();
  
  for(int i=0; i<file_name.size();i++){
    String file = file_name.get(i);
    device[i] = readDeviceJson(file,i);
    
    println("name : "+device[i].name);
    println("address : "+device[i].address);
    println("sd_id : "+device[i].sd_id);
    println("dy_id_c0 : "+device[i].dy_id);

  }
  count = file_name.size();
}

void draw(){
 background(0);
 String abc = static_gesture();
 text("Hand | Thumb | Index | Middle | Ring | Little",90,80);
 if(abc !=""){
   if(abc.substring(0,1).equals("1")) 
     text("Right", 90,95);
   else
      text(" left", 90,95);
   text(abc.substring(1,2), 140,95);
   text(abc.substring(2,3), 185,95);
   text(abc.substring(3,4), 225,95);
   text(abc.substring(4,5), 265,95);
   text(abc.substring(5,6), 300,95);
 }
 
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
       String signal = getDevice(gesture_code.st_code, gesture_code.dy_code);
       print(signal);
       String response = sendSignal(signal);
       print(response);
       statusInit();
       break;
     }
 }
 
}
