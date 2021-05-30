JSONObject json;

ArrayList readMetaDataJson(){
  json = loadJSONObject("../data/metadata.json");
  JSONArray files = json.getJSONArray("files");
  ArrayList<String> file_name = new ArrayList();
  
  for(int i=0; i<files.size();i++){
    file_name.add(files.getString(i));
  }
  
  return file_name;
}

Device readDeviceJson(String DeviceJson, int i){
  json = loadJSONObject("../data/"+DeviceJson);
  String name = json.getString("name");
  String address = json.getString("address");
  String st_id = json.getString("st_id");
  
  JSONObject dy_id = json.getJSONObject("dy_id");
  
  
  Device[] device = new Device[6];
  device[i] = new Device(name,address,st_id,dy_id);
  
  return device[i];
}

static class Device {
  public String name;
  public String address;
  public String st_id;
  public JSONObject dy_id;
  
  public Device(String name, String address, String st_id, JSONObject dy_id){
    this.name = name;
    this.address = address;
    this.st_id = st_id;
    this.dy_id = dy_id;
  }

}
