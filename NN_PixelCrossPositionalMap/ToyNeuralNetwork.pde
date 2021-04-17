public static class ToyNeuralNetwork {

	private int nodes_i;
	private int nodes_h;
	private int nodes_o;
	private Matrix weights_ih;
	private Matrix weights_ho;
	private Matrix bias_h;
	private Matrix bias_o;
	private double learning_rate;

	public ToyNeuralNetwork(int nodes_i, int nodes_h, int nodes_o, double lr) {
		// Proper constructor for the Neural Network
		this.nodes_i = nodes_i;
		this.nodes_h = nodes_h;
		this.nodes_o = nodes_o;

		this.weights_ih = new Matrix(nodes_h, nodes_i);
		this.weights_ho = new Matrix(nodes_o, nodes_h);
		this.weights_ih.randomize();
		this.weights_ho.randomize();

		this.bias_h = new Matrix(nodes_h, 1);
		this.bias_o = new Matrix(nodes_o, 1);
		this.bias_h.randomize();
		this.bias_o.randomize();

		this.learning_rate = lr;
	}

	public ToyNeuralNetwork(int nodes_i, int nodes_h, int nodes_o) {
		this(nodes_i, nodes_h, nodes_o, 0.1);
	}

	public ToyNeuralNetwork(int nodes_i, int nodes_o) {
		this(nodes_i, (int) Math.round(Math.sqrt(nodes_i*nodes_o)), nodes_o);
	}

	public ToyNeuralNetwork(int nodes) {
		this(nodes, nodes, nodes);
	}

	public void randomize() {
		this.weights_ih.randomize();
		this.weights_ho.randomize();
		this.bias_h.randomize();
		this.bias_o.randomize();
	}

	public double[] infer(double[] input_array) {
		// convert input to matrix
		Matrix input = Matrix.fromArray(input_array);

		// generate output for the hidden layer
		Matrix hidden = Matrix.mult(this.weights_ih, input);
		hidden.add(this.bias_h);
	    applySigmoid(hidden);

		// generate output for the output layer
		Matrix output = Matrix.mult(this.weights_ho, hidden);
		output.add(this.bias_o);
		applySigmoid(output);

		// convert output to array
		return output.toVector();
	}

	public double[] guess(double[] input_array) {
		return infer(input_array);
	}

	public void train(double[] input_array, double[] target_array) {
		// convert input and target into matrix
		Matrix input = Matrix.fromArray(input_array);
		Matrix target = Matrix.fromArray(target_array);

		// generate output for the hidden layer
		Matrix hidden = Matrix.mult(this.weights_ih, input);
		hidden.add(this.bias_h);
		applySigmoid(hidden);

		// generate output for the output layer
		Matrix output = Matrix.mult(this.weights_ho, hidden);
		output.add(this.bias_o);
		applySigmoid(output);

		// compute output error based on target
		Matrix errors_o = Matrix.sub(target, output);

		// generate the gradients for the output weights and compute deltas
		Matrix gradients_o = calculateGradient(output);
		gradients_o.scale(errors_o);
		gradients_o.scale(this.learning_rate);
		Matrix hidden_t = Matrix.transpose(hidden);
		Matrix weights_ho_deltas = Matrix.mult(gradients_o, hidden_t);

		// update hidden/output weights and bias based on deltas
		this.weights_ho.add(weights_ho_deltas);
		this.bias_o.add(gradients_o);

		// compute hidden error based on output error
		Matrix weights_ho_t = Matrix.transpose(this.weights_ho);
		Matrix errors_h = Matrix.mult(weights_ho_t, errors_o);

		// generate the gradients for the hidden weights and compute deltas
		Matrix gradients_h = calculateGradient(hidden);
		gradients_h.scale(errors_h);
		gradients_h.scale(this.learning_rate);
		Matrix input_t = Matrix.transpose(input);
		Matrix weights_ih_deltas = Matrix.mult(gradients_h, input_t);

		// update input/hidden weights and bias based on deltas
		this.weights_ih.add(weights_ih_deltas);
		this.bias_h.add(gradients_h);
	}

	public void setLearningRate(double lr) {
		this.learning_rate = lr;
	}

  public double getLearningRate() {
    return this.learning_rate;
  }

	public void shake(double coef) {
		for (int i=0; i<weights_ih.getRows(); ++i) {
			for (int j=0; j<weights_ih.getCols(); ++j) {
				double value = weights_ih.get(i, j) + Math.random()*2*coef-coef;
				weights_ih.set(i, j, value);
			}
		}
		for (int i=0; i<weights_ho.getRows(); ++i) {
			for (int j=0; j<weights_ho.getCols(); ++j) {
				double value = weights_ho.get(i, j) + Math.random()*2*coef-coef;
				weights_ho.set(i, j, value);
			}
		}
	}

// PRIVATE FUNCTIONS -------------------------------------------------------

	private double sigmoid(double x) {
		return 1/(1+Math.exp(-x));
	}

	private double Dsigmoid(double x) {
		return x*(1-x);
	}

	private void applySigmoid(Matrix mat) {
		for (int i=0; i<mat.getRows(); ++i) {
			for (int j=0; j<mat.getCols(); ++j) {
				double value = sigmoid(mat.get(i, j));
				mat.set(i, j, value);
			}
		}
	}

	private Matrix calculateGradient(Matrix mat) {
		Matrix result = new Matrix(mat.getRows(), mat.getCols());
		for (int i=0; i<mat.getRows(); ++i) {
			for (int j=0; j<mat.getCols(); ++j) {
				double value = Dsigmoid(mat.get(i, j));
				result.set(i, j, value);
			}
		}
		return result;
	}

// GRAPHING ------------------------------------------------------------------------

	// graph(x,y,w,h) {				// needs p5.js to work!
	// 	let dim = 5*h/100.0;
	// 	let str = 0.3*h/100.0;
	// 	fill(0);
	// 	noStroke();
	// 	rect(x,y,w,h);
	// 	strokeWeight(str);
	// 	let n_in = this.nodes_i;
	// 	let n_hid = this.nodes_h;
	// 	let n_out = this.nodes_o;

	// 	let instep = h / (n_in+1);
	// 	let hidstep = h / (n_hid+1);
	// 	let outstep = h / (n_out+1);

	// 	let w1 = this.weights_ih;
	// 	for (let i=0; i<w1.rows; ++i) {
	// 		for (let j=0; j<w1.cols; ++j) {
	// 			let a = w1.data[i][j];
	// 			if (a > 0) stroke(color(0,255,0,a/30*255));
	// 			else stroke(color(255,0,0,-a/30*255));
	// 			line(x+w/10,y+(j+1)*instep,x+w/2,y+(i+1)*hidstep);
	// 		}
	// 	}
	// 	let w2 = this.weights_ho;
	// 	for (let i=0; i<w2.rows; ++i) {
	// 		for (let j=0; j<w2.cols; ++j) {
	// 			let b = w2.data[i][j];
	// 			if (b > 0) stroke(color(0,255,0,b/30*255));
	// 			else stroke(color(255,0,0,-b/30*255));
	// 			line(x+w/2,y+(j+1)*hidstep,x+9*w/10,y+(i+1)*outstep);
	// 		}
	// 	}

	// 	noStroke();
	// 	fill(200);
	// 	for (let i=0; i<n_in; ++i) {
	// 		ellipse(x+w/10,y+(i+1)*instep,dim);
	// 	}
	// 	for (let i=0; i<n_hid; ++i) {
	// 		ellipse(x+w/2,y+(i+1)*hidstep,dim);
	// 	}
	// 	for (let i=0; i<n_out; ++i) {
	// 		ellipse(x+9*w/10,y+(i+1)*outstep,dim);
	// 	}
	// }
}
