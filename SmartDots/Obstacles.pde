class Obstacles {
  
  Obstacle[] obstacles;
  int obstaclesCount;
  
  Obstacles(int size) {
    obstacles = new Obstacle[size];
    obstaclesCount = 0;
  }
  
  void add(int x, int y, int w, int h) {
    obstacles[obstaclesCount] = new Obstacle(x,y,w,h);
    obstaclesCount++;
  }
  
  void show() {
     for(int i = 0; i < obstaclesCount; i++) {
       obstacles[i].show();
     }
  }
  
  boolean collide(Dot dot) {
    for(int i = 0; i < obstaclesCount; i++) {
      if(obstacles[i].collide(dot))
        return true;
    }
    return false;
  }
  
  private class Obstacle {
    int x;
    int y;
    int w;
    int h;
    
    Obstacle(int x, int y, int w, int h) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
    }
    
    void show() {
      fill(0,0,255);
      rect(x,y,w,h);
    }
    
    boolean collide(Dot dot) {
      if(dot.pos.x + (circleRadius/2) > x && dot.pos.x - (circleRadius/2) < x + w) {
        if(dot.pos.y + (circleRadius/2) > y && dot.pos.y - (circleRadius/2) < y + h)
          return true;
      }
      return false;
    }
  }
}
