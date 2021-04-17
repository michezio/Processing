void mouseWheel(MouseEvent event) {
    cam.zoom(event.getCount());
}

void mouseDragged() {
    if (mouseButton == CENTER) {
        cam.rotate(pmouseX - mouseX, pmouseY - mouseY);
    }

    if (mouseButton == RIGHT) {
        //cam.translate(pmouseX - mouseX, pmouseY - mouseY);
    }
}

void keyPressed() {
    if (key == CODED) {
        
    }

    if (keyCode >= 128 && keyCode <= 138) {
        if (key == '1') cam.setOrientation(0,0,1);  // FRONT
        if (key == '2') cam.rotate(0, 30);          // DOWN
        if (key == '3') cam.setOrientation(1,0,0);  // RIGHT
        if (key == '4') cam.rotate(-30, 0);         // LEFT
        if (key == '5') cam.togglePerspective();    // PERSPECTIVE/ORTHO
        if (key == '6') cam.rotate(30, 0);          // RIGHT
        if (key == '7') cam.setOrientation(0,1,0);  // TOP
        if (key == '8') cam.rotate(0, -30);         // UP
        if (key == '9') cam.invertOrientation();    // INVERSE
    }
}