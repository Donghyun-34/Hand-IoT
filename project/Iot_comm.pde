
//#getDevice() when called ->(st_code, dy_code) / * /<-(device_add, action)

//#getAdd() when called ->(device_add, action) / * /<-(http_add)

//#sendSignal() when called ->(http_add) / send signal & log respond via fork /<-( boolean_ok )

String getDevice(String st_code, String  dy_code){
  String http_add="http://";
  String ip_add = "error";
  if(!ban_stid.contains(st_code) && !err_dyid.contains(dy_code)){
    ip_add = mapTable(st_code, dy_code);// <- return 192.168.242.23/gpio1/1  (192.168.242.23 = st_code , gpio/1 or gpio/0  = dy_code
    http_add = "http://"+ip_add; 
    return http_add;
  }
  return http_add;
}

String mapTable(String st_code, String dy_code){ //example code for test
 String url=null;
  if(st_code.equals("001100")){
    url="192.168.124.136/gpio1";
  }
  if(dy_code.equals("s0")){
    url+="/1";
  }
  else if(dy_code.equals("s1")){
    url+="/0";
  }
  
  return url;
}

String sendSignal(String http_add) {
  String reply = null;
  GetRequest getSignal = new GetRequest(http_add);
  try{ 
    getSignal.send(); 
    }catch(Exception e){
    reply = "fail";
    }
  reply = getSignal.getContent();
  //println("Reponse Content: " + getSignal.getContent());
  return reply;
}
