class Slice {
    Vec2 start, end;

    Slice(Vec2 start, Vec2 end) {
        this.start = start;
        this.end = end;
    }

    Vec2 count() {
        Vec2 c = new Vec2(0, 0);
        for (int i=start.y, i<end.y; i++) {
            for (int j=start.x, j<end.x; j++) {
                if (pizza.getCell(i, j) == true) c.y++;
                else c.x++;
            }
        }
        return c;
    }
}

ArrayList<Slice> slices;

void runAlgorithm(String fileName) {   

    String[] lines = loadStrings(fileName);

    String[] line0 = lines[0].split(" ");

    int rows = Integer.parseInt(line0[0]);
    int cols = Integer.parseInt(line0[1]);
    int min_ingr = Integer.parseInt(line0[2]);
    int max_size = Integer.parseInt(line0[3]);

    pizza = new Pizza(cols, rows, min_ingr, max_size);
    int mushs = 0;
    for (int r=0; r<rows; r++) {
        String line = lines[r+1];
        for (int c=0; c<cols; c++) {
            if (line.charAt(c) == 'M') {
                pizza.putMushroom(r, c);
                mushs++;
            }
        }
    }
    
    // use the most rare ingredient as pivot to create every slice, false = tomato, true = mushroom
    boolean pivotType = (mushs < rows*columns*0.5);
    pizza.populatePivot(pivotType);

    slices = new ArrayList<Slice>();

    Vec2 pivot = pizza.randomPivot();
    Slice s = new Slice(pivot, pivot);
    s.grow();

    // TO COMPLETE...
}