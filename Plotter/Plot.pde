/*
    A plotter object, resizable and updateable

*/

class Plot {
    int resH;
    int resV;
    float[] data;
    color bkgColor, gridColor, lineColor;
    float lineWidth;
    int gridSpaceH, gridSpaceV;
    int lpf;

    Plot() {
        this(100, 100);
    }

    Plot(int hor_resolution, int ver_resolution) {
        this.resH = hor_resolution;
        this.resV = ver_resolution;
        this.data = new float[resH];
        this.bkgColor = color(255);
        this.lineColor = color(0);
        this.lineWidth = 1;
        this.gridColor = color(200);        
        this.gridSpaceH = 10;
        this.gridSpaceV = 10;
        this.lpf = 1;
    }

    Plot(float[] data) {
        this();
        this.setData(data);        
    }

    Plot setLPF(int samples) { this.lpf = samples; return this; }
    Plot setBackgroundColor(color _color) { this.bkgColor = _color; return this; }
    Plot setGridColor(color _color) { this.gridColor = _color; return this; }
    Plot setLineColor(color _color) { this.lineColor = _color; return this; }
    Plot setLineWidth(float width) { this.lineWidth = width; return this; }
    Plot setGridSpaceSamples(int hor_space, int ver_space) {
        this.gridSpaceH = hor_space;
        this.gridSpaceV = ver_space;
        return this;
    }
    Plot setGridSpacePercentage(float hor_space, float ver_space) {
        this.gridSpaceH = round(this.resH * hor_space);
        this.gridSpaceV = round(this.resV * ver_space);
        return this; 
    }

    Plot setData(float[] data) {
        if (this.data.length != data.length) {
            this.data = new float[data.length];
            this.resH = data.length;
        }
        float min = data[0];
        float max = data[0];
        for (int i=0; i<data.length; i++) {
            if (data[i] < min) min = data[i];
            else if (data[i] > max) max = data[i];
        }
        for (int i=0; i<data.length; i++) {
            this.data[i] = (data[i] - min) / (max - min);
        }
        return this;
    }
    

    void render(int x, int y, int w, int h) {
        pushMatrix();
        translate(x, y);
        float scaleX = (float)w / this.resH;
        float scaleY = (float)h / this.resV;
        scale(scaleX, scaleY);

        noStroke();
        fill(bkgColor);
        rect(x, y, resH, resV);

        stroke(gridColor);
        strokeWeight(1/scaleX);
        for (int i=0; i<=resH;) {
            line(i, 0, i, resV);
            i += gridSpaceH;
        }
        strokeWeight(1/scaleY);
        for (int i=0; i<=resV;) {
            line(0, resV - i, resH, resV - i);
            i += gridSpaceV;
        }

        stroke(lineColor);
        strokeWeight(lineWidth/max(scaleX, scaleY));
        noFill();
        beginShape();
        for (int i=0; i<resH; i++) {
            vertex(i, (1 - lowPass(i))*resV);
        }
        endShape();

        popMatrix();
    }

    float lowPass(int index) {
        if (this.lpf <= 1) return data[index];

        int weight = this.lpf;
        int totalw = 0;
        float avg = 0;
        for (int i=0; i<this.lpf; i++) {
            int actind = index - i;
            if (actind < 0) avg += data[0] * weight;
            else avg += data[actind] * weight; 
            totalw += weight;
            weight--;
        }
        avg /= totalw;
        return avg;
    } 
}