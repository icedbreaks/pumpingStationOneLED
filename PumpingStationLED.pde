#include <MsTimer2.h>

/* Pumping Staion One LEDs
 * some of this code is modifyed from the Oomlut LED Example from their neat Arduino
 * expairmenters kit: http://tinyurl.com/d2hrud
 *
 * Code by Paul Sobczak | Twin Cities Maker | themountainfold.com
 */

//LED Pin Variables
int ledPins[] = {2,3,4,5,6,7}; //An array to hold the pin each LED is connected to
                                   //i.e. LED #0 is connected to pin 2, LED #1, 3 and so on
                                   //to address an array use ledPins[0] this would equal 2
                                   //and ledPins[7] would equal 9
                                   
int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by       


void setup()
{
  MsTimer2::set(30, fadeCenter); // 500ms period
  MsTimer2::start();
  //Set each pin connected to an LED to output mode (pulling high (on) or low (off)
  for(int i = 0; i < 8; i++){         //this is a loop and will repeat eight times
      pinMode(ledPins[i],OUTPUT);     //we use this to set each LED pin to output
  }                                   //the code this replaces is below
  pinMode(10,OUTPUT);                 //10 is the large center pin
}
 
 

void loop()                    
{
  //oneAfterAnotherLoop();   
  oneOnAtATime();            
  //inAndOut();             
}
 

/************************ oneAfterAnotherLoop() *********************************/
// Will light one LED then delay for delayTime then light
// the next LED until all LEDs are on it will then turn them off one after another
/********************************************************************************/
void oneAfterAnotherLoop(){
  int delayTime = 100; //the time (in milliseconds) to pause between LEDs
                       //make smaller for quicker switching and larger for slower
 
//Turn Each LED on one after another
  for(int i = 0; i <= 5; i++){
    digitalWrite(ledPins[i], HIGH);  //Turns on LED #i each time this runs i
    delay(delayTime);                //gets one added to it so this will repeat 
  }                                  //8 times the first time i will = 0 the final
                                     //time i will equal 7;
 
//Turn Each LED off one after another
  for(int i = 5; i >= 0; i--){  //same as above but rather than starting at 0 and counting up
                                //we start at seven and count down
    digitalWrite(ledPins[i], LOW);  //Turns off LED #i each time this runs i
    delay(delayTime);                //gets one subtracted from it so this will repeat 
  }                                  //8 times the first time i will = 7 the final
                                     //time it will equal 0       
                                     
}
 
 
/********************* oneOnAtATime() **************************/
//Will light one LED then the next turning off all the others
/***************************************************************/
void oneOnAtATime(){
  int delayTime = 100; //the time (in milliseconds) to pause between LEDs
                       //make smaller for quicker switching and larger for slower
                   
  
  for(int i = 0; i <= 5; i++){
    int offLED = i - 1;  //Calculate which LED was turned on last time through
    if(i == 0) {         //for i = 1 to 7 this is i minus 1 (i.e. if i = 2 we will
      offLED = 5;        //turn on LED 2 and off LED 1)
    }                    //however if i = 0 we don't want to turn of led -1 (doesn't exist)
                         //instead we turn off LED 7, (looping around)
    digitalWrite(ledPins[i], HIGH);     //turn on LED #i
    digitalWrite(ledPins[offLED], LOW); //turn off the LED we turned on last time
    delay(delayTime);
  }
}
 
 
/*********************inAndOut()******************************/
// This will turn on the two middle LEDs then the next two out
// making an in and out look
//***********************************************************
void inAndOut(){
  int delayTime = 100; //the time (in milliseconds) to pause between LEDs
                       //make smaller for quicker switching and larger for slower
  
  //runs the LEDs out from the middle
  for(int i = 0; i <= 3; i++){
    int offLED = i - 1;  //Calculate which LED was turned on last time through
    if(i == 0) {         //for i = 1 to 7 this is i minus 1 (i.e. if i = 2 we will
      offLED = 3;        //turn on LED 2 and off LED 1)
    }                    //however if i = 0 we don't want to turn of led -1 (doesn't exist)
                         //instead we turn off LED 7, (looping around)
    int onLED1 = 3 - i;       //this is the first LED to go on ie. LED #3 when i = 0 and LED 
                             //#0 when i = 3 
    int onLED2 = 4 + i;       //this is the first LED to go on ie. LED #4 when i = 0 and LED 
                             //#7 when i = 3 
    int offLED1 = 3 - offLED; //turns off the LED we turned on last time
    int offLED2 = 4 + offLED; //turns off the LED we turned on last time
    
    digitalWrite(ledPins[onLED1], HIGH);
    digitalWrite(ledPins[onLED2], HIGH);    
    digitalWrite(ledPins[offLED1], LOW);    
    digitalWrite(ledPins[offLED2], LOW);        
    delay(delayTime);
  }
 
  //runs the LEDs into the middle
  for(int i = 3; i >= 0; i--){
    int offLED = i + 1;  //Calculate which LED was turned on last time through
    if(i == 3) {         //for i = 1 to 7 this is i minus 1 (i.e. if i = 2 we will
      offLED = 0;        //turn on LED 2 and off LED 1)
    }                    //however if i = 0 we don't want to turn of led -1 (doesn't exist)
                         //instead we turn off LED 7, (looping around)
    int onLED1 = 3 - i;       //this is the first LED to go on ie. LED #3 when i = 0 and LED 
                             //#0 when i = 3 
    int onLED2 = 4 + i;       //this is the first LED to go on ie. LED #4 when i = 0 and LED 
                             //#7 when i = 3 
    int offLED1 = 3 - offLED; //turns off the LED we turned on last time
    int offLED2 = 4 + offLED; //turns off the LED we turned on last time
    
    digitalWrite(ledPins[onLED1], HIGH);
    digitalWrite(ledPins[onLED2], HIGH);    
    digitalWrite(ledPins[offLED1], LOW);    
    digitalWrite(ledPins[offLED2], LOW);        
    delay(delayTime);
  }
}


/*
 * fadeCenter() - This will fade the center LED, it's called as fast as the interupt is called
 */
void fadeCenter() {
  analogWrite(10, brightness);    

  // change the brightness for next time through the loop:
  brightness = brightness + fadeAmount;

  // reverse the direction of the fading at the ends of the fade: 
  if (brightness == 0 || brightness == 255) {
    fadeAmount = -fadeAmount ; 
  }  
}
