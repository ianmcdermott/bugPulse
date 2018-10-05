//to do 
//optimize boids for regional crowfollow
//optimize boids to only detect a chunk of the array list of points

int w = 800;
int cols;
int rows;
float d = w-10;
float r = d/2; 
float angle = 0;
float strokeW = 1;
float angleRes = .007;
Guide[] vertGuides;
Guide[] horizGuides;
Curve[][] curves;
int phaseX = 5;
int phaseY = 0;

boolean beat1 = true;

float osc1 = 50;
float osc2 = 50;
int count1 = 0;
int count2 = 0;

boolean pulseOn = false;
boolean startCount1 = false;
boolean startCount2 = false;

PImage lbug;
//boolean osc = true;

boolean debug = false;
boolean lissalines = true;
boolean particlesOn = false;
boolean fractalsOn = false;
boolean springsOn = false;
boolean boidsOn = false;
boolean flockingOn = false;
boolean pathFollow = true;

void setup() {
  size(2000, 1200, P2D);
  //fullScreen(P2D);
  cols = 1;//width/w;
  rows = 1;//height/w;
  curves = new Curve[rows][cols];
  for (int i =0; i < cols; i++) {
    for (int j =0; j < rows; j++) {
      curves[j][i] = new Curve();
    }
  }
  lbug = loadImage("bug-01.png");
  smooth();
  vertGuides = new Guide[rows];
  for (int i = 0; i < rows; i ++) {
    vertGuides[i] = new Guide(true);
  }
  horizGuides = new Guide[cols];

  for (int i = 0; i < cols; i ++) {
    horizGuides[i] = new Guide(false);
  }
}

void draw() {
  background(0);
  stroke(255);
  noFill();

  //horiz
  for (int i = 0; i < cols; i ++) {
    horizGuides[i].update(osc1);//i+phaseX);
    horizGuides[i].display();

    for (int j = 0; j < rows; j++) {
      curves[j][i].setX(horizGuides[i].cx+horizGuides[i].x);
    }
  }
  //vert
  for (int i = 0; i < rows; i ++) {
    vertGuides[i].update(osc2);//i);
    vertGuides[i].display();

    for (int j = 0; j < cols; j++) {
      curves[i][j].setY(vertGuides[i].cy+vertGuides[i].y);
    }
  }

  for (int j =0; j < rows; j++) {
    for (int i =0; i < cols; i++) {
      curves[j][i].addPoint();
      curves[j][i].show();
    }
  }

  angle-= angleRes;

  if (angle < -TWO_PI) {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        curves[j][i].reset();
      }
    }
    angle = 0;
  }

  checkPulse();
}

void keyPressed() {
  if (key == 'p' || key == 'P') particlesOn = !particlesOn;
  if (key == 'l' || key == 'L') lissalines = !lissalines;
  if (key == 'd' || key == 'D') debug = !debug;
  if (key == 'f' || key == 'F') fractalsOn = !fractalsOn;
  if (key == 'b' || key == 'B') boidsOn = !boidsOn;
  if (key == 's' || key == 'S') springsOn = !springsOn;
  if (key == 'f' || key == 'F') {
    flockingOn = !flockingOn;
    pathFollow = !pathFollow;
  }
  if (key == 'c' || key == 'C') clearVisuals();
  if (key == 'q') {
    if (beat1) {
      count1 = 0;
      startCount1 = true;
    } else {
      count2 = 0;
      startCount2 = true;
    }
    
    flockingOn = true;
  }
}

void keyReleased() {
  if (key == 'q') {
    startCount1 = false;
    startCount2 = false;

    curves[0][0].reset();
    beat1 = !beat1;
    
    flockingOn = false;
  }
}

void checkPulse() {
  if (startCount1) {
    count1++;
    osc1 = count1;
  } else if (startCount2) {
    count2++;
    osc2 = count2;
  } 
  println("Osc1: "+osc1);
  println("Osc2: "+osc2);
}
void clearVisuals() {
  debug = false;
  lissalines = false;
  particlesOn = false;
  fractalsOn = false;
  springsOn = false;
  boidsOn = false;
}

void getPulse() {
  while (pulseOn) {
    if (startCount1) count1++;
    else if (startCount2) count2++;
    //}
    //return count;
  }
}
