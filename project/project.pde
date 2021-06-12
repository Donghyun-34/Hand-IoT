import de.voidplus.leapmotion.*;
import java.util.*;
import com.leapmotion.leap.*;
import http.requests.*;
import java.net.*;


LeapMotion leap;
Device[] device = new Device[60];
int count=0;
ArrayList<String> ban_stid = new ArrayList<String>( Arrays.asList("111111", "100000", "011111", "000000", "00") );
ArrayList<String> do_dyid = new ArrayList<String>( Arrays.asList("s1", "s0", "c1", "c0") );
static final long _TIMEOUT_ = 4000000; // set time for timeout
static final long _TIMESG_ = 1000000; // set time for static_gesture recongization
static final long _TIMEDG_ = 100000; // set time for dynamic_gesture recongization
 
static String last_mem = "00";
 
void setup(){
  size(800, 500);
  background(255);
  leap = new LeapMotion(this);
  ArrayList<String> file_name = new ArrayList();
  leap.allowGestures("swipe,circle");
  
  file_name = readMetaDataJson();
  for(int i=0; i<file_name.size();i++){
    String file = file_name.get(i);
    device[i] = readDeviceJson(file,i);
  }
  count = file_name.size();
}

void draw(){
 background(0);
 
 text("Device List",90,130);
 for(int i=0; i<count;i++){
   text(device[i].name + " / " + device[i].address + " / " +device[i].st_id + " / " + "(s0 : " + device[i].dy_id.getString("s0") + 
   " / s1 : " + device[i].dy_id.getString("s1") + " / c0 : " + device[i].dy_id.getString("c0") + " / c1 : " + device[i].dy_id.getString("c1")+")", 90, 150+i*20); //print Device info
 }
 
 switch(Status.stage){
   case 1 :
     text("[W]",200,60);
     statusInit();
     if( trigger(1) ){
       Status.stage = 2;
       Status.timeout_stamp = leap.getTimestamp();
       gestureInit();
       println("Stage 1 Pass ");
     }
     break;
   
   case 2 : //where static_gesture is tested
     text("[S]",230,60);
     if ( leap.getTimestamp() - Status.timeout_stamp > _TIMEOUT_ ){
       println("Stage 2 Time-out, st_code : "+gesture_code.st_code );
       text("[E]",320,60);
       statusInit();
       break;
     }
     
     setTimetemp(leap);
     String st_temp = static_gesture();
     if ( leap.getTimestamp() - Status.timetemp_stamp > _TIMESG_ && !ban_stid.contains( st_temp ) ){
       println("Stage 2 pass");
       Status.stage = 3;
     }
     break;
     
   case 3 : //where dynamic_gesture is tested
     text("[D]",260,60);
     String dy_temp = gesture_code.dy_code;
     if ( leap.getTimestamp() - Status.timeout_stamp > _TIMEOUT_ ){
       println("Stage 3 Time-out, st_code : ", gesture_code.st_code);
       text("[E]",320,60);
       statusInit();
       break;
     }
     
     setTimetemp(leap);
     if( leap.getTimestamp() - Status.timetemp_stamp > _TIMEDG_ && do_dyid.contains( dy_temp ) ){
       //do stuff here
       println("Result st_code : "+gesture_code.st_code +" ,dy_code : ", dy_temp);
       last_mem = dy_temp;
       text("[A]",290,60);
       
       String signal = getDevice(gesture_code.st_code, gesture_code.dy_code);
       if(signal.equals("error")){ //signal is null
         println("error"); // if error occured do nothing
         text("[E]",320,60);
       }
       else{
         println("Device Action");
         text("[X]",290,60);
         String response = sendSignal(signal);// get response
         print(response);
       }
       statusInit();
       break;
     }
 }
 text("Current Static      Gesture : "+ gesture_code.st_code,200,80);
 text("Current Dynamic Gesture : "+ gesture_code.dy_code,200,100);
 text("Last Dynamic Gesture : "+ last_mem ,200,120);
}
