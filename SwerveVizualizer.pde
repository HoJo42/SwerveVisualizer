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

  float[] rotVectorTR = topRight.calculateRotationVector(rightX);
  float[] rotVectorTL = topLeft.calculateRotationVector(rightX);
  float[] rotVectorBR = BottomRight.calculateRotationVector(rightX);
  float[] rotVectorBL = BottomLeft.calculateRotationVector(rightX);



  stroke(150);
  rect(200, 200, 100, 100);

  float[] pointsTR = polarToCartesian(rotVectorTR, topRight.getOrigin());
  stroke(#7aeb34);
  line(topRight.getOrigin(0), topRight.getOrigin(1), pointsTR[0], pointsTR[1]);

  float[] pointsTL = polarToCartesian(rotVectorTL, topLeft.getOrigin());
  line(topLeft.getOrigin(0), topLeft.getOrigin(1), pointsTL[0], pointsTL[1]);

  float[] pointsBR = polarToCartesian(rotVectorBR, BottomRight.getOrigin());
  line(BottomRight.getOrigin(0), BottomRight.getOrigin(1), pointsBR[0], pointsBR[1]);

  float[] pointsBL = polarToCartesian(rotVectorBL, BottomLeft.getOrigin());
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
  // println(rightX);
  rightY = map(controller.getSlider("rightStickY").getValue(), -1, 1, -100, 100);
}
