class ElectoralMap {
  PImage map;

  ElectoralMap() {
    map = loadImage("electoralmap.jpg");
  }

  // display the map
  // Precondition: map is an image that can be displayed with image()
  // Postcondition: the map is displayed
  void display() {
    image(map, 0, 30, width, height);
  }
}
