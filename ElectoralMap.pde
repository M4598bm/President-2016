class ElectoralMap {
  PImage map;
  PImage mapBACK;

  Table states;


  // Constructor
  // Precondition: map is an image that's always the same
  // Postcondition: creates the Object
  ElectoralMap() {
    map = loadImage("electoralmap.png");// Request instead?
    mapBACK = loadImage("electoralmapBACK.png");
    states = loadTable("states.csv", "header");
    map.resize(width, height-30);
    mapBACK.resize(width, height-30);
  }


  // display the map
  // Precondition: map is an image that can be displayed with image()
  // Postcondition: the map is displayed
  void display() {
    background(255);
    image(map, 0, 30);

    // Do anything you might want to do with the map
    
    // TESTS:
    //displayLinesText();
    //colorState(0, color(0, 0, 150));
    
    updatePixels();
  }


  // finds the colors of each state in electoralMapBACK
  // Precondition: electoralmapBACK.png is a file where states are colored according to this formula
  // Postcondition: an array of colors in alphabetical order for indeces of each state
  color[] stateColors() {
    color[] colors = new color[states.getRowCount()];
    int red = -1;
    int gre = 0;
    int blu = 0;
    for (int i = 0; i < states.getRowCount(); i++) {
      if (red == -1) {
        red = 15;
      }
      else if (red > 0) {
        red += 15;
        if (red > 255) {
          red = 0;
          gre = 15;
        }
      }
      else if (gre > 0) {
        gre += 15;
        if (gre > 255) {
          gre = 0;
          blu = 15;
        }
      }
      else if (blu > 0) {
        blu += 15;
      }
      colors[i] = color(red, gre, blu);
    }
    return colors;
  }


  // find the state with that color (for clicking on a state)
  // Precondition: the states have different colors, mouse was prob clicked on a state
  // Postcondition: returns what state, if a state at all, has color c
  int findState(color c) {
    color[] colors = stateColors();
    for (int i = 0; i < states.getRowCount(); i++) {
      if (colors[i] == c) {
        return i;
      }
    }
    return -1;
  }


  // colors a whole state
  // Precondition: s is a state index, c is a color
  // Postcondition: all pixels within state int s are colored color c
  void colorState(int s, color c) {
    loadPixels();
    mapBACK.loadPixels();
    if (s > -1 && s < 51) {
      for (int i = 0; i < mapBACK.pixels.length; i++) {
        if (mapBACK.pixels[i] == stateColors()[s]) {
          pixels[i] = c;
        }
      }
    }
    updatePixels();
    displayLinesText();
  }


  // colors whatever state includes x, y
  // Precondition: x and y are coordinates, c is a color
  // Postcondition: all pixels in the state with x, y are colored color c
  void colorStateAt(int x, int y, color c) {
    if (findState(mapBACK.pixels[y*width+x]) != -1) {
      for (int i = 0; i < mapBACK.pixels.length; i++) {
        if (mapBACK.pixels[i] == mapBACK.pixels[y*width+x]) {
          pixels[i] = c;
        }
      }
    }
    updatePixels();

    displayLinesText();
  }

  // Displays any lines or text that should be black
  // Precondition: The electoral map is displayed
  // Postcondition: Black lines are drawn over shading
  void displayLinesText() {
    mapBACK.loadPixels();
    loadPixels();
    for (int i = 0; i < map.pixels.length; i++) {
      if (!(map.pixels[i] > color(120) || (map.pixels[i] > -16750000 && map.pixels[i] < -16730000))) {
        pixels[i] = color(0);
      }
    }
    updatePixels();
  }
}