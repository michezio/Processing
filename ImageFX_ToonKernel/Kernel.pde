static class Kernel {
  float[] ker;
  PVector scale;
  PVector bias;
  
  Kernel(Kernel k) {
    ker = k.ker;
    scale = k.scale;
    bias = k.bias;
  }
   
  Kernel(float[] ker, float factor, PVector scale, PVector bias) {
    this.ker = ker;
    this.scale = scale;
    this.bias = bias;
    if (factor == 0) normalize();
    else if (factor != 1) mult(factor);
  }
  
  Kernel(float[] ker, float factor, float scaleX, float scaleY, float biasX, float biasY) {
    this(ker, factor, new PVector(scaleX, scaleY), new PVector(biasX, biasY));
  }

  Kernel(float[] ker, float factor) {
    this(ker, factor, new PVector(1, 1), new PVector(0, 0));  
  }
  
  Kernel(float[] ker) {
    this(ker, 1);
  }
 
  static float[] add(float[] k1, float[] k2) {
    if (k1.length != k2.length) {
      println("ERROR: kernel size mismatch during sum");
      return null;
    }
    float[] res = new float[k1.length];
    for (int i=0; i<res.length; ++i) {
      res[i] = k1[i] + k2[i];
    }
    return res;    
  }
  
  void add(float[] k2) {
    ker = add(ker, k2);
  }
  
  static float[] sub(float[] k1, float[] k2) {
    if (k1.length != k2.length) {
      println("ERROR: kernel size mismatch during subtraction");
      return null;
    }
    float[] res = new float[k1.length];
    for (int i=0; i<res.length; ++i) {
      res[i] = k1[i] - k2[i];
    }
    return res;    
  }
  
  void sub(float[] k2) {
    ker = sub(ker, k2);
  }
  
  static float[] mult(float[] k1, float[] k2) {
    // IMPLEMENT MULTIPLICATION BETWEEN KERNELS
    println("ATTENTION: mult() has not been implemented yet!");
    return null;
  }
  
  static float[] mult(float[] k1, float factor) {
    float[] res = new float[k1.length];
    for (int i=0; i<res.length; ++i) {
      res[i] = k1[i] * factor;
    }
    return res; 
  }
  
  void mult(float factor) {
    ker = mult(ker, factor);
  }
  
  static float[] normalize(float[] kern) {
    float sum = 0;
    for (float e : kern) {
      sum += e;
    }
    for (int i=0; i<kern.length; ++i) {
      kern[i] /= sum;
    }
    return kern;
  }
  
  void normalize() {
    ker = normalize(ker);
  }
  
  void setScale(float scaleX, float scaleY) {
    scale.set(scaleX, scaleY);
  }
  
  void setBias(float biasX, float biasY) {
    bias.set(biasX, biasY);
  }
}

static class StdK { 
  static Kernel ones     = new Kernel(new float[] { 1, 1, 1, 1, 1, 1, 1, 1, 1 });
  static Kernel original = new Kernel(new float[] { 0, 0, 0, 0, 1, 0, 0, 0, 0 });
  static Kernel inverted = new Kernel(new float[] { 0, 0, 0, 0, -1, 0, 0, 0, 0 });
  static Kernel average  = new Kernel(new float[] { .111, .111, .111, .111, .112, .111, .111, .111, .111 });
  static Kernel sharpen  = new Kernel(new float[] { 0, -1, 0, -1, 5, -1, 0, -1, 0 });
  static Kernel edges    = new Kernel(new float[] { 0, -1, 0, -1, 4, -1, 0, -1, 0 });
  static Kernel blur     = new Kernel(new float[] { .0625, .125, .0625, .125, .25, .125, .0625, .125, .0625 });
  static Kernel b_sobel  = new Kernel(new float[] { -1, -2, -1, 0, 0, 0, 1, 2, 1 });
  static Kernel t_sobel  = new Kernel(new float[] { 1, 2, 1, 0, 0, 0, -1, -2, -1 });
  static Kernel l_sobel  = new Kernel(new float[] { 1, 0, -1, 2, 0, -2, 1, 0, -1 });
  static Kernel r_sobel  = new Kernel(new float[] { -1, 0, 1, -2, 0, 2, -1, 0, 1 });
  static Kernel emboss   = new Kernel(new float[] { -2, -1, 0, -1, 1, 1, 0, 1, 2 });
  static Kernel outline  = new Kernel(new float[] { -1, -1, -1, -1, 8, -1, -1, -1, -1 });
}
