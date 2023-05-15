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
    float rotationAngleTLBR = (float)Math.toRadians(225);
    float rotationAngleTRBL = (float)Math.toRadians(225+90);

    float[] originTR = {200, 200};
    float[] originTL = {300, 200};
    float[] originBR = {200, 300};
    float[] originBL = {300, 300};

  control = ControlIO.getInstance(this);
  controller = control.getMatchedDevice("xboxSwerve");

  topRight = new SwerveModule(originTR, rotationAngleTRBL);
  topLeft = new SwerveModule(originTL, rotationAngleTLBR);
  BottomRight = new SwerveModule(originBR, rotationAngleTLBR);
  BottomLeft = new SwerveModule(originBL, rotationAngleTRBL);


  if (controller == null){
    println("Controller gone");
    System.exit(-1);
  }
}

void draw(){
  getUserInput();
  background(255);

  float theta = (float)Math.atan(leftY/leftX);
  float r = (float)leftY/(float)Math.sin(theta);

  float[] transVector = {r, theta};

  float[] rotVector = topRight.calculateRotationVector(rightX);



  stroke(150);
  rect(200, 200, 100, 100);

  float[] pointsTR = polarToCartesian(rotVector, topRight.getOrigin());
  stroke(#7aeb34);
  line(topRight.getOrigin(0), topRight.getOrigin(1), pointsTR[0], pointsTR[1]);

  float[] pointsTL = polarToCartesian(transVector, topLeft.getOrigin());
  line(topLeft.getOrigin(0), topLeft.getOrigin(1), pointsTL[0], pointsTL[1]);

  float[] pointsBR = polarToCartesian(transVector, BottomRight.getOrigin());
  line(BottomRight.getOrigin(0), BottomRight.getOrigin(1), pointsBR[0], pointsBR[1]);

  float[] pointsBL = polarToCartesian(transVector, BottomLeft.getOrigin());
  line(BottomLeft.getOrigin(0), BottomLeft.getOrigin(1), pointsBL[0], pointsBL[1]);
}

float[] polarToCartesian(float[] vector, float[] origin){
  float nx = (float)vector[0] * (float)Math.cos(vector[1]);
  float ny = (float)vector[0] * (float)Math.sin(vector[1]);

  float[] output = {nx + origin[0], ny + origin[1]};

  return output;
}

void getUserInput(){
  leftX = map(controller.getSlider("leftStickX").getValue(), -1, 1, -100, 100);
  leftY = map(controller.getSlider("leftStickY").getValue(), -1, 1, -100, 100);
  rightX = map(controller.getSlider("rightStickX").getValue(), -1, 1, -100, 100);
  println(rightX);
  rightY = map(controller.getSlider("rightStickY").getValue(), -1, 1, -100, 100);
}
