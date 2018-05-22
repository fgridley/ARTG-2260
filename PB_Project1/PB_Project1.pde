/*
Fiona Gridley
Project 1: Personal Introduction
Cycle through 10 different interactions/animations to convey personal facts and information.
Programming Basics Summer 1 2018
*/

int phase = 2; //current phase of the program, controlled by mouse click
PFont sourcePro; //primary font
PFont sourceCode; //font for displaying code

//variables for intro phase
PImage hand;
int mouseXPrev = -1;
int handRotation = 0;

//variables for wheat phase
PImage wheat; //image of wheat for wheat animation in 2nd phase

//variables for london phase
PImage londonEye;
PImage londonEyeStand;
int eyeRotate = 0;
PImage bus;

//variables for boston phase
color darkRed = #8E2C2C; //unlit red
color brightRed = #FF3B3B; // lit red
color red1; //red for outside triangles
color red2; //red for middle triangles
color red3; //red for inner triangles
int darkWhite = 170; //unlit white
int brightWhite = 250; //lit white
int white1; //white for top lines
int white2; //white for middle lines
int white3; //white for bottom lines
color darkBlue = #335CC9; //unlit blue
color brightBlue = #B4CAFF; //lit blue
color citgo; //blue for citgo sign
int citgoTime; //time count

//variables for coding animation phase
int helloWorldTime; //time count
String helloWorld = "public class HelloWorld { \n  public static "
+ "void main(String[] args) {\n    System.out.println(\"Hello World!\");\n  }\n}"; //string to display

//variables for vegan phase
int carrotTime; //time count
PImage carrot; //carrot image

//variables for cooking phase
PImage stove; //stove image
int[] timeSub = {275, 260, 230, 220, 200, 175, 160, 140, 125, 100, 80, 65, 40, 25}; //y values for bubbles

//variables for wave phase
PImage waveSmall; //small wave image
PImage waveMed; //medium wave image
PImage waveBig; //big wave image
int[] timeSub2 = {5, 29, 20}; //y values for waves
boolean[] waveUp = {true, true, true}; //should each wave be going up or down

//variables for wave phase
PImage paintbrush; //paintbrush image

//variables for ending phase
PImage curtain; //curtain image
int curtainMove; //x value for curtains

void setup() {
  //set size and fonts for program
  size(800, 600);
  resetColors();
  noStroke();
  sourcePro = createFont("SourceSansPro-Bold", 32); //set sourcePro to SourcePro font
  sourceCode = createFont("SourceCodePro-Regular", 24); //set sourceCode to SourceCode font
  textFont(sourcePro); //set program font to SourcePro
  
  //load images
  hand = loadImage("hand.png");
  wheat = loadImage("wheat.png");
  carrot = loadImage("carrot.png");
  stove = loadImage("stove.png");
  waveSmall = loadImage("wave1.png");
  waveMed = loadImage("wave2.png");
  waveBig = loadImage("wave3.png");
  paintbrush = loadImage("paintbrush.png");
  londonEye = loadImage("londoneye.png");
  londonEyeStand = loadImage("londoneyestand.png");
  bus = loadImage("bus.png");
  curtain = loadImage("curtain.png");
}

void draw() {
  //change phase based on number of mouse clicks
  switch(phase) {
    case 0:
      intro();
      break;
    case 1:
      fact1();
      break;
    case 2:
      fact2();
      break;
    case 3:
      fact3();
      break;
    case 4:
      fact4();
      break;
    case 5:
      fact5();
      break;
    case 6:
      fact6();
      break;
    case 7:
      fact7();
      break;
    case 8:
      fact8();
      break;
    case 9:
      ending();
      break;
  }
}

