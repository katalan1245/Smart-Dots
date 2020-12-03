class Goal {
  PVector pos;
  
  Goal(int x, int y) {
    pos = new PVector(x,y);
  }
  
  void show() {
    fill(255,0,0);
    ellipse(pos.x,pos.y,goalRadius,goalRadius);
  }
  
  boolean collide(Dot dot) {
    if(dist(dot.pos.x,dot.pos.y,pos.x,pos.y) < 2 * circleRadius)
        return true;
    return false;
  }
}
