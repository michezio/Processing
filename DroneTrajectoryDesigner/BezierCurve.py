from CurveFunctions import *


class BezierCurve:
    def __init__(self, knots, steps=10):
        self.m_curve = []
        self.m_knots = knots
        self.m_steps = steps

    
    def GetCurve(self):
        return [x[0] for x in self.m_curve]


    def Generate(self):
        self.m_curve = []
        absoluteDistance = 0.0
        stps = [x for x in float_range(0.0, 1.0, self.m_steps)]
        stps.append(1.0)
        for t in stps:
            point = self.GetPoint(t)
            relativeDistance = 0.0

            if self.m_curve:
                last_point = self.m_curve[-1][0]
                relativeDistance = vector_dist(last_point, point)
                absoluteDistance += relativeDistance

            self.m_curve.append([point, t, relativeDistance, absoluteDistance])
        return absoluteDistance


    def GetPoint(self, t):
        n = len(self.m_knots)
        r = n - 1
        fac_r = tgamma(r)
        p = PVector(0, 0, 0)

        for i in range(n):
            fact = fac_r / (tgamma(r - i) * tgamma(i))
            pdiff = (1 - t) ** (r - i)
            power = t ** i
            coeff = fact * pdiff * power
            k = self.m_knots[i]
            p.x += coeff * k.x
            p.y += coeff * k.y
            p.z += coeff * k.z

        return p
    


class BezierFromWaypoints:
    def __init__(self, waypoints, steps=10, roundness=1.0, min_curv=50.0):
        self.waypoints = waypoints
        self.steps = steps
        self.roundness = roundness
        self.min_curv = min_curv
        self.knots = []
        self.curves = []

    def GetCurve(self):
        pts = []
        for c in self.curves:
            for x in c.GetCurve():
                pts.append(x)
        return pts

    def GenerateKnots(self):
        '''
        Extracted and adapted from:
        http://agg.sourceforge.net/antigrain.com/research/bezier_interpolation/index.html
        '''

        self.knots = []
        mod_wp = self.waypoints
        
        first = mod_wp[0]
        #second = mod_wp[1]
        #ctrl = PVector.lerp(first, second, 0.5 * self.roundness)
        self.knots.append(first)

        for p0, p1, p2 in zip(mod_wp[0:], mod_wp[1:], mod_wp[2:]):

            c1 = PVector.lerp(p0, p1, 0.5)
            c2 = PVector.lerp(p2, p1, 0.5)

            coeff = 1.0
            d = vector_dist(c1, c2)
            coeff = 1.0 if d > self.min_curv else self.min_curv / d

            len1 = vector_dist(p0, p1)
            len2 = vector_dist(p1, p2)

            k1 = len1 / (len1 + len2)

            m1 = PVector.lerp(c1, c2, k1)

            direction = PVector.sub(p1, m1)
            
            c1 = PVector.lerp(m1, c1, self.roundness * coeff)
            c2 = PVector.lerp(m1, c2, self.roundness * coeff)

            knot1 = PVector.add(c1, direction)
            knot2 = PVector.add(c2, direction)

            '''
            angle = angle_between_segments(p0, p1, p2)
            # TODO: check if huge_diff has any sense :)
            huge_diff = abs(vector_dist(p0, p1) - vector_dist(p1, p2)) > self.min_curv
            
            if abs(angle) < PI/8.0 or huge_diff:
                # BUG: rotation should be aware of direction to avoid loops
                knot1 = rotate2D(knot1, p1, (PI if angle > 0 else -PI) / 2.0)
                knot2 = rotate2D(knot2, p1, (PI if angle > 0 else -PI) / 2.0)
            '''
            
            self.knots.append(knot1)
            self.knots.append(knot2)

        last = mod_wp[-1]
        #s_last = mod_wp[-2]
        #ctrl = PVector.lerp(last, s_last, 0.5 * self.roundness)
        self.knots.append(last)


    def GenerateCurves(self):
        self.curves = []
        for wp1, wp2, cps in zip(self.waypoints[0:], self.waypoints[1:],
                [self.knots[i:i+2] for i in range(0, len(self.knots), 2)]):
            cp1, cp2 = cps
            self.curves.append(BezierCurve([wp1, cp1, cp2, wp2], steps=self.steps))

        for bz in self.curves:
            bz.Generate()
