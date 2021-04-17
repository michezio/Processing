public static class Matrix {
	
	private int rows;
	private int cols;
	public double[][] data;

	public Matrix(int rows, int cols) {
		this.rows = rows;
		this.cols = cols;
		this.data = new double[rows][];

		for (int i=0; i<rows; ++i) {
			this.data[i] = new double[cols];
			for (int j=0; j<cols; ++j) {
				this.data[i][j] = 0;
			}
		}
	}

	public int getCols() { return this.cols; }
	public int getRows() { return this.rows; }
	public double get(int i, int j) { return this.data[i][j]; }
	public void set(int i, int j, double value) { this.data[i][j] = value; }

	// MULTIPLICATION ----------------------------------------------------------------------

	public static Matrix mult(Matrix a, Matrix b) {
		if (a.getCols() != b.getRows()) {
			//console.log("Columns of 1st matrix must match rows of 2nd matrix!");
			return null;
		}
		Matrix result = new Matrix(a.getRows(), b.getCols());
		for (int i=0; i<result.getRows(); ++i) {
			for (int j=0; j<result.getCols(); ++j) {
				double sum = 0;
				for (int k=0; k<a.getCols(); ++k) {
					sum += a.get(i,k) * b.get(k,j);
				}
				result.data[i][j] = sum;
			}
		}
		return result;
	}

	// ADDITION ------------------------------------------------------------------------------

	public void add(Matrix mat) {
		if (this.rows != mat.getRows() || this.cols != mat.getCols()) {
			//console.log("Matrix dimensions don't match!")
			return;
		}
		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] += mat.data[i][j];
			}
		}
	}

	public void add(double value) {
		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] += value;
			}
		}
	}

	public static Matrix add(Matrix mat1, Matrix mat2) {
		if (mat1.getRows() != mat2.getRows() || mat1.getCols() != mat2.getCols()) {
			//console.log("Matrix dimensions don't match!")
			return null;
		}
		Matrix result = new Matrix(mat1.getRows(), mat1.getCols());
		for (int i=0; i<result.getRows(); ++i) {
			for (int j=0; j<result.getCols(); ++j) {
				result.data[i][j] = mat1.data[i][j] + mat2.data[i][j];
			}
		}
		return result;
	}

	public static Matrix add(Matrix mat, double value) {
		Matrix result = new Matrix(mat.getRows(), mat.getCols());
		for (int i=0; i<result.getRows(); ++i) {
			for (int j=0; j<result.getCols(); ++j) {
				result.data[i][j] = mat.data[i][j] + value;
			}
		}
		return result;
	}

	// SUBTRACTION -------------------------------------------------------------------------

	public void sub(Matrix mat) {
		if (this.rows != mat.getRows() || this.cols != mat.getCols()) {
			//console.log("Matrix dimensions don't match!")
			return;
		}
		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] -= mat.data[i][j];
			}
		}
	}

	public void sub(double value) {
		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] -= value;
			}
		}
	}

	public static Matrix sub(Matrix mat1, Matrix mat2) {
		if (mat1.getRows() != mat2.getRows() || mat1.getCols() != mat2.getCols()) {
			//console.log("Matrix dimensions don't match!")
			return null;
		}
		Matrix result = new Matrix(mat1.getRows(), mat1.getCols());
		for (int i=0; i<result.getRows(); ++i) {
			for (int j=0; j<result.getCols(); ++j) {
				result.data[i][j] = mat1.data[i][j] - mat2.data[i][j];
			}
		}
		return result;
	}

	public static Matrix sub(Matrix mat, double value) {
		Matrix result = new Matrix(mat.getRows(), mat.getCols());
		for (int i=0; i<result.getRows(); ++i) {
			for (int j=0; j<result.getCols(); ++j) {
				result.data[i][j] = mat.data[i][j] - value;
			}
		}
		return result;
	}

	// SCALING ----------------------------------------------------------------------------

	public void scale(Matrix mat) {
		if (this.rows != mat.getRows() || this.cols != mat.getCols()) {
			//console.log("Matrix dimensions don't match!")
			return;
		}
		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] *= mat.data[i][j];
			}
		}
	}

	public void scale(double value) {
		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] *= value;
			}
		}
	}

	public static Matrix scale(Matrix mat1, Matrix mat2) {
		if (mat1.getRows() != mat2.getRows() || mat1.getCols() != mat2.getCols()) {
			//console.log("Matrix dimensions don't match!")
			return null;
		}
		Matrix result = new Matrix(mat1.getRows(), mat1.getCols());
		for (int i=0; i<result.getRows(); ++i) {
			for (int j=0; j<result.getCols(); ++j) {
				result.data[i][j] = mat1.data[i][j] * mat2.data[i][j];
			}
		}
		return result;
	}

	public static Matrix scale(Matrix mat, double value) {
		Matrix result = new Matrix(mat.getRows(), mat.getCols());
		for (int i=0; i<result.getRows(); ++i) {
			for (int j=0; j<result.getCols(); ++j) {
				result.data[i][j] = mat.data[i][j] * value;
			}
		}
		return result;
	}

	// MAPPING -----------------------------------------------------------------------------

	// map(func) {
	// 	for (int i=0; i<this.rows; ++i) {
	// 		for (int j=0; j<this.cols; ++j) {
	// 			this.data[i][j] = func(this.data[i][j]);
	// 		}
	// 	}
	// }

	// static map(mat, func) {
	// 	Matrix result = new Matrix(mat.rows, mat.cols);
	// 	for (int i=0; i<result.rows; ++i) {
	// 		for (int j=0; j<result.cols; ++j) {
	// 			result.data[i][j] = func(mat.data[i][j]);
	// 		}
	// 	}
	// 	return result;
	// }

	// CASTING ----------------------------------------------------------------------

	public static Matrix fromArray(double[][] array) {
		Matrix result = new Matrix(array.length, array[0].length);
		for (int i=0; i<array.length; ++i) {
			for (int j=0; j<array[i].length; ++j) {
				result.data[i][j] = array[i][j];
			}
		}
		return result;
	}

	public static Matrix fromArray(double[] array) {
		Matrix result = new Matrix(array.length, 1);
		for (int i=0; i<array.length; ++i) {
			result.data[i][0] = array[i];
		}
		return result;
	}
		
	public static Matrix fromArray(double value) {
		Matrix result = new Matrix(1,1);
		result.data[0][0] = value;
		return result;
	}

	public double[][] toArray() {
		double[][] result = new double[this.rows][];
		for (int i=0; i<this.rows; ++i) {
			result[i] = new double[this.cols];
			for (int j=0; j<this.cols; ++j) {
				result[i][j] = this.data[i][j];
			}
		}
		return result;
	}

	public double[] toVector() {
		double[] result = new double[this.rows];
		for (int i=0; i<this.rows; ++i) {
			result[i] = this.data[i][0];
		}
		return result;
	}

	// TRANSPOSITION ----------------------------------------------------------

	public static Matrix transpose(Matrix mat) {
		Matrix result = new Matrix(mat.getCols(), mat.getRows());
		for (int i=0; i<mat.getRows(); ++i) {
			for (int j=0; j<mat.getCols(); ++j) {
				result.data[j][i] = mat.data[i][j];
			}
		}
		return result;
	}

	// INITIALIZATION ----------------------------------------------------------

	public void randomize() {
		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] = Math.random();
			}
		}
	}

	public void randomize(double max) {

		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] = (Math.random()*max);
			}
		}
	}

	public void randomize(double min, double max) {
		double scaling = max - min;
		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] = (Math.random()*scaling + min);
			}
		}
	}

	public void initialize(double value) {

		for (int i=0; i<this.rows; ++i) {
			for (int j=0; j<this.cols; ++j) {
				this.data[i][j] = value;
			}
		}
	}

	/* METHODS TO ADD:

		Element-wise product,
		dimensions expansion (zero padding),
		inverse,
		determinant,
		extraction/insertion
		sum (column, row, full)
		min, max (column, row, full)
		average (column, row, full)

		*/
}
