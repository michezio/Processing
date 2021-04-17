class ShiftRGB {

	PShader shift;

	ShiftRGB(float r, float g, float b) {
		shift = loadShader("FRAG_shiftRGB.glsl");
		setRGB(r, g, b);
	}

  ShiftRGB(float s) {
    shift = loadShader("FRAG_shiftRGB.glsl");
    randomize(s);
  }

  void setUniforms(String uni1, String uni2, float xMag, float yMag, float xOff, float yOff) {
    xMag = 1 - (xMag * 0.01);
    yMag = 1 - (yMag * 0.01);
    xOff = xOff * 0.01;
    yOff = yOff * 0.01;
    shift.set(uni1, xMag, yMag);
    shift.set(uni2, xOff, yOff);
  }

	void setRed(float xMag, float yMag, float xOff, float yOff) {
		setUniforms("rMag", "rOff", xMag, yMag, xOff, yOff);
	}

	void setRed(float mag, float xOff, float yOff) {
		setRed(mag, mag, xOff, yOff);
	}

	void setRed(float mag, float off) {
		setRed(mag, off, off);
	}

	void setRed(float mag) {
		float off = mag * 0.5;
		setRed(mag, off);
	}

	void setGreen(float xMag, float yMag, float xOff, float yOff) {
		setUniforms("gMag", "gOff", xMag, yMag, xOff, yOff);
  }

	void setGreen(float mag, float xOff, float yOff) {
		setGreen(mag, mag, xOff, yOff);
	}

	void setGreen(float mag, float off) {
		setGreen(mag, off, off);
	}

	void setGreen(float mag) {
		float off = mag * 0.5;
		setGreen(mag, off);
	}

	void setBlue(float xMag, float yMag, float xOff, float yOff) {
		setUniforms("bMag", "bOff", xMag, yMag, xOff, yOff);
	}

	void setBlue(float mag, float xOff, float yOff) {
		setBlue(mag, mag, xOff, yOff);
	}

	void setBlue(float mag, float off) {
		setBlue(mag, off, off);
	}

	void setBlue(float mag) {
		float off = mag * 0.5;
		setBlue(mag, off);
	}

	void setRGB(float r, float g, float b) {
    	setRed(r);
    	setGreen(g);
    	setBlue(b);
	}

  void reset() {
    setRGB(0, 0, 0);
  }
  
  void randomize(float maxMag) {
    setRGB(rnd(maxMag), rnd(maxMag), rnd(maxMag));
  }
  
  float rnd(float a) {
    return random(2*a)-a;
  }

	void render() {
		filter(shift);
	}
}
