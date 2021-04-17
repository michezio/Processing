from CurveFunctions import *

class CurvaturePlot:
    def __init__(self):
        self.curvatures = []
        
    def Generate(self, points):
        self.curvatures = []
        for p1, p2, p3 in zip(points[0:], points[1:], points[2:]):
            angle = abs(angle_between_segments(p1, p2, p3))
            self.curvatures.append(angle)

    def DrawPlot(self, px, py, w, h, col=color(255)):
        pushStyle()
        pushMatrix()
        translate(px, py)
        num = len(self.curvatures)
        stroke(col)
        noFill()
        beginShape()
        for i, p in enumerate(self.curvatures):
            x = map(i, 0, num-1, 0, w)
            y = map(p, 0, PI, -h, 0)
            vertex(x, y)
        endShape()
        popMatrix()
        popStyle()
