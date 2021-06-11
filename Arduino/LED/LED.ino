#include <WiFiNINA.h> 

int led1 = 2;

const char* ssid = "dongs";        // WiFi의 SSID(수정필요)
const char* pass = "3344660!";     // WiFi의 비밀번호(수정필요)

int status = WL_IDLE_STATUS; 
WiFiServer server(80); 

void setup() { 
  Serial.begin(9600); 
  delay(10); 
  // WiFi 네트웍에 접속 

  pinMode(led1, OUTPUT);
  digitalWrite(led1, LOW);
  
  while (status != WL_CONNECTED) { 
    Serial.print("Attempting to connect to SSID: "); 
    Serial.println(ssid); 
    status = WiFi.begin(ssid, pass); 
    // WiFi에 접속할 때까지 10초간 대기
    delay(10000); 
    } 
    Serial.println("WiFi connected"); 
    // 서버 시작
    
    server.begin(); 
    Serial.println("Server started"); 
    
    WiFiClient client = server.available(); 
}

void loop() { 
  // 클라이언트(폰, 패드등 동일 WiFi로 접속하는 기기)가 접속하였는지 체크
  WiFiClient client = server.available(); 
  if (!client) { 
    return; 
  } 
  // 클라이언트로부터 데이터 수신을 기다림
  Serial.println("new client"); 
  while(!client.available()){ 
    delay(1); 
  } 
  
  // 요청(데이터)의 첫 줄을 읽어 req에 저장
  String req = client.readStringUntil('\r'); 
  Serial.println(req); 
  client.flush(); 
  
  int val1 = 0; 
  
  val1 = extrac_command(req);

  digitalWrite(led1, val1);
  client.flush(); 
  
  // 요청에 대해 응답하기. 
  String s = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<!DOCTYPE HTML>\r\n<html>\r\n"; 
  create_response(val1, &s);
  
  // 응답할 내용을 클라이언트(폰, 패드 등 WiFi로 접속하는 기기)로 전송
  client.print(s);   //  예시 "LED1 is ON"  
  delay(2); 
  client.stop(); 
  Serial.println("Client disonnected");     
}

int extrac_command(String str){
  int val = 0;
  
  if (str.indexOf("/gpio1/0") != -1) { 
    val = 0;  
  } 
  else if (str.indexOf("/gpio1/1") != -1) { 
    val = 1; 
  }

  return val;
}

void create_response(int val1, String* s){
  *s += "LED1 is "; 
  *s += (val1)? "ON": "OFF"; // vall의 값이 참이면('0'아닌 값은 모두 참) 'ON'저장, 거짓이면'OFF'저장
  *s += "</html>\n"; 
}
