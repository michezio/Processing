// TOON SHADER ///////////////////////////////////////////

class ToonShader {
  PShader toon;
  
  ToonShader(float levels, float noise, float seed) {
    toon = loadShader("toon.glsl");
    toon.set("levels", (int)levels);
    toon.set("noise", noise);
    toon.set("seed", seed);
  }
  
  ToonShader(float levels, float noise) {
    this(levels, noise, 1.0);
  }
  
  ToonShader(float levels) {
    this(levels, 0);
  }
  
  void render() {
    filter(toon);
  }
}

// BOKEH SHADER ///////////////////////////////////////////

class KernelShader {
  PShader s;
  float[] kernel, rKernel, gKernel, bKernel;
  
  KernelShader(Kernel kernel) {
    s = loadShader("kernelfullmono.glsl");
    s.set("kernel", kernel.ker);
    s.set("bias", kernel.bias.x, kernel.bias.y);
    s.set("scale", kernel.scale.x, kernel.scale.y);
  }
  
  KernelShader(float[] r, float[] g, float[] b, boolean norm) {
    s = loadShader("kernelrgb.glsl");
    setKernel("RED", r, norm);
    setKernel("GREEN", g, norm);
    setKernel("BLUE", b, norm);
  }
  
  KernelShader(float[] r, float[] g, float[] b) {
    this(r, g, b, true);
  }
  
  KernelShader(float[] k, boolean norm) {
    s = loadShader("kernelmono.glsl");
    setKernel("MONO", k, norm);
  }
  
  KernelShader(float[] k) {
    this(k, true);
  }
  
  void render() {
    filter(s);
  }
  
  private void setKernel(String col, float[] ker, boolean norm) {
    switch (col.toUpperCase()) {
      case "RED":
        if (norm) rKernel = Kernel.normalize(ker);
        else rKernel = ker;
        s.set("rKernel", rKernel);
      break;
      case "GREEN":
        if (norm) gKernel = Kernel.normalize(ker);
        else gKernel = ker;
        s.set("gKernel", gKernel);
      break;
      case "BLUE":
        if (norm) bKernel = Kernel.normalize(ker);
        else bKernel = ker;
        s.set("bKernel", bKernel);
      break;
      case "MONO":
        if (norm) kernel = Kernel.normalize(ker);
        else kernel = ker;
        s.set("kernel", kernel);
      break;
      default:
        println("ERROR: invalid color in setKernel(col, ker)");
    }
  } //<>// //<>//
}
