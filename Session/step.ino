int STEP = 8;
int DIR = 7;

void setup(){
  pinMode(STEP, OUTPUT);
  pinMode(DIR, OUTPUT);
  digitalWrite(DIR, HIGH);
}

void loop(){
  digitalWrite(STEP, HIGH);
}
