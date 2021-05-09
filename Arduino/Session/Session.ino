#include <SPI.h> 
#include <WiFiNINA.h> 

int led1 = 3;
int led2 = 2;
int led3 = 4;

const char* ssid = "Sjss";        // WiFi의 SSID(수정필요)
const char* pass = "Sjss0117";     // WiFi의 비밀번호(수정필요)

int status = WL_IDLE_STATUS; 
WiFiServer server(80); 

void setup() { 
  Serial.begin(9600); 
  delay(10); 
  // WiFi 네트웍에 접속 

  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  digitalWrite(led1, HIGH);
  digitalWrite(led2, HIGH);
  digitalWrite(led3, LOW);
  
  while (status != WL_CONNECTED) { 
    Serial.print("Attempting to connect to SSID: "); 
    Serial.println(ssid); 
    status = WiFi.begin(ssid, pass); 
    // WiFi에 접속할 때까지 10초간 대기
    delay(10000); 
    } 
    Serial.println(""); 
    Serial.println("WiFi connected"); 
    // 서버 시작
    server.begin(); 
    Serial.println("Server started"); 
    // 할당받은 IP 주소를 시리얼 모니터로 출력
    char ips[24]; 
    IPAddress ip = WiFi.localIP(); 
    sprintf(ips, "%d.%d.%d.%d", ip[0], ip[1], ip[2], ip[3]);  // IP형식으로 출력
    Serial.println(ips); 
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
  int Ledreq = 0; 
  // 비교문으로 요청 들어온 값과 일치하는 부분이 있을 경우 {  } 안의 내용을 실행.
  // req.indexof("문자열")은, req에 있는 데이터에서 "문자열"이 일치하는 문자가 없을 경우는 '-1'을 반환.
  // 그외 일치하면 해당 문자열의 인덱스 시작위치(숫자)를 반환.   
  if (req.indexOf("/gpio1/0") != -1) { 
    val1 = 0;  
    Ledreq = 1; 
  } else if (req.indexOf("/gpio1/1") != -1) { 
    val1 = 1; 
    Ledreq = 1; 
  }
  else { 
    Serial.println(" ... "); 
    client.stop(); 
    return; 
  } 
  // if문에 의해 설정된 값을 출력(LED On/Off)

  digitalWrite(led1, val1);
  client.flush(); 
  // 요청에 대해 응답하기. 
  String s = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<!DOCTYPE HTML>\r\n<html>\r\n"; 
  if(Ledreq==1) { 
    s += "LED1 is "; 
    s += (val1)? "ON": "OFF"; // vall의 값이 참이면('0'아닌 값은 모두 참) 'ON'저장, 거짓이면'OFF'저장
  }
  s += "</html>\n"; 
  // 응답할 내용을 클라이언트(폰, 패드 등 WiFi로 접속하는 기기)로 전송
  client.print(s);   //  예시 "LED1 is ON"  
  delay(2); 
  client.stop(); 
  Serial.println("Client disonnected");     
}
