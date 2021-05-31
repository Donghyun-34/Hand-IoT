String getDevice(String st_code, String  dy_code){
  String http_add="http://";
  String ip_add = "error";
  if(!ban_stid.contains(st_code) && do_dyid.contains(dy_code)){
    println(st_code);
    for(int i=0;i< count;i++){
      if(device[i].st_id.equals(st_code)){ // matching device
        ip_add = device[i].address +"/gpio1/"+device[i].dy_id.getString(dy_code);
        http_add = "http://"+ip_add;
        println(http_add);
        return http_add;
      }
    }
    http_add = ip_add; // give error code
  }
  return http_add;
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
  return reply;
}
