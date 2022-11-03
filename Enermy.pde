//Alien class
class Enermy {
  float x = 200;
  int y = 200;
  float size = 0.5;
  PImage myAlien;
  int speed = 1;

  Enermy() {
    x = int(random(1*width));
    y = int(random(height*0.2));
    speed = (int)random(1, 5);
    size = random(0.5, 1.5);
    myAlien = alien.copy();
    myAlien.resize(int(size*width/20), 0);
  }

  void display() {
    noFill();
    rectMode(CENTER);
    imageMode(CENTER);
    image(myAlien, x, y);
  }

  void move() {
    y+=speed;
    if (x>width + 5*size/2 || y>height+5*size) {
      x = int(random(myAlien.width/2, width - myAlien.width/2));
      y = -myAlien.height/2;
      speed = (int) random(1, 5);
    }
  }

  void resetPosition() {
    x = int(random(myAlien.width/2, width - myAlien.width/2));
    y = -myAlien.height/2;
  }

  boolean checkCollisison(int pointX, int pointY) {
    boolean isCollision = false;
    rectMode(CORNER);
    stroke(0, 255, 0);
    // visual debugging to place rectangles for collision over the image.
    //rect(x - myAlien.width/2, y - myAlien.height/2, myAlien.width, myAlien.height);
    isCollision = pointRect(pointX, pointY, x - myAlien.width/2, y - myAlien.height/2, myAlien.width, myAlien.height);
    return isCollision;
  }

  // POINT/RECTANGLE
  boolean pointRect(float px, float py, float rx, float ry, float rw, float rh) {
    // is the point inside the rectangle's bounds?
    if (px >= rx &&        // right of the left edge AND
      px <= rx + rw &&   // left of the right edge AND
      py >= ry &&        // below the top AND
      py <= ry + rh) {   // above the bottom
      return true;
    }
    return false;
  }
}
