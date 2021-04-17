static class Quaternion {
    
    double w, x, y, z;

    static Quaternion nonNormalized(double angle, PVector axis) {
        double sinAngle = Math.sin(angle);
        return new Quaternion(
            Math.cos(angle),
            axis.x * sinAngle,
            axis.y * sinAngle,
            axis.z * sinAngle
        );
    }

    static PVector rotate(PVector vector, PVector axis, double angle) {
        Quaternion q = new Quaternion(angle, axis);
        return q.getRotationOf(vector);
    }

    Quaternion(double w, double x, double y, double z) {
        set(w, x, y, z);
    }

    Quaternion(double angle, PVector direction) {
        set(angle, direction);
    }

    Quaternion(PVector vector) {
        this(0, vector.x, vector.y, vector.z);
    }

    Quaternion() {
        this(1, 0, 0, 0);
    }

    Quaternion set(double w, double x, double y, double z) {
        this.w = w;
        this.x = x;
        this.y = y;
        this.z = z;
        return this;
    }

    Quaternion set(double angle, PVector axis) {
        PVector normAxis = axis.copy();
        normAxis.normalize();
        double a = angle / 2.0d;
        double sinAngle = Math.sin(a);
        this.w = Math.cos(a);
        this.x = normAxis.x * sinAngle;
        this.y = normAxis.y * sinAngle;
        this.z = normAxis.z * sinAngle;
        return this;
    }

    boolean equals(Quaternion a) {
        return (w == a.w && x == a.x && y == a.y && z == a.z);
    }

    Quaternion copy() {
        return new Quaternion(w, x, y, z);
    }

    Quaternion normalize() {
        double norm = 1.0d / Math.sqrt(w*w + x*x + y*y + z*z);
        this.w *= norm;
        this.x *= norm;
        this.y *= norm;
        this.z *= norm;
        return this;
    }

    Quaternion conjugate() {
        return new Quaternion(w, -x, -y, -z);
    }

    Quaternion mult(float f) {
        return new Quaternion(w*f, x*f, y*f, z*f);
    }

    Quaternion scale(float f) {
        this.w *= f;
        this.x *= f;
        this.y *= f;
        this.z *= f;
        return this;
    }

    Quaternion mult(Quaternion q) {
        return new Quaternion(
            q.w*w - q.x*x - q.y*y - q.z*z,
            q.w*x + q.x*w + q.y*z - q.z*y,
            q.w*y - q.x*z + q.y*w + q.z*x,
            q.w*z + q.x*y - q.y*x + q.z*w
        );
    }

    Quaternion mult(PVector v) {
        Quaternion q = new Quaternion(v);
        return this.mult(q);
    }

    PVector getAxis() {
        return new PVector((float)x, (float)y, (float)z);
    }

    void applyRotationTo(PVector v) {
        float xx = (float)(2*x*x);
        float yy = (float)(2*y*y);
        float zz = (float)(2*z*z);
        float xw = (float)(2*x*w);
        float yw = (float)(2*y*w);
        float zw = (float)(2*z*w);
        float xy = (float)(2*x*y);
        float xz = (float)(2*x*z);
        float yz = (float)(2*y*z);
        v.set(  v.x * (1 - yy - zz)   +
                v.y * (xy - zw)       +
                v.z * (xz + yw)       ,            
                v.x * (xy + zw)       +
                v.y * (1 - xx - zz)   +
                v.z * (yz - xw)       ,             
                v.x * (xz - yw)       +
                v.y * (yz + xw)       +
                v.z * (1 - xx - yy)   );
    }

    PVector getRotationOf(PVector v) {
        double rx = v.x * (1 - 2*y*y - 2*z*z)   +
                    v.y * (2*x*y - 2*z*w)       +
                    v.z * (2*x*z + 2*y*w)       ;            
        double ry = v.x * (2*x*y + 2*z*w)       +
                    v.y * (1 - 2*x*x - 2*z*z)   +
                    v.z * (2*y*z - 2*x*w)       ;             
        double rz = v.x * (2*x*z - 2*y*w)       +
                    v.y * (2*y*z + 2*x*w)       +
                    v.z * (1 - 2*x*x - 2*y*y)   ;
        return new PVector((float)rx, (float)ry, (float)rz);
    }
}