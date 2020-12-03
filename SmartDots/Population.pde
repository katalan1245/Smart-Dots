class Population {
  Dot[] dots;
  float fitnessSum;
  int gen = 1;
  
  int bestDot = 0;
  int minStep = maxSteps;
  
  Population(int size) {
    dots = new Dot[size];
    for(int i = 0; i < size; i++) {
      dots[i] = new Dot();
    }
  }
  
  // ------------------------------------------------------

  void show() {
     for(int i = 1; i < dots.length; i++) {
       dots[i].show();
     }
     dots[0].show();
  }
  
  // ------------------------------------------------------
  
  void update() {
    for(int i = 0; i < dots.length; i++) {
      if(dots[i].brain.step > minStep)
        dots[i].dead = true;
      else
        dots[i].update();
    }
  }
  
  // ------------------------------------------------------
  
  void calculateFitness() {
    for(int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }
  
  // ------------------------------------------------------
  
  boolean allDotsDead() {
    for(int i = 0; i < dots.length; i++) {
      if(!dots[i].dead && !dots[i].reachedGoal)
        return false;
    }
    return true;
  }
  
  // ------------------------------------------------------
  
  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    
    // The champion of the last generation stays alive
    newDots[0] = dots[bestDot].getBaby();
    newDots[0].isBest = true;
    for(int i = 1; i < dots.length; i++) {
      // Select parent based on fitness
      Dot parent = selectParent();
      // Get baby from parent
      newDots[i] = parent.getBaby();
    }
    
    dots = newDots;
    gen++;
  }
  
  // ------------------------------------------------------
  
  void calculateFitnessSum() {
    fitnessSum = 0;
    for(int i = 0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }
  
  // ------------------------------------------------------
  
  Dot selectParent() {
    float rand = random(fitnessSum);
    float runningSum = 0;
    
    for(int i = 0; i < dots.length; i++) {
      runningSum += dots[i].fitness;
      if(runningSum > rand)
        return dots[i];
    }
    
    // should never get to this line
    System.out.println("This Shouldn't Be Printed!\nError at selectParent()");
    return null;
  }
  
  // ------------------------------------------------------
  
  void mutateBabies() {
    for(int i = 1; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }
  
  // ------------------------------------------------------
  
  void setBestDot() {
    float max = 0;
    int maxInd = 0;
    for(int i = 0; i < dots.length; i++) {
      if(dots[i].fitness > max) {
        max = dots[i].fitness;
        maxInd = i;
      }
    }
    bestDot = maxInd;
    if(dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
    }
  }
  
  // --------------------------------------------------------
  
  void summarize() {
    System.out.println("Generation: " + gen);
    System.out.println("Fitness Sum: " + fitnessSum);
    System.out.println("Min Step: " + minStep);
  }
}
