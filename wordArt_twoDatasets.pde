/*----------------------------------------
|    Visual Comparison of Two Datasets    |
|      Coded by: Erik Dillaman            |
 ----------------------------------------*/

ArrayList<Circle> circles;
Table t1, t2;
int xOffset = -200;
int yOffset = 150;
float scale = 1.5;  // set the drawing size
int iterations = 8000;
int count = 0; 
int circleIndex = 0;
boolean theEnd = false;

void setup()
{
  size(1800, 1200, P3D);
  circles = new ArrayList<Circle>();
  t1 = loadTable("HCAnalysis.csv");   // Change this to the CSV file of the first dataset
  t2 = loadTable("DTAnalysis.csv");   // Change this to the CSV file of the second dataset
  //  Both imported datasets should be parsed using the Word Counter sketch included in one of my repos
}

void draw()
{
  noLoop();  
  background(0);
  int attempts = 0; 

  for (int i = 1; i < iterations; i++) {
    boolean foundOne = false;
    boolean foundTwo = false;
    
    while (!theEnd && !foundOne && attempts < 1000) {
      Circle newC1 = newCircle(t1.getString(i, 0), t1.getInt(i, 1), 1, i);
      if (newC1 != null) {
        circles.add(newC1);
        foundOne = true;
      }
      if (theEnd) break;
      attempts++;
    }
    
    while (!theEnd && !foundTwo && attempts < 1000) {
      Circle newC2 = newCircle(t2.getString(i, 0), t2.getInt(i, 1), 2, i);
      if (newC2 != null) {
        circles.add(newC2);
        foundTwo = true;
      }
      if (theEnd) break;
      attempts++;
    }

    if (theEnd || attempts >= 1000) {
      println("Total circles: "+circles.size());
      println("FINISHED");
      break;
    }
  }
  for (Circle c : circles) {
    c.show();
  }
}

Circle newCircle(String word, int freq, int source, int position)
{

  float x = width/2+xOffset; 
  float y = height/2+yOffset;  
  float r = int((freq/scale));
  if (r < 10) r = 10;
  float d;
  d = 0;

  boolean valid = true;

  if (count > 0) {
    Circle circ = circles.get(circleIndex);

    //int num = int(random(0, 365));
    //for (int i = num; i < num+360; i++) {
    
    for (int i = 0; i < 360; i++) {
      x = circ.x+(circ.r/2+r/2)*cos(i*PI/180);
      y = circ.y+(circ.r/2+r/2)*-sin(i*PI/180);
      for (Circle c : circles) {
        d = dist(x, y, c.x, c.y);
        if ((d < (c.r/2+r/2)) || outsideEdges(x, y, r/2)) {
          valid = false;
          break;
        }
      }
      if (valid) {
        break;
      } else {
        if (circleIndex < circles.size()-1 && i >= 359) {
          circleIndex++;
          valid = false;
          break;
        } else if (circleIndex == circles.size()-1 && i >= 359) {
          theEnd = true;
          valid = false;
          break;
        }
        valid = true;
      }
      //   println(i);
    }

  }

  if (valid || count < 1) {
    count ++;
    return new Circle(x, y, r, source, word, position);
  } else {
    return null;
  }
}

boolean outsideEdges(float x, float y, float r)
{
  return (x+r > width || x-r < 0 || y+r > height || y-r < 0);
}
