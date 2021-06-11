#include <Stepper.h>
#include <WiFiNINA.h>

int IN1 = 2; //IN1은 2번 핀에 연결
int IN2 = 3; //IN2는 3번 핀에 연결
int IN3 = 4; //IN3는 4번 핀에 연결
int IN4 = 5; //IN4는 5번 핀에 연결
Stepper step1(2048, IN1, IN3, IN2, IN4);

int lap = 3072; //2048-->360도 회전

const char* ssid = "dongs";        // WiFi의 SSID(수정필요)
const char* pass = "3344660!";     // WiFi의 비밀번호(수정필요)

int status = WL_IDLE_STATUS;
WiFiServer server(80);

void setup() {
  Serial.begin(9600);
  delay(10);
  // WiFi 네트웍에 접속

  step1.setSpeed(12); //분당 10회 회전

  while (status != WL_CONNECTED)
  {
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
    WiFiClient client = server.available();
}

void loop() {
  int done = 0;
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

  done = extrac_command(req);
  client.flush();
  
  // 요청에 대해 응답하기.
  String s = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<!DOCTYPE HTML>\r\n<html>\r\n";
  create_response(done, &s);

  // 응답할 내용을 클라이언트(폰, 패드 등 WiFi로 접속하는 기기)로 전송
  client.print(s);   //  예시 "LED1 is ON"
  delay(2);
  client.stop();

  Serial.println("Client disonnected");
}

int extrac_command(String str){
  int done = 0;
  
  if (str.indexOf("/gpio1/0") != -1) {
    step1.step(lap); //오른쪽으로 한바퀴
    done = 1;
  }
  else if (str.indexOf("/gpio1/1") != -1) {
    step1.step(-lap); //왼쪽으로 한바퀴
    done = 2;
  }

  return done;
}

void create_response(int done, String* s){
  if(done==1)
  {
    *s += "Motor is turn to Clockwise";
  }
  else if (done == 2)
  {
    *s += "Motor is turn to AntiClockwise";
  }
  *s += "</html>\n";
}
