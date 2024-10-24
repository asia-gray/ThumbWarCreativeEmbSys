#define JOY_X_PIN 39    
#define JOY_Y_PIN 32    
#define JOY_SW_PIN 33   
#define BUTTON_PIN 13    
#define POT_PIN 26      


void setup() {
  Serial.begin(115200);  
  pinMode(JOY_SW_PIN, INPUT_PULLUP);  
  pinMode(POT_PIN, INPUT);           
}

void loop() {
  // reading joystick values and map them to screen coordinates (0-100 range)
  int xValue = map(analogRead(JOY_X_PIN), 0, 4095, 0, 100);
  int yValue = map(analogRead(JOY_Y_PIN), 0, 4095, 0, 100);

  // reading potentiometer to adjust thumb movement speed
  int speedValue = map(analogRead(POT_PIN), 0, 4095, 1, 10);  //on scale of 1-10

  // reading the joystick button state (0 when pressed)
  int buttonState = digitalRead(JOY_SW_PIN) == LOW ? 1 : 0;

  // sending data to Processing
  Serial.print(xValue); Serial.print(",");
  Serial.print(yValue); Serial.print(",");
  Serial.print(speedValue); Serial.print(",");
  Serial.println(buttonState);

  delay(50);  
}

