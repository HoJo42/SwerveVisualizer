float x1 = 0;
float y1 = 0;

void setup(){
  size(500, 500);

}

void draw(){
  background(255);

  float[] vector = {100, (float)Math.toRadians(-45.0)};
  float[] origin1 = {200, 200};
  float[] origin2 = {300, 200};
  float[] origin3 = {200, 300};
  float[] origin4 = {300, 300};

  stroke(150);
  rect(200, 200, 100, 100);

  float[] points1 = polarToCartesian(vector, origin1);
  stroke(#7aeb34);
  line(200, 200, points1[0], points1[1]);

  float[] points2 = polarToCartesian(vector, origin2);
  line(origin2[0], origin2[1], points2[0], points2[1]);

  float[] points3 = polarToCartesian(vector, origin3);
  line(origin3[0], origin3[1], points3[0], points3[1]);

  float[] points4 = polarToCartesian(vector, origin4);
  line(origin4[0], origin4[1], points4[0], points4[1]);

}

float[] polarToCartesian(float[] vector, float[] origin){
  float nx = (float)vector[0] * (float)Math.cos(vector[1]);
  float ny = (float)vector[0] * (float)Math.sin(vector[1]);

  float[] output = {nx + origin[0], ny + origin[1]};

  return output;
}
