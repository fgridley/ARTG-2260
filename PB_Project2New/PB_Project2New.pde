/*
Fiona Gridley
Project 2: Interactive toy
create shapes representing certain sound frequencies from music
Programming Basics Summer 1 2018
*/

import ddf.minim.*;
import ddf.minim.analysis.*;

//songs and sound analysis variables
Minim minim;
FFT fft;
AudioPlayer introSong;
AudioPlayer songChoice1;
AudioPlayer songChoice2;
AudioPlayer songChoice3;
AudioPlayer songChoice4;
AudioPlayer curSong;
int bands = 512;
float[] spectrum = new float[bands];

ArrayList<IMusShape> shapes = new ArrayList<IMusShape>(); //Arraylist of shapes
boolean isStart; //is the program in starting mode
boolean isCircle; //is the program in circle mode
int rectWidth; //width of display rectangles
int rectHeight; //height of display rectangles
int leftRectX; //X coordinate for left rectangles
int rightRectX; //x coordinate for right rectangles
int topRectY; //y coordinate for top rectangles
int botRectY; //y coordinate for top rectangles
PFont sourcePro; //primary font

void setup() {
  //initializing display characteristics
  size(512, 512);
  ellipseMode(CENTER);
  noStroke();
  textAlign(CENTER);
  isStart = true;
  isCircle = false;
  sourcePro = createFont("SourceSansPro-Bold", 32); //set sourcePro to SourcePro font
  textFont(sourcePro); //set program font to SourcePro
  
  //initializing sound files
  minim = new Minim(this);
  introSong = minim.loadFile("jeopardy.mp3", 1024);
  songChoice1 = minim.loadFile("wii.mp3", 1024);
  songChoice2 = minim.loadFile("rockstar.mp3", 1024);
  songChoice3 = minim.loadFile("africa.mp3", 1024);
  songChoice4 = minim.loadFile("rickroll.mp3", 1024);
  
  //start intro song
  curSong = introSong;
  curSong.loop();
  fft = new FFT( curSong.bufferSize(), curSong.sampleRate() );
  
  //set rectangle width, height, and coordinates
  rectWidth = 150;
  rectHeight = 75;
  leftRectX = 125;
  rightRectX = 387;
  topRectY = 200;
  botRectY = 350;
}      

void draw() { 
  background(0);
  
  if (isStart) { //if in start state, show start display
    startDisplay();
  } else { //else analyze song and draw shapes
    fft.forward(curSong.mix);
    for (int i = 0; i < bands; i++) {
      spectrum[i] = fft.getBand(i);
    }
    for(int i = 0; i < shapes.size(); i+=1) {
      shapes.get(i).drawShape(spectrum);
    }
  }
}

//display the 4 song options
void startDisplay() {
  textSize(40);
  fill(255);
  text("Select a song", 256, 60);
  fill(#E3FF4B);
  rectMode(CENTER);
  rect(leftRectX, topRectY, rectWidth, rectHeight);
  rect(rightRectX, topRectY, rectWidth, rectHeight);
  rect(leftRectX, botRectY, rectWidth, rectHeight);
  rect(rightRectX, botRectY, rectWidth, rectHeight);
  fill(#FF2CB2);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(24);
  text("?", leftRectX, topRectY);
  text("?", rightRectX, topRectY);
  text("?", leftRectX, botRectY);
  text("?", rightRectX, botRectY);
}

//select song based on given x and y coordinates of a click
void selectSong(float x, float y) {
  if (x >= rightRectX - 0.5*rectWidth && x <= rightRectX + 0.5*rectWidth && y >= topRectY - 0.5*rectHeight && y <= topRectY + 0.5*rectHeight) {
    curSong.pause();
    curSong = songChoice1;
    playSong();
  } else if (x >= rightRectX - 0.5*rectWidth && x <= rightRectX + 0.5*rectWidth && y >= botRectY - 0.5*rectHeight && y <= botRectY + 0.5*rectHeight) {
    curSong.pause();
    curSong = songChoice2;
    playSong();
  } else if (x >= leftRectX - 0.5*rectWidth && x <= leftRectX + 0.5*rectWidth && y >= topRectY - 0.5*rectHeight && y <= topRectY + 0.5*rectHeight) {
    curSong.pause();
    curSong = songChoice3;
    playSong();
  } else if (x >= leftRectX - 0.5*rectWidth && x <= leftRectX + 0.5*rectWidth && y >= botRectY - 0.5*rectHeight && y <= botRectY + 0.5*rectHeight) {
    curSong.pause();
    curSong = songChoice4;
    playSong();
  }
}

//play the current song and start the FFT analysis
void playSong() {
  curSong.play(0);
  fft = new FFT(curSong.bufferSize(), curSong.sampleRate());
  isStart = false;
}

//generate a random color
color randColor() {
  return color(random(255), random(255), random(255));
}

void mouseClicked() {
  if (isStart) { //If the start screen is showing, select song
    selectSong(mouseX, mouseY);
  } else if (isCircle) { //else if in circle mode, add circle
    shapes.add(new MusCircle(mouseX, mouseY));
  } else { //else add triangle
    shapes.add(new MusTriangle(mouseX, mouseY));
  }
}

void keyPressed() {
  if (key == ' ') { //return to main menu and clear Arraylist of shapes
    curSong.pause();
    curSong = introSong;
    curSong.play(0);
    isStart = true;
    while (shapes.size() > 0) {
      shapes.remove(0);
    }
  } else if (key == 'c') { //change shape mode to circles
    isCircle = true;
  } else if (key == 't') { //change shape mode to triangles
    isCircle = false;
  }
}
