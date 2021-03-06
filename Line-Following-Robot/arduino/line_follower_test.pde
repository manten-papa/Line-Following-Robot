// Arduino Language Reference
// http://arduino.cc/en/Reference/HomePage

#define motor1Dir 7
#define motor2Dir 8
#define motor1PWM 9
#define motor2PWM 10
#define motor1Enable 11
#define motor2Enable 12

#include <avr/interrupt.h>




void setMotorVel(int dirPin, int pwmPin, int velocity){
  if (velocity >= 255) velocity = 255;
  if (velocity <= -255) velocity = -255;

  if (velocity == 0)
  {
    digitalWrite(dirPin, HIGH);
    digitalWrite(pwmPin, HIGH);
  }
  else if(velocity <0){  // Reverse
    digitalWrite(dirPin, HIGH);
    analogWrite(pwmPin, 255+velocity);
  }
  else if(velocity >0){ // Forward
    digitalWrite(dirPin,LOW);
    analogWrite(pwmPin, velocity);
  }
}


void setLeftMotorSpeed(int velocity)
{
  setMotorVel(motor1Dir, motor1PWM, -velocity);

}

void setRightMotorSpeed(int velocity){
  setMotorVel(motor2Dir, motor2PWM, -velocity);
}

void initMotorDriver()
{
  pinMode(motor1Dir, OUTPUT);
  pinMode(motor2Dir, OUTPUT);

  pinMode(motor1Enable, OUTPUT);
  pinMode(motor2Enable, OUTPUT);
  digitalWrite(motor1Enable,HIGH);
  digitalWrite(motor2Enable,HIGH);
  setLeftMotorSpeed(0); // make sure the motors are stopped
  setRightMotorSpeed(0);
}



#include <stdio.h>


int testSensor(int sensor){
      char msg[30];
      //grab adc value
      int val = analogRead(sensor);
 	sprintf(msg, "Reading Sensor %d : %d \n", sensor, val);
      Serial.print(msg);
     return val; 
}



void goForward()
{
  setLeftMotorSpeed(255);
  setRightMotorSpeed(255);
}

void goRight()
{
  setLeftMotorSpeed(255);
  setRightMotorSpeed(-255);
}

void goLeft()
{
  setLeftMotorSpeed(-255);
  setRightMotorSpeed(255);
}



void setup(){
  Serial.begin(115200); //Set the buad rate for the serial com. 

  // prints title with ending line break 
  Serial.println("Line Sensor boar Sensor test"); 
  initMotorDriver();
  
  
}

void loop(){
  char c;
  int adcVal;
  
  c = Serial.read();
  
  switch(c){
    case '0':
      testSensor(0);
      break;
    case '1':
      testSensor(1);
      break;
     case '2':
      testSensor(2);
      break;
     case '3':
      testSensor(3);
      break;
    case '4':
      testSensor(4);
      break;
    case '5':
      testSensor(5);
      break;   
    case 'f' :
      setLeftMotorSpeed(254);
      setRightMotorSpeed(254);
      break;
    case 'r':
      setLeftMotorSpeed(-254);
      setRightMotorSpeed(-254);
      break;
    case 's':
      setLeftMotorSpeed(0);
      setRightMotorSpeed(0);
      break;
            
  }
}
