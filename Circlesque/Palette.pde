Palette generatePalette(String name) {
  Palette pal = new Palette();  
  name = name.toUpperCase();
  switch (name) {
    case "SPOTIFY": {
      pal.setBackground(#121212);
      pal.setAccent(color(#b3b3b3,20));
      pal.add(#1db954)
         .add(#212121)
         .add(#121212)
         .add(#535353)
         .add(#b3b3b3);
    } break;
    case "JEANS": {
      pal.setBackground(#efefef);
      pal.setAccent(color(#5d5c61,20));
      pal.add(#5d5c61)
         .add(#938e94)
         .add(#7395ae)
         .add(#557a95)
         .add(#b1a296);
    } break;
    case "MINT": {
      pal.setBackground(#5cdb95);
      pal.setAccent(color(#edf5e1,20));
      pal.add(#05386b)
         .add(#379683)
         .add(#8ee4af)
         .add(#edf5e1);
    } break;
    case "HIGHLIGHTED": {
      pal.setBackground(#3feee6);
      pal.setAccent(color(#000000,20));
      pal.add(#fc4445)
         .add(#55bcc9)
         .add(#97caef)
         .add(#cafafe);
    } break;
    case "NEON-VOID": {
      pal.setBackground(#0e0b16);
      pal.setAccent(color(#e7dfdd,20));
      pal.add(#0e0b16)
         .add(#a239ca)
         .add(#4717f6)
         .add(#e7dfdd);
    } break;
    case "MUTED-GOLD": {
      pal.setBackground(#f4f4f4);
      pal.setAccent(color(#373737,20));
      pal.add(#373737)
         .add(#f4f4f4)
         .add(#dcd0c0)
         .add(#c0b283);
    } break;
    case "ORANGE-TEAL": {
      pal.setBackground(#f4f4f4);
      pal.setAccent(color(#373737,20));
      pal.add(#e37222)
         .add(#07889b)
         .add(#66b9bf)
         .add(#eeaa7b);
    } break;
    case "WHITE": {
      pal.setBackground(color(255));
      pal.setAccent(color(200,20));
      pal.add(255,255,255)
         .add(240,240,240)
         .add(220,220,220)
         .add(200,200,200)
         .add(180,180,180);
    } break;
    case "BLACK": {
      pal.setBackground(color(0));
      pal.setAccent(color(55,20));
      pal.add(0,0,0)
         .add(15,15,15)
         .add(35,35,35)
         .add(55,55,55)
         .add(75,75,75);
    } break;
    case "CANDY-HAZE": {
      pal.setBackground(color(0));
      pal.setAccent(color(255,30));
      pal.add(255,0,0)
         .add(200,0,64)
         .add(255,0,128)
         .add(255,200,20)
         .add(128,128,255);
    } break;
    case "URBAN-ORANGE": {
      pal.setBackground(color(0));
      pal.setAccent(color(255,30));
      pal.add(255,255,255)
         .add(255,70,0)
         .add(130,130,130)
         .add(200,200,200)
         .add(50,50,50);
    } break;
    case "URBAN-ORANGE-ALT": {
      pal.setBackground(color(0));
      pal.setAccent(color(128,30));
      pal.add(200,200,200)
         .add(255,50,0)
         .add(100,100,100)
         .add(150,150,150)
         .add(50,50,50);
    } break;
    case "CANDY-HAZE-ALT": {
      pal.setBackground(color(0));
      pal.setAccent(color(255,30));
      pal.add(255,0,0)
         .add(128,0,64)
         .add(255,0,128)
         .add(255,170,0)
         .add(100,128,255);
    } break;
    case "VINTAGE-PASTEL": {
      pal.setBackground(color(255));
      pal.setAccent(color(150,20));
      pal.add(192,189,165)
         .add(204,151,142)
         .add(243,156,107)
         .add(255,56,100)
         .add(38,20,71);
    } break;
    case "LIMEY": {
      pal.setBackground(color(0,16,17));
      pal.setAccent(color(255,255,252,30));
      pal.add(108,207,246)
         .add(200,255,190)
         .add(117,119,128)
         .add(0,126,167)
         .add(152,206,0);
    } break;
    case "MANZANAS": {
      pal.setBackground(color(0));
      pal.setAccent(color(134,203,146,30));
      pal.add(66,3,61)
         .add(53,88,52)
         .add(81,152,114)
         .add(202,207,133)
         .add(255);
    } break;
    case "RGB":
    default: {
      pal.setBackground(color(0));
      pal.setAccent(color(255,30));
      pal.add(255,0,0)
         .add(0,255,0)
         .add(0,0,255);
    }
  }
  return pal;
}

class Palette {
  ArrayList<Integer> colors;
  color bkg;
  color acc;

  Palette() {
    colors = new ArrayList<Integer>();
  }

  Palette add(color c) {
    colors.add(c);
    return this;
  }

  Palette add(float r, float g, float b, float a) {
    return add(color(r, g, b, a));
  }
  
  Palette add(float r, float g, float b) {
    return add(color(r, g, b, 255));
  }
  
  color getColor(int n) {
    return colors.get(n);
  }
  
  color getColor() {
    return getColor(floor(random(colors.size())));
  }  
  
  void setBackground(color c) {
    this.bkg = c;
  }
  
  color getBackground() {
    return bkg;
  }
  
  void setAccent(color c) {
    this.acc = c;
  }
  
  color getAccent() {
    return acc;
  }
}
