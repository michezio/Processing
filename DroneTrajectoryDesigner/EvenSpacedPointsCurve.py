from CurveFunctions import *

class EvenSpacedPointsCurve:
    def __init__(self, steps=50):
        self.steps = steps
        self.even_spaced = []

    def GetCurve(self):
        return self.even_spaced

    def Generate(self, cur):
        self.even_spaced = []
        if not cur:
            return
        uneven_spaced = [[cur[0], 0.0, 0.0]]
        for p in cur[1:]:
            prev_p = uneven_spaced[-1]
            distance = vector_dist(p, prev_p[0])
            uneven_spaced.append([p, distance, prev_p[2] + distance])
        
        total_len = uneven_spaced[-1][2]

        segment_size = total_len / self.steps

        def findNext(uneven_spaced, last_index, space):
            if space == 0:
                return (uneven_spaced[0][0], 0)
            index = int(last_index)
            while index < len(uneven_spaced)-1 and uneven_spaced[index][2] <= space:
                index += 1
            if index == len(uneven_spaced) - 1:
                return (uneven_spaced[-1][0], index)
            p1 = uneven_spaced[index-1]
            p2 = uneven_spaced[index]
            distance = p2[1]
            covered = p1[2]
            ratio = (space - covered) / (distance + EPSILON)
            new_point = PVector.lerp(p1[0], p2[0], ratio)
            return (new_point, index)

        space = 0
        mul = 0
        last_index = 0
        while space <= total_len:
            pt = findNext(uneven_spaced, last_index, space)
            self.even_spaced.append(pt[0])
            mul += 1
            space = mul * segment_size
            last_index = pt[1]
            
