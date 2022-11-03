class Spaceship {

  float x = 100;
  int y = 100;
  int size = 10;
  PImage theSpaceship;

  Spaceship() {
    x = int(width*0.5);
    y = int(height*0.8);
    size = 10;
    theSpaceship = spaceship.copy();
    theSpaceship.resize(width/8, 0);
  }

  void display() {
    //fill(255, 255, 255);
    noFill();
    //rectMode(CENTER);
    imageMode(CENTER);
    image(theSpaceship, x, y);
    stroke(255, 0, 0);
  }

  void move() {
    x += 10;
    y += 10;
    if (x>width + 5*size/2 || y>height+5*size) {
      x = 0 - 5*size/2;
      y = 0;
    }
  }

  void moveUp() {
    y -= 10*size;
    if (y<=0) {
      y = 0 + 10*size;
    }
  }

  void moveDown() {
    y += 10*size;
    if (y >= height - 10*size) {
      y = height - 10*size;
    }
  }

  void moveRight() {
    x += 10*size;
    if (x >= width - 10*size/2 ) {
      x = width - 10*size/2;
    }
  }

  void moveLeft() {
    x -= 10*size;
    if (x <= 0 - 10*size/2) {
      x = 0 + 10*size/2;
    }
  }

  boolean checkCollision(Enermy theAlien) {
    boolean isCollision = false;
    PVector[] vertices;
    vertices = new PVector[3];
    vertices[0] = new PVector(x-100 + theSpaceship.width/2, y - theSpaceship.height/2);
    vertices[1] = new PVector(x - theSpaceship.width/2, y+200 - theSpaceship.height/2);
    vertices[2] = new PVector(x + theSpaceship.width/2, y + theSpaceship.height/2);
    // visual debugging to place rectangles for collision over the image.
    //rectMode(CORNER);
    //stroke(0, 255, 0);
    //triangle(x-100 + theSpaceship.width/2, y - theSpaceship.height/2, x - theSpaceship.width/2, y+200 - theSpaceship.height/2, x + theSpaceship.width/2, y + theSpaceship.height/2);
    //rect(theAlien.x - theAlien.myAlien.width/2, theAlien.y - theAlien.myAlien.height/2, theAlien.myAlien.width, theAlien.myAlien.height);
    isCollision = polyRect(vertices, theAlien.x - theAlien.myAlien.width/2, theAlien.y - theAlien.myAlien.height/2, theAlien.myAlien.width, theAlien.myAlien.height);
    return isCollision;
  }

  // POLYGON/RECTANGLE
  boolean polyRect(PVector[] vertices, float rx, float ry, float rw, float rh) {
    //triangle(x-100 + theSpaceship.width/2, y - theSpaceship.height/2, x - theSpaceship.width/2, y+200 - theSpaceship.height/2, x + theSpaceship.width/2, y + theSpaceship.height/2);
    // go through each of the vertices, plus the next
    // vertex in the list
    int next = 0;
    for (int current=0; current<vertices.length; current++) {
      // get next vertex in list
      // if we've hit the end, wrap around to 0
      next = current+1;
      if (next == vertices.length) next = 0;
      // get the PVectors at our current position
      // this makes our if statement a little cleaner
      PVector vc = vertices[current];    // c for "current"
      PVector vn = vertices[next];       // n for "next"
      // check against all four sides of the rectangle
      boolean collision = lineRect(vc.x, vc.y, vn.x, vn.y, rx, ry, rw, rh);
      if (collision) {
        return true;
      };
    }
    return false;
  }

  // LINE/RECTANGLE
  boolean lineRect(float x1, float y1, float x2, float y2, float rx, float ry, float rw, float rh) {
    // check if the line has hit any of the rectangle's sides
    // uses the Line/Line function below
    boolean left =   lineLine(x1, y1, x2, y2, rx, ry, rx, ry+rh);
    boolean right =  lineLine(x1, y1, x2, y2, rx+rw, ry, rx+rw, ry+rh);
    boolean top =    lineLine(x1, y1, x2, y2, rx, ry, rx+rw, ry);
    boolean bottom = lineLine(x1, y1, x2, y2, rx, ry+rh, rx+rw, ry+rh);
    // if ANY of the above are true,
    // the line has hit the rectangle
    if (left || right || top || bottom) {
      return true;
    }
    return false;
  }

  // LINE/LINE
  boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    // calculate the direction of the lines
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      return true;
    }
    return false;
  }
}
