class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  
  float fitness = 0;
  
  Dot() {
    this.brain = new Brain(maxSteps);

    this.pos = new PVector(width/2, height-10);
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
  }
  
  // ------------------------------------------------------------------------------

  void show() {
    if(isBest) {
      fill(0,255,0);
      ellipse(pos.x, pos.y, 2 * championRadius, 2 * championRadius);
    } else {
      fill(0);
      ellipse(pos.x, pos.y, 2 * circleRadius, 2 * circleRadius);
    }
  }
  
  // ------------------------------------------------------------------------------

  void move() {
    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      dead = true;
    }
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }
  
  // ------------------------------------------------------------------------------
  
  void update() {
    if(!dead && !reachedGoal) {
      move();
      if(pos.x < circleRadius || pos.y < 2 || pos.x > width - 2 || pos.y > height - 2) {
        dead = true;
      } else if(goal.collide(this)) {
        reachedGoal = true; 
      } else if(obstacles.collide(this)) {
        dead = true;
      }
    }
  }
  
  // ----------------------------------------------------------------------------
  
  void calculateFitness() { //<>//
    if(reachedGoal) {
      fitness = 1.0/16.0 + 10000.0 / (float)(brain.step * brain.step);
    } else {
      float distanceToGoal = dist(pos.x,pos.y,goal.pos.x,goal.pos.y);
      fitness = 1.0 / (distanceToGoal); 
    }  
  }
  
  // ------------------------------------------------------------------------------
  
  Dot getBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }  
  
}
