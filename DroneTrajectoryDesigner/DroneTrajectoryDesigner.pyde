import BezierCurve as bc
import CatmullRomCurve as crc
import CurvaturePlot as cp
import EvenSpacedPointsCurve as espc

CATMULL_ROM = False
FROM_WAYPOINTS = True
SHOW_SPLINE_POINTS = True
SHOW_CURVATURE_PLOT = True
SHOW_EVEN_SPACED_POINTS = True

waypoints = []
control_points = []
sampling_points = []
if CATMULL_ROM:
    cur = crc.CatmullRomFromWaypoints(waypoints, steps=50, alpha=0.5)
else:
    cur = bc.BezierCurve(control_points, steps=100) if not FROM_WAYPOINTS \
        else bc.BezierFromWaypoints(waypoints, roundness=1, steps=30)
plot = cp.CurvaturePlot()
esp_cur = espc.EvenSpacedPointsCurve(steps=100)

def drawLines(pts, size):
    for i in range(len(pts)-1):
        p1 = pts[i]
        p2 = pts[i+1]
        if SHOW_SPLINE_POINTS:
            ellipse(p1.x, p1.y, size, size)
        line(p1.x, p1.y, p2.x, p2.y)
    if SHOW_SPLINE_POINTS:
        ellipse(pts[-1].x, pts[-1].y, size, size)

def setup():
    size(600, 600)

def draw():
    background(0)
    if SHOW_CURVATURE_PLOT:
        plot.DrawPlot(10, 590, 590, 50, color(255))
    if CATMULL_ROM:
        if waypoints:
            fill(0,0,255)
            noStroke()
            for wp in waypoints:
                ellipse(wp.x, wp.y, 7, 7)
            cvs = cur.GetCurve()
            if cvs:
                fill(0,255,0)
                stroke(0,255,0)
                drawLines(cvs, 3)
    else:
        if not FROM_WAYPOINTS:
            if control_points:
                fill(255,0,0)
                noStroke()
                for cp in control_points:
                    ellipse(cp.x, cp.y, 3, 3)
            pts = cur.GetCurve()
            if pts:
                fill(0,0,255)
                stroke(0,0,255)
                drawLines(pts, 3)
        else:
            if waypoints:
                fill(0,0,255)
                noStroke()
                for wp in waypoints:
                    ellipse(wp.x, wp.y, 7, 7)
            pts = cur.knots
            if pts:
                fill(255,0,0)
                noStroke()
                for cp in pts:
                    ellipse(cp.x, cp.y, 5, 5)
            cvs = cur.GetCurve()
            if cvs:
                fill(0,255,0)
                stroke(0,255,0)
                drawLines(cvs, 3)
    if SHOW_EVEN_SPACED_POINTS:
        pts = esp_cur.GetCurve()
        pushStyle()
        stroke(255)
        strokeWeight(5)
        for p in pts:
            point(p.x, p.y)
        popStyle()


def mouseReleased():
    pt = PVector(mouseX, mouseY)
    if not CATMULL_ROM and not FROM_WAYPOINTS:
        if control_points and pt.equals(control_points[-1]):
            return
        control_points.append(pt)
        if len(control_points) > 3:
            cur.m_knots = control_points
            cur.Generate()
    else:
        if waypoints and pt.equals(waypoints[-1]):
            return
        waypoints.append(pt)
        if len(waypoints) > (2 if CATMULL_ROM else 3):
            cur.waypoints = waypoints
            if not CATMULL_ROM:
                cur.GenerateKnots()
            cur.GenerateCurves()
    if SHOW_EVEN_SPACED_POINTS:
        esp_cur.Generate(cur.GetCurve())
    if SHOW_CURVATURE_PLOT:
        plot.Generate(cur.GetCurve())
    

def mouseWheel(event):
    c = event.getCount()
    if CATMULL_ROM:
        if c > 0:
            cur.alpha -= 0.05
            if cur.alpha < -1.0:
                cur.alpha = -1.0
        else:
            cur.alpha += 0.05
            if cur.alpha > 2.0:
                cur.alpha = 2.0
        print("ALPHA: {}".format(cur.alpha))
        if len(waypoints) > 2:
            cur.GenerateCurves()
            if SHOW_EVEN_SPACED_POINTS:
                esp_cur.Generate(cur.GetCurve())
            if SHOW_CURVATURE_PLOT:
                plot.Generate(cur.GetCurve())
            
    elif FROM_WAYPOINTS:
        if c > 0:
            cur.roundness -= 0.05
            if cur.roundness < 0.0:
                cur.roundness = 0.0
        else:
            cur.roundness += 0.05
            if cur.roundness > 3.0:
                cur.roundness = 3.0
        print("ROUNDNESS: {}".format(cur.roundness))
        if len(waypoints) > 3:
            cur.GenerateKnots()
            cur.GenerateCurves()
            plot.Generate(cur.GetCurve())
            if SHOW_EVEN_SPACED_POINTS:
                esp_cur.Generate(cur.GetCurve())
            if SHOW_CURVATURE_PLOT:
                plot.Generate(cur.GetCurve())
    else:
        pass
        
