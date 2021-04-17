/*

    VIEWCAM

    Implements a movable Blender-like camera for the ViewPort
    
    [TODO] Fix translate to affect camera position and center keeping rotation consistent
    [TODO] Make transformations independent from Processing camera() function and make each matrix explicit
    [TODO] Create a raycasting mouse->world mapping

*/


ViewCam createCam() {
    return new ViewCam();
}

class ViewCam {
    PVector position;
    PVector center;
    PVector axis;
    float rotationDelta;
    float zoomScale, zoomDelta;
    boolean perspective;

    ViewCam() {
        position = new PVector(0, 0, 500);
        center = new PVector(0, 0, 0);
        axis = new PVector(0, -1, 0);
        rotationDelta = 0.01;
        zoomScale = 1;
        zoomDelta = -0.2;
        perspective = true;
    }

    ViewCam setPosition(float x, float y, float z) { position.set(x, y, z); return this; }
    ViewCam setCenter(float x, float y, float z) { center.set(x, y, z); return this; }
    ViewCam setAxis(float x, float y, float z) { axis.set(x, y, z); return this; }
    ViewCam setRotationDelta(float amount) { rotationDelta = amount; return this; }
    ViewCam setZoomDelta(float amount) { zoomDelta = amount; return this; }


    PVector getRollAxis() {
        return PVector.sub(center, position);
    }

    PVector getPitchAxis() {
        return axis.cross(getRollAxis());
    }

    void rotate(float x, float y) {
        // rotates along a fixed y axis keeping x and z free
        Quaternion rotation = new Quaternion(y * rotationDelta, this.getPitchAxis());
        rotation = rotation.mult(new Quaternion(x * rotationDelta, new PVector(0,-1,0)));
        rotation.applyRotationTo(position);
        rotation.applyRotationTo(axis);
    }

    void rotateFree(float x, float y) {
        // rotate freely along all 3 axis
        Quaternion rotation = new Quaternion(y * rotationDelta, this.getPitchAxis());
        rotation = rotation.mult(new Quaternion(x * rotationDelta, axis));
        rotation.applyRotationTo(position);
        rotation.applyRotationTo(axis);
    }

    // void roll(float angle) {
    //     // usable only if rotateFree() is used, breaks rotate()
    //     Quaternion rotation = new Quaternion(angle, this.getRollAxis());
    //     rotation.applyRotationTo(axis);
    // }

    void zoom(float amount) {
        zoomScale *= 1 + amount * zoomDelta;
        if (zoomScale > 8.0) zoomScale = 8.0;
        else if (zoomScale < 0.1) zoomScale = 0.1;
    }

    void zoomPosition(float amount) {
        PVector direction = this.getRollAxis();
        direction.mult(zoomDelta * amount);
        position.add(direction);
    }

    // FIX ME!
    void translate(float x, float y) {
        // translation affects only center of the camera and this modifies axis of
        // rotation yelding undesired results when rotating while translated
        center.add(PVector.mult(this.getPitchAxis().normalize(), -x));
        center.add(PVector.mult(this.axis.normalize(), -y));
    }

    float getDistance() {
        return dist(center.x, center.y, center.z, position.x, position.y, position.z);
    }

    boolean togglePerspective() {
        // can't use until zoom is fixed
        perspective = !perspective;
        return perspective;
    }

    void trasform() {
        if (perspective) perspective();
        else ortho();
        camera( position.x, position.y, position.z,
                center.x, center.y, center.z,
                axis.x, axis.y, axis.z );
        scale(zoomScale);
    }

    void setOrientation(float x, float y, float z) {
        float d = this.getDistance();
        this.setPosition(x * d, y * d, z * d);
        if (x == 0 && z == 0) this.setAxis(0, 0, -1);
        else this.setAxis(0, -1, 0);
    }

    void invertOrientation() {
        position.mult(-1);
    }
}