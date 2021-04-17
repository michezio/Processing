// TOMATO = false, MUSHROOM = true

class Vec2 {
    int x, y;
    
    Vec2(int x, int y) {
        this.x = x;
        this.y = y;
    }
}

class Cell {
    boolean hasMushroom;
    boolean isTaken;
    
    Cell() {
        this.hasMushroom = false;
        this.isTaken = false;
    }
}

class Pizza {
    int columns;
    int rows;
    int min_amount;
    int max_size;
    Cell[][] cells;
    ArrayList<Vec2> pivots;
    int index;

    Pizza(int columns, int rows, int min_amount, int max_size) {
        this.columns = columns;
        this.rows = rows;
        this.min_amount = min_amount;
        this.max_size = max_size;
        cells = new Cell[rows][columns];        
        // set all cells to TOMATO (false), the file parser will set MUSHROOM cells (true)
        for (int r=0; r<rows; r++) {
            for (int c=0; c<columns; c++) {
                cells[r][c] = new Cell();
            }
        }
        pivots = new ArrayList<Vec2>();
        index = 0;
    } 

    void putMushroom(int r, int c) {
        // remember true = MUSHROOM, false = TOMATO
        cells[r][c].hasMushroom = true;
    }

    boolean getCell(int r, int c) {
        return cells[r][c].hasMushroom;
    }

    void populatePivots(boolean type) {
        for (int r=0; r<rows; r++) {
            for (int c=0; c<columns; c++) {
                if (cells[r][c].hasMushroom == type)
                    pivots.add(new Vec2(r, c));
            }
        }
    }

    Vec2 nextPivot() {
        int indexBackup = index;
        Vec2 p;
        do {
            p = pivots.get(index);
            index++;
        }
        while (p.isTaken == true && index != indexBackup);
        if (index != indexBackup) return p;
        else {
            return null;
        }
    }

    Vec2 randomPivot() {
        index = floor(random(pivots.size())-0.001);
        return nextPivot();
    }

    void render() {
        pushStyle();
        noStroke();
        float xdim = (float)width / (pizza.columns + 2.0);
        float ydim = (float)height / (pizza.rows + 2.0); 
        for (int y=0; y<rows; y++) {
            for (int x=0; x<columns; x++) {
                float px = xdim/2 + (x+1)*xdim;
                float py = ydim/2 + (y+1)*ydim;
                float s = min(xdim, ydim) * 0.707;
                if (getCell(y, x) == true) fill(0,255,0);
                else fill(255,0,0);
                ellipse(px, py, s, s);
            }
        }
        popStyle();
    }
} 