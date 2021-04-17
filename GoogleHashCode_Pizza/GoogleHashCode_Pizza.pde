String fileName = "./res/a_example.in";
Pizza pizza;

final boolean PREVIEW = true;

float xdim, ydim;

void setup() {
    size(500, 500);
    surface.setResizable(true);

    /*
        FILE FORMAT:

        #ROWS #COLUMNS #MIN_INGREDIENT #MAX_SIZE
        TTTMTMMTMT      // row 1 with #COLUMNS ingredients, T = Tomato, M = Mushroom
        TTMTMMMTMT      // row 2 with #COLUMNS ingredients...
        ...
        // total of #ROWS rows
    */

    runAlgorithm(fileName);
}

void draw() {
    if (PREVIEW) {
        pizza.render();        
    }

    noLoop();
}