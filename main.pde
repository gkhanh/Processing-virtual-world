/*
 ------------------------------------------------
 ------------ Alien Shooter Game ----------------
 ------------------------------------------------
 
 Created by: Gia Khanh Le
 Student Nr: 493341
 */
 
//Library import
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Global variable initialization
int amountOfEnemies = 10;
Spaceship player;
Enermy enermy;
Enermy[] enermies = new Enermy[amountOfEnemies];
//Insert images
PImage spaceship;
PImage alien;
PImage backgroundImage;
PImage mainScreenImage;
//Sound initialization
Minim minim;
AudioSample moveSound;
AudioSample shootSound;
//Score initialization
int score = 0;

final int INTRO_SCREEN = 1;
final int MAIN_SCREEN = 2;
final int END_SCREEN = 3;
int currentScreen = 1;

void setup() {
  size(1600, 900);
  //size(800,600); //for testing
  //insert one pager background
  rectMode(CENTER);
  //load characters' images
  backgroundImage = loadImage("background.png");
  spaceship = loadImage("spaceship.png");
  alien = loadImage("alien.png");
  mainScreenImage = loadImage("mainscreen.png");
  //spawn 10 enermies on the screem
  for (int i = 0; i < enermies.length; i++) {
    enermies[i] = new Enermy();
  }
  player = new Spaceship();
  minim = new Minim(this);
  moveSound = minim.loadSample("BD.mp3",512);
  shootSound = minim.loadSample("shoot.mp3",512);
}

void draw() {
  switch(currentScreen){
    case INTRO_SCREEN: startScreen();
    break;
    case MAIN_SCREEN: mainScreen();
    break;
    case END_SCREEN: endScreen();
    break;
  }
}

void startScreen(){
  background(mainScreenImage);
  stroke(4);
  fill(255,255,255);
  rect(800,450,200,80);
  fill(0,230,0);
  textSize(50);
  text("PLAY", 750,470);
}

void mainScreen(){
  background(backgroundImage);
  //background(0,0,0); //for testing
  //initialize spaceship
  player.display();
  //initialize alien character
  for (int i = 0; i < enermies.length; i++) {
    enermies[i].display();
    enermies[i].move();
    if (player.checkCollision(enermies[i])) {
      score = 0;
      enermies[i].resetPosition();
      moveSound.trigger();
      println("Got hit!");
      currentScreen = END_SCREEN;
    }
    if (enermies[i].checkCollisison(mouseX, mouseY) && mousePressed) {
      println("Alien UFO destroyed!");
      score = score +1;
      shootSound.trigger();
      enermies[i].resetPosition();
    }
  }
  //Add score text
  textSize(30);
  fill(0, 255, 0);
  text("Score : " + score, width*9/10, 30);
}

void endScreen(){
  background(0,0,0);
  fill(230);
  textSize(100);
  text("GAME OVER", 650, 400);
  fill(255);
  rect(800,650,200,80);
  fill(20);
  textSize(40);
  text("MAIN MENU", width/2, 700);
}

void mousePressed(){
  if(currentScreen == INTRO_SCREEN){
    if(mouseX > 700 && mouseX < 900 && mouseY > 370 && mouseY < 530){
      currentScreen = MAIN_SCREEN;
    }
  }
  else if(currentScreen == END_SCREEN){
    if(mouseX > 700 && mouseX < 900 && mouseY > 570 && mouseY < 730){
      currentScreen = INTRO_SCREEN;
    }
  }
}

//Controlling spaceship
void keyPressed() {
  if (key == 'w') {
    player.moveUp();
  }
  if (key == 's') {
    player.moveDown();
  }
  if (key == 'a') {
    player.moveLeft();
  }
  if (key == 'd') {
    player.moveRight();
  }
}
