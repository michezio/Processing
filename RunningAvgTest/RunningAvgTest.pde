double nums;
double avg, running_avg, simplified_running_avg;
double unaveraged_sum, new_element;
int elements;

void setup() {
  frameRate(1000);
	avg = running_avg = simplified_running_avg = 0;
  unaveraged_sum = 0;
	elements = 0;
}

void draw() {
	for (int i=10000000; --i>=0;) nextAvgTestInput();

  if (elements % 100000000 == 0) {
    println("//////////// @ " + elements);
    println("AVERAGE: " + avg);
    println("RUNNING: " + running_avg);
    println("SIMPLED: " + simplified_running_avg);
  }
}

void nextAvgTestInput() {
  new_element = random(1);
  ++elements;

  unaveraged_sum += new_element;
  avg = (double)unaveraged_sum / elements;

  running_avg = (running_avg * (elements - 1) + new_element) / elements;

  simplified_running_avg = simplified_running_avg + (new_element - simplified_running_avg) / elements;
}
