final int DEBOUNCE_THRESHOLD = 60;

InputManager input;

void setup() {
  size(400,400);
  
  frameRate(144);
  
  input = new InputManager();
}

void draw() {
  
  input.action();
  
  background(0);
  
  stroke(255);
  if (input.ctrl) fill(255,0,0);
  else fill(0);
  rect(0,0,width/2,height/2);
  
  if (input.z) fill(0,255,0);
  else fill(0);
  rect(width/2,height/2,width/2,height/2);
  
  if (input.ctrl && input.z)  fill(0,0,255);
  else fill(0);
  rect(0,height/2,width/2,height/2);
  
  if (input.ctrl || input.z) fill(255);
  else fill(0);
  rect(width/2,0,width/2,height/2);
}





void keyPressed() {
  input.setKeyCoded(keyCode, true);
  
  print(keyCode);
}

void keyReleased() {
  input.setKeyCoded(keyCode, false);
}





class InputManager {

    boolean z, ctrl, alt, shift;
    KeyDebouncer shiftDebouncer, ctrlDebouncer, altDebouncer;

    InputManager() {
        z = false;
        ctrl = alt = shift = false;
        shiftDebouncer = new KeyDebouncer();
        ctrlDebouncer = new KeyDebouncer();
        altDebouncer = new KeyDebouncer();
    }
    
    void action() {
      ctrl = ctrlDebouncer.update();
    }

    void setKeyCoded(int code, boolean status) {
        switch (code) {
            case SHIFT: shiftDebouncer.trigger(status); break;
            case CONTROL: ctrlDebouncer.trigger(status); break;
            case ALT: altDebouncer.trigger(status); break;
            case 90: z = status; break;
            default: return;
        }
    }

    boolean setKey(int key, boolean status) {
        switch (key) {
            case 'z': z = status; break;
            default: return false;
        }
        return true;
    }
}


class KeyDebouncer {

    int timer, state;
    boolean debouncedStatus;

    KeyDebouncer() {
        timer = 0;
        state = 0;
        debouncedStatus = false;
    }

    void trigger(boolean status) {
        switch (state) {
            case 0:
                if (status == true) {
                    debouncedStatus = true;
                    state = 1;
                }
                else debouncedStatus = false;
                break;
            case 1:
                if (status == false) {
                    debouncedStatus = true;
                    state = 2;
                }
                break;
            case 2:
                if (status == true && timer < DEBOUNCE_THRESHOLD) {
                    debouncedStatus = true;
                    state = 2;
                }
                timer = 0;
                break;
        }
    }

    boolean update() {
        switch (state) {
            case 0: break;
            case 1: timer++; break;
            case 2: 
                timer++;
                if (timer > DEBOUNCE_THRESHOLD) {
                    debouncedStatus = false;
                    timer = 0;
                    state = 0;
                }
                break;
        }
        return debouncedStatus;
    }

}
