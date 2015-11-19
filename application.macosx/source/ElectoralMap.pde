class ElectoralMap {
  PImage map;
  
  ElectoralMap() {
    map = loadImage("electoralmap.jpg");
  }
  
  void display() {
    image(map, 0, 30, width, height);
  }
}