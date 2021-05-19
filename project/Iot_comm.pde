
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
  for(int i=0;i< count;i++){
    if(device[i].sd_id.equals(st_code)){
      url=device[i].address +"/gpio/"+device[i].dy_id.getString(dy_code);
    }
  }
  return url;
}

String sendSignal(String http_add) {
  String reply = null;
  
  try{ 
    GetRequest getSignal = new GetRequest(http_add);
    getSignal.send(); 
    reply = getSignal.getContent();
  }catch(Exception e){
    reply = "fail";
    }
  //println("Reponse Content: " + getSignal.getContent());
  return reply;
}
