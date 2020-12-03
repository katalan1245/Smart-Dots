Population pop;
Goal goal;
Obstacles obstacles;
final int maxSteps = 1000;
final int circleRadius = 2;
final int championRadius = 4;
final int goalRadius = 10;

void setup() {
  size(800,800);
  frameRate(60);
  pop = new Population(1000);
  goal = new Goal(400,10);
  obstacles = new Obstacles(100);
  obstacles.add(100,400,600,10);
}

void draw() {
  background(255);
  goal.show();
  obstacles.show();

  if(pop.allDotsDead()) {
    // Genetic Algorithm
    pop.calculateFitness(); //<>//
    pop.naturalSelection();
    pop.mutateBabies();
    pop.summarize();
  } else {
    pop.update();
    pop.show();
  }
}
