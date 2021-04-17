from CurveFunctions import *

'''
generate spline from catmull-rom curve
'''

class CatmullRomCurve:
    def __init__(self, nodes, steps=10, alpha=0.0):
        self.curve = []
        self.nodes = nodes
        self.steps = steps
        self.alpha = alpha/2.0  # precomputed square root
    
    def GetCurve(self):
        return [x[0] for x in self.curve]

    def Generate(self):
        '''
        following the implementation from Wikipedia:
        https://en.wikipedia.org/wiki/Centripetal_Catmull%E2%80%93Rom_spline
        '''
        
        self.curve = []
        p0, p1, p2, p3 = self.nodes

        def shift(Pi, Pj):
            # the square root is precomputed in alpha
            return ((Pj.x - Pi.x)**2 + (Pj.y - Pi.y)**2 + (Pj.z - Pi.z)**2) ** self.alpha
        
        t0 = 0.0
        t1 = t0 + shift(p0, p1)
        t2 = t1 + shift(p1, p2)
        t3 = t2 + shift(p2, p3)

        absoluteDistance = 0.0
        
        stps = [x for x in float_range(t1, t2, self.steps)]
        #stps.append(t2)
        for t in stps:
            # A1 = (t1-t)/(t1-t0)*P0 + (t-t0)/(t1-t0)*P1
            A1 = PVector.add(
                PVector.mult(p0, (t1-t)/(t1-t0)),
                PVector.mult(p1, (t-t0)/(t1-t0))
            )
            # A2 = (t2-t)/(t2-t1)*P1 + (t-t1)/(t2-t1)*P2
            A2 = PVector.add(
                PVector.mult(p1, (t2-t)/(t2-t1)),
                PVector.mult(p2, (t-t1)/(t2-t1))
            )
            # A3 = (t3-t)/(t3-t2)*P2 + (t-t2)/(t3-t2)*P3
            A3 = PVector.add(
                PVector.mult(p2, (t3-t)/(t3-t2)),
                PVector.mult(p3, (t-t2)/(t3-t2))
            )
            # B1 = (t2-t)/(t2-t0)*A1 + (t-t0)/(t2-t0)*A2
            B1 = PVector.add(
                PVector.mult(A1, (t2-t)/(t2-t0)),
                PVector.mult(A2, (t-t0)/(t2-t0))
            )
            # B2 = (t3-t)/(t3-t1)*A2 + (t-t1)/(t3-t1)*A3
            B2 = PVector.add(
                PVector.mult(A2, (t3-t)/(t3-t1)),
                PVector.mult(A3, (t-t1)/(t3-t1))
            )
            # point = (t2-t)/(t2-t1)*B1 + (t-t1)/(t2-t1)*B2
            point = PVector.add(
                PVector.mult(B1, (t2-t)/(t2-t1)),
                PVector.mult(B2, (t-t1)/(t2-t1))
            )

            relativeDistance = 0.0

            if self.curve:
                last_point = self.curve[-1][0]
                relativeDistance = vector_dist(last_point, point)
                absoluteDistance += relativeDistance

            self.curve.append([point, t, relativeDistance, absoluteDistance])
        return absoluteDistance


class CatmullRomFromWaypoints:
    def __init__(self, waypoints, steps=10, alpha=0.0):
        self.curves = []
        self.waypoints = waypoints
        self.steps = steps
        self.alpha = alpha

    def GetCurve(self):
        pts = []
        for c in self.curves:
            pts += c.GetCurve()
        return pts

    def GenerateCurves(self):
        self.curves = []
        # wp = self.waypoints[:1] + self.waypoints + self.waypoints[-1:]
        fp = PVector.lerp(self.waypoints[0], self.waypoints[1], -0.5)
        lp = PVector.lerp(self.waypoints[-2], self.waypoints[-1], 1.5)
        wp = [fp] + self.waypoints + [lp]
        for wps in zip(wp[0:], wp[1:], wp[2:], wp[3:]):
            self.curves.append(
                CatmullRomCurve(wps, steps=self.steps, alpha=self.alpha)
            )
        for crc in self.curves:
            crc.Generate()
