center = PVector(250, 250)
vertical = PVector(250, 150)

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

def setup():
    size(500, 500)
    
def draw():
    background(0)
    strokeWeight(3)
    stroke(255)
    line(center.x, center.y, vertical.x, vertical.y)
    pt = PVector(mouseX, mouseY)
    stroke(255, 0, 0)
    line(center.x, center.y, pt.x, pt.y)
    angle = angle_between_segments(vertical, center, pt)
    stroke(255)
    fill(255)
    textSize(50)
    text(angle, 20, 450)
    
