float x1 = 0;
float y1 = 0;

void setup(){
  size(500, 500);

}

void draw(){
  background(255);

  float[] vector = {100, (float)Math.toRadians(-90.0)};
  float[] origin1 = {200, 200};

  stroke(150);
  rect(200, 200, 100, 100);

  float[] points1 = polarToCartesian(vector, origin1);
  stroke(#7aeb34);
  System.out.println(points1[0]);
  line(200, 200, points1[0], points1[1]);

}

float[] polarToCartesian(float[] vector, float[] origin){
  float nx = (float)vector[0] * (float)Math.cos(vector[1]);
  float ny = (float)vector[0] * (float)Math.sin(vector[1]);

  float[] output = {nx + origin[0], ny + origin[1]};

  return output;
}
