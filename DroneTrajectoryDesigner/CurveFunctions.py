import math

def factorial(x):
    # bind a local dp dictionary to the function itself
    factorial.dp = getattr(factorial, 'dp', {0:1, 1:1, 2:2})
    if x < 0:
        return 0
    elif x in factorial.dp.keys():
        return factorial.dp[x]
    else:
        factorial.dp[x] = x * factorial(math.ceil(x)-1)
        return factorial.dp[x]

def tgamma(x):
    return math.gamma(x+1)

def float_range(start, stop, steps):
    step = float(stop - start) / steps
    while start < stop:
        yield start
        start += step

def vector_dist(a, b):
    return dist(a.x, a.y, b.x, b.y)

def angle_between_segments(p1, p2, p3):
    v1 = PVector.sub(p1, p2)
    v2 = PVector.sub(p3, p2)
    # angle = PVector.angleBetween(v1, v2)
    angle = angle_with_sign(v1, v2)
    return angle

def angle_with_sign(v1, v2):
    a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x)
    if a < 0:
        a += TWO_PI
    if a > PI:
        a -= TWO_PI
    return a

def rotate2D(point, pivot, angle):
    p0 = PVector.sub(point, pivot)
    p0.x = p0.x * cos(angle) - p0.y * sin(angle)
    p0.y = p0.x * sin(angle) + p0.y * cos(angle)
    p0.add(pivot)
    return p0
