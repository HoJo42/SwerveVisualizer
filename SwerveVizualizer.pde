import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlDevice controller;
ControlIO control;

float leftX;
float leftY;
float rightX;
float rightY;

SwerveModule topRight;
SwerveModule topLeft;
SwerveModule BottomRight;
SwerveModule BottomLeft;

void setup(){
  size(500, 500);
    float rotationAngleTR = (float)Math.toRadians(225);
    float rotationAngleTL = (float)Math.toRadians(135);
    float rotationAngleBR = (float)Math.toRadians(315);
    float rotationAngleBL = (float)Math.toRadians(45);

    float[] originTL = {200, 200};
    float[] originTR = {300, 200};
    float[] originBR = {300, 300};
    float[] originBL = {200, 300};

  control = ControlIO.getInstance(this);
  controller = control.getMatchedDevice("xboxSwerve");

  topRight = new SwerveModule(originTR, rotationAngleTR);
  topLeft = new SwerveModule(originTL, rotationAngleTL);
  BottomRight = new SwerveModule(originBR, rotationAngleBR);
  BottomLeft = new SwerveModule(originBL, rotationAngleBL);


  if (controller == null){
    println("Controller gone");
    System.exit(-1);
  }
}

void draw(){
  getUserInput();
  background(255);

  float theta = (float)Math.atan2((double)leftY, (double)leftX);
  float r = (float)leftY/(float)Math.sin(theta);
  println(theta);

  float[] transVector = {r, theta};
  float[] transCarte = polarToCartesian(transVector);

  float[] rotVectorTR = topRight.calculateRotationVector(rightX);
  float[] rotVectorTL = topLeft.calculateRotationVector(rightX);
  float[] rotVectorBR = BottomRight.calculateRotationVector(rightX);
  float[] rotVectorBL = BottomLeft.calculateRotationVector(rightX);

  float[] rotCarteTR = polarToCartesian(rotVectorTR);
  float[] rotCarteTL = polarToCartesian(rotVectorTL);
  float[] rotCarteBR = polarToCartesian(rotVectorBR);
  float[] rotCarteBL = polarToCartesian(rotVectorBL);

  float[] totalVectorTR = addVectors(rotCarteTR, transCarte); //TODO: fix the combonation
  float[] totalVectorTL = addVectors(rotCarteTL, transCarte);
  float[] totalVectorBR = addVectors(rotCarteBR, transCarte);
  float[] totalVectorBL = addVectors(rotCarteBL, transCarte);

  stroke(150);
  rect(200, 200, 100, 100);

  float[] pointsTR = toOrigin(totalVectorTR, topRight.getOrigin());
  stroke(#7aeb34);
  line(topRight.getOrigin(0), topRight.getOrigin(1), pointsTR[0], pointsTR[1]);

  float[] pointsTL = toOrigin(totalVectorTL, topLeft.getOrigin());
  line(topLeft.getOrigin(0), topLeft.getOrigin(1), pointsTL[0], pointsTL[1]);

  float[] pointsBR = toOrigin(totalVectorBR, BottomRight.getOrigin());
  line(BottomRight.getOrigin(0), BottomRight.getOrigin(1), pointsBR[0], pointsBR[1]);

  float[] pointsBL = toOrigin(totalVectorBL, BottomLeft.getOrigin());
  line(BottomLeft.getOrigin(0), BottomLeft.getOrigin(1), pointsBL[0], pointsBL[1]);
}

float[] polarToCartesian(float[] vector, float[] origin){
  float nx = (float)vector[0] * (float)Math.cos(vector[1]);
  float ny = (float)vector[0] * (float)Math.sin(vector[1]);

  float[] output = {nx + origin[0], ny + origin[1]};

  return output;
}

float[] polarToCartesian(float[] vector){
  float nx = (float)vector[0] * (float)Math.cos(vector[1]);
  float ny = (float)vector[0] * (float)Math.sin(vector[1]);

  float[] output = {nx, ny};

  return output;
}

void getUserInput(){
  leftX = map(controller.getSlider("leftStickX").getValue(), -1, 1, -100, 100);
  leftY = map(controller.getSlider("leftStickY").getValue(), -1, 1, -100, 100);

  float raw_rightX = map(controller.getSlider("rightStickX").getValue(), -1, 1, -100, 100);
  if (raw_rightX >= 10.0 || raw_rightX <= -10.0){
    rightX = raw_rightX;
  }else {
    rightX = 0.0;
  }
  println(rightX);
  rightY = map(controller.getSlider("rightStickY").getValue(), -1, 1, -100, 100);

  // leftY = 0.0001;
  // leftX = 0;
  // rightX = -100;
}

float[] addVectors(float[] vector1, float[] vector2){
  println("Vector 1: " + vector1[0] + ' ' + Math.toDegrees(vector1[1]));
  println("Vector 2: " + vector2[0] + ' ' + Math.toDegrees(vector2[1]));
  float nx = vector1[0] + vector2[0];
  float ny = vector1[1] + vector2[1];
  float[] output = {nx, ny};
  println("Output: " + output[0] + ' ' + Math.toDegrees(output[1]));
  return output;
}

float[] toOrigin(float[] inputPoints, float[] origin){
  float nx = inputPoints[0] + origin[0];
  float ny = inputPoints[1] + origin[1];
  float[] np = {nx, ny};
  return np;
}