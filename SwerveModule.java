class SwerveModule {
    private float[] origin;

    private float rotationAngle;

    SwerveModule(float[] origin, float rotationAngle){
        this.origin = origin;
        this.rotationAngle = rotationAngle;
    }

    public float[] calculateRotationVector(float controllerInput){
        float[] output = {controllerInput, rotationAngle};
        return output;
    }

    public float[] getOrigin(){
        return origin;
    }
    public float getOrigin(int index){
        return origin[index];
    }

    public float getRotationAngle(){
        return rotationAngle;
    }

}
