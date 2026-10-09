class Button {
  //Member Variables
  float x, y, w, h; //x position, y position, width, and height
  String label; //symbol for the button
  boolean hover, isNum; //whether or not the mouse is over the button
  color normColor, hoverColor; // colors for the button for hovered over, not hovered over variants
  //Constructor
  Button(float x, float y, String label, color normColor, color hoverColor) {
    this.x = x;
    this.y = y;
    w = 80;
    h = 40;
    this.label = label;
    hover = false;
    this.normColor = normColor;
    this.hoverColor = hoverColor;
  }
  //Member Methods
  void display() {
    textSize(30);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    if (hover()) {
      fill(hoverColor);
      rect(x, y, w, h);
    } else {
      fill(normColor);
      rect(x, y, w, h);
    }
    fill(255);
    text(label, x, y-4);
  }
  boolean hover() {
    return mouseX >=x-w/2 &&
      mouseX <=x+w/2 &&
      mouseY >=y-h/2 &&
      mouseY <=y+h/2;
  }
}