//introduction phase - animate hand to wave back and forth as mouseX value is changed
void intro() {
  background(#B698FF);
  imageMode(CENTER);
  text("Hi there! My name is Fiona Gridley,", width*.1, 250);
  text("and I'm here to tell you a little bit about myself.", width*.1, 290);
  
  //if mouse moves right, increase hand rotation angle
  if (mouseX > mouseXPrev && handRotation < 45) {
    handRotation += 3;
  //if mouse moves left, decrease hand rotation angle
  } else if (mouseX < mouseXPrev && handRotation > -45) {
    handRotation -= 3;
  }
  translate(width/1.25, height/1.1); //translate origin to middle of hand
  rotate(radians(handRotation)); //rotate hand
  image(hand, 0, 0);
  mouseXPrev = mouseX; //set mouse previous to current
}

void fact1() {
  //draw background and text
  imageMode(CORNER);
  background(#865D35);
  fill(#9DD5FF);
  rect(0, 0, 800, 400);
  fill(255);
  text("I'm from Wichita, Kansas.", 250, 250);
  
  //first wheat
  fill(#FFE35A);
  rect(57.5, mouseY*.35 + 358, 9, 600);
  image(wheat, 30, mouseY*.35 + 200);
  
  //middle wheat
  fill(#FFE35A);
  rect(347.5, mouseY*.75 + 358, 9, 600);
  image(wheat, 320, mouseY*.75 + 200);
  
  //rightmost wheat
  fill(#FFE35A);
  rect(547.5, mouseY*.5 + 358, 9, 600);
  image(wheat, 520, mouseY*.5 + 200);
}

void fact2() {
  //draw background and text
  frameRate(30);
  background(#6AAEFF);
  text("I also lived in London in 6th grade.", 30, 100);
  imageMode(CENTER);
  image(bus, 590, 480);
  
  translate(220, 380); //set origin to middle of london eye wheel
  image(londonEyeStand, 0, 100);
  rotate(radians(eyeRotate)); //rotate wheel
  image(londonEye, 0, 0);
  eyeRotate++; //increment rotation with each call to the method
  imageMode(CORNER); //reset image mode
}

void fact3() {
  //draw background and text
  frameRate(3);
  citgoTime += 1;
  background(#264081);
  fill(255);
  textSize(32);
  text("But I was born in Boston!", 400, 550);
  
  //cigto background
  strokeWeight(4);
  fill(75);
  noStroke();
  rect(210, 350, 30, 250);
  stroke(white1);
  rect(100, 100, 250, 250, 25);
  
  
  //citgo text
  fill(citgo);
  textSize(40);
  text("CITGO", 170, 329);
  
  //white neon lines
  strokeCap(ROUND);
  for (int i = 115; i <= 340; i += 20) {
    if (i <= 175) {
      stroke(white1); //for top lines, set color to white1 variable
    } else if (i <= 255) {
      stroke(white2); //for middle lines, set color to white2 variable
    } else {
      stroke(white3); //for bottom lines, set color to white3 variable
    }
    
    if (i == 315) { //if line is the one that intersects with "citgo" text, draw lines on either side of text
      line(115, i, 155, i);
      line(295, i, 335, i);
    } else { //else draw a normal line
      line(115, i, 335, i);
    }
  }
  
  //triangle background
  fill(75);
  noStroke();
  equalTriangle(225, 230, 105);
  
  //red triangles
  noFill();
  for (int i = 105; i > 0; i -= 20) {
    if (i >= 75) { 
      stroke(red1); //for outer triangles, assign red1 variable to color
    } else if (i >= 35) {
      stroke(red2); //for middle triangles, assign red2 variable to color
    } else {
      stroke(red3); //for inner triangles, assign red3 variable to color
    }
    equalTriangle(225, 230, i); //draw an equalateral triangle with i radius
  }
  
  //cycle through time and change colors to brighter version to light up sign
  switch(citgoTime) {
    case 3:
      white1 = brightWhite;
      break;
    case 6:
      white2 = brightWhite;
      break;
    case 9:
      white3 = brightWhite;
      break;
    case 12:
      red1 = brightRed;
      break;
    case 15:
      red2 = brightRed;
      break;
    case 18:
      red3 = brightRed;
      break;
    case 21:
      citgo = brightBlue;
      break;
    case 24:
      resetColors(); //reset sign colors
      break;
  }
}

void fact4() {
  //draw background and text, set fill and fonts
  noStroke();
  frameRate(10);
  background(#000000);
  textSize(32);
  text("I am a Computer Science and Design major", 100, 550);
  fill(#17FF34);
  textFont(sourceCode);
  
  //draw substring of hello world text
  text(helloWorld.substring(0, helloWorldTime), 20, 100);
  //increment helloWorldTime to display more of the text with each call of the method
  if (helloWorldTime < helloWorld.length()) {
    helloWorldTime++;
  } else {
    helloWorldTime = 0; //set back to 0 after displaying the whole string
  }
  
  //reset font
  textFont(sourcePro);
  fill(#FFFFFF);
}

void fact5() {
  //set background initially
  if (carrotTime == 0) {
    background(#B698FF);
  }
  frameRate(60);
  text("I have been vegan for over 2 years", 250, 250);
  //draw carrot at mouseX and mouseY values
  image(carrot, mouseX, mouseY);
  carrotTime++; //increment time so that it only draws background once
}

void fact6() {
  //draw background and text
  frameRate(30);
  background(#FFB71A);
  fill(255);
  text("My hobbies include cooking,", 100, 100);
  image(stove, 400, 285);
  
  //draw bubbles, use corresponding value from timeSub for y value
  fill(200, 200, 200, 191);
  ellipse(550, timeSub[0], 20, 20);
  ellipse(580, timeSub[1], 30, 30);
  ellipse(530, timeSub[2], 32, 32);
  ellipse(560, timeSub[3], 15, 15);
  ellipse(590, timeSub[4], 37, 37);
  ellipse(550, timeSub[5], 20, 20);
  ellipse(580, timeSub[6], 30, 30);
  ellipse(530, timeSub[7], 32, 32);
  ellipse(560, timeSub[8], 15, 15);
  ellipse(590, timeSub[9], 37, 37);
  ellipse(560, timeSub[10], 15, 15);
  ellipse(520, timeSub[11], 37, 37);
  ellipse(550, timeSub[12], 20, 20);
  ellipse(580, timeSub[13], 30, 30);
  
  //decrease each timeSub value so that the bubbles go up
  for (int i = 0; i < timeSub.length; i++) {
    if (timeSub[i] == 0) { //when they reach the top of the screen, send back to the top of the pot
      timeSub[i] = 275;
    } else {
      timeSub[i]--; //else decrease Y value
    }
  }
}

void fact7() {
  //draw background and text
  frameRate(20);
  background(#3C32E0);
  text("swimming,", 50, 50);
  
  //draw waves, timeSub moves waves up and down based on the value
  image(waveBig, 0, 123 + timeSub2[0]);
  image(waveMed, 0, 244 + timeSub2[1]);
  image(waveSmall, 0, 355 + timeSub2[2]);
  
  for (int i = 0; i < timeSub2.length; i++) { //for all timesub values
    if (timeSub2[i] == 30) {
      waveUp[i] = false; //if it gets to 30 make the wave go back down
    } else if (timeSub2[i] == 0) {
      waveUp[i] = true; //if it gets to 0 make the wave go back up
    }
    
    if (waveUp[i]) { //if waveUp is true, increase value so that the wave moves upward
      timeSub2[i]++;
    } else { //else decrease value
      timeSub2[i]--;
    }
  }
}

void fact8() {
  //draw background and text
  background(#7A2EFF);
  text("and painting.", 50, 50);
  //draw paintbrush at mouse location
  image(paintbrush, mouseX, mouseY);
}

void ending() {
  frameRate(60);
  background(#272625);
  textAlign(CENTER, CENTER);
  text("Thats all folks!", 400, 300);
  image(curtain, -693 + curtainMove, 0);
  image(curtain, 800 - curtainMove, 0);
  if (curtainMove == 400) {
  } else {
    curtainMove+=2;
  }
}

//reset colors for citgo sign to darker colors
void resetColors() {
  red1 = darkRed;
  red2 = darkRed;
  red3 = darkRed;
  white1 = darkWhite;
  white2 = darkWhite;
  white3 = darkWhite;
  citgo = darkBlue;
  citgoTime = 0;
}

//draw an equalateral triangle with given x and y as the 
void equalTriangle(float x, float y, float radius) {
  beginShape();
  for (int i = 30; i < 360; i += 120) { //set 3 points at 120 degrees apart, at radius away from midpoint
    vertex(x + radius * cos(radians(i)), y + radius * sin(radians(i)));
  }
  endShape(CLOSE);
}

//increment phase with each mouse click
void mouseClicked() {
  phase += 1;
}
