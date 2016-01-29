class ElectoralMap {
  PImage map;
  int[] statePixels;
  int stateCount;

  // temp
  boolean bool;

  // Constructor
  // Precondition: map is an image that's always the same
  // Postcondition: creates the Object
  ElectoralMap() {
    map = requestImage("electoralmap.jpg");

    loadPixels();

    statePixels = new int[pixels.length];

    bool = false;
  }

  void colorStateHelp(int x, int y) {
    if (pixels[y*width+x] == color(255)) {
      pixels[y*width+x] = color(0, 0, 200);
      statePixels[y*width+x] = stateCount;
      updatePixels();
      colorStateHelp(x+1, y);
      colorStateHelp(x, y+1);
      colorStateHelp(x-1, y);
      colorStateHelp(x, y-1);
    }
  }

  void colorState(int x, int y) {
    loadPixels();
    colorStateHelp(x, y);
    updatePixels();
  }

  // display the map
  // Precondition: map is an image that can be displayed with image()
  // Postcondition: the map is displayed
  void display() {
    image(map, 0, 30, width, height);
  }
}
