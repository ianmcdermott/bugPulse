class Curve {
  ArrayList<PVector> path;
  PVector curr;
  int numBoids = 500;

  Track track;

  ParticleSystem ps;
  Flock flock;
  Curve() {
    path = new ArrayList<PVector>();
    curr = new PVector();
    ps = new ParticleSystem(new PVector(0, 0));

    flock = new Flock();
    // Add an initial set of boids into the system
    for (int i = 0; i < numBoids; i++) {
      flock.addBoid(new Boid(width/2, height/2, random(.25, 3), random(1, 4), random(.09, .5), random(0, 1), random(.1, .9)));
    }
    track = new Track(path);
  }

  void addPoint(int displayWingsFrame) {
    if (angle > -TWO_PI) {
      path.add(curr);
      track.update(path);
    }
    if (particlesOn) {
      ps.addParticle(new PVector(curr.x, curr.y));
      ps.run();
    }

    // Add an initial set of boids into the system

    if (fractalsOn) {
    }


    if (boidsOn) {
      flock.run(displayWingsFrame);
    }
  }

  void setX(float x) {
    curr.x = x;
  }

  void reset() {
    path.clear();
  }

  void setY(float y) {
    curr.y = y;
  }
  void show() {
    stroke(255, 50);
    strokeWeight(strokeW);
    noFill();
    if (lissalines) {
      pushMatrix();
      //translate(-w*3/4, -w*3/4);
      beginShape();
      for ( PVector v : path) {
        vertex(v.x, v.y);
      }

      endShape();
      popMatrix();
    }
    if (debug) {
      strokeWeight(strokeW*8);
      point(curr.x, curr.y);
    }
    curr = new PVector();
  }
}
