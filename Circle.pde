class Circle
{

  float x;
  float y;
  float r;
  int source, position;
  String theWord;


  Circle(float x_, float y_, float r_, int source_, String theWord_, int position_) {
    x = x_;
    y = y_;
    r = r_;
    source = source_;
    theWord = theWord_;
    position = position_;
  }

  void show() {
    if (source == 2) fill(255-position/2, 55, 0); else fill (0, 55, 255-position/2);
    noStroke();
    pushMatrix();
    translate(x, y, 0);
    lights();
    sphere(r/2);
    if (source == 2) fill(#F5B4B4); else fill (0, 180, 255);
    stroke(0);
    strokeWeight(1);
    textAlign(CENTER, CENTER);
    textSize(r/5+5);
    text(theWord, 0, 0, r/2);
    popMatrix();
  }
  
}
