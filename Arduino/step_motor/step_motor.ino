int IN1 = 8;                      // IN1핀을 8번에 배선합니다.
int IN2 = 9;                      // IN2핀을 9번에 배선합니다.
int IN3 = 10;                    // IN3핀을 10번에 배선합니다.
int IN4 = 11;                    // IN4핀을 11번에 배선합니다.
int motorSpeed = 1800;     // 스텝모터의 속도를 정할 수 있습니다.
int count = 0;                  // 스텝을 카운트하여 얼마나 회전했는지 확인할 수 있습니다.
int countsperrev = 512;     // 최대 카운트를 512로 설정합니다.
int lookup[8] = {B01000, B01100, B00100, B00110, B00010, B00011, B00001, B01001};
// 스텝모터를 제어할 방향의 코드를 미리 설정합니다.

void setup() {
  pinMode(IN1, OUTPUT);    // IN1을 출력핀으로 설정합니다.
  pinMode(IN2, OUTPUT);    // IN2을 출력핀으로 설정합니다.
  pinMode(IN3, OUTPUT);    // IN3을 출력핀으로 설정합니다.
  pinMode(IN4, OUTPUT);    // IN4을 출력핀으로 설정합니다.
}

void loop() {
  if (count < countsperrev ) {                 // count가 countsperrev 보다 작으면
    clockwise();                                   // clockwise()함수를 실행합니다.
  }
  else if (count == countsperrev * 2) {   // count가 countsperrev 보다 작지 않고, count가 countsperrev의 두배와 동일하면
    count = 0;                                      // count를 0으로 설정합니다.
  }
  else {                               // count가 countsperrev 보다 크거나 같고, count가 countsperrev의 두배와 동일하지 않으면
    anticlockwise();              // anticlockwise()함수를 실행합니다.
  }
  count++;                           // count를 1씩 더합니다.
}

void anticlockwise()
{
  for (int i = 0; i < 8; i++)
  {
    setOutput(i);
    delayMicroseconds(motorSpeed);
  }
}

void clockwise()
{
  for (int i = 7; i >= 0; i--)
  {
    setOutput(i);
    delayMicroseconds(motorSpeed);
  }
}

void setOutput(int out)
{
  digitalWrite(IN1, bitRead(lookup[out], 0));
  digitalWrite(IN2, bitRead(lookup[out], 1));
  digitalWrite(IN3, bitRead(lookup[out], 2));
  digitalWrite(IN4, bitRead(lookup[out], 3));
}
