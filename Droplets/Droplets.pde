final float DIM = 100;

ArrayList<Drop> drops; 

void setup() {
	size(500,500);
	background(0);
	drops = new ArrayList<Drop>();
}

void draw() {
	background(0);
	for (Drop D : drops) {
		D.update();
		D.show(color(255));
	}
}

void mouseClicked() {
	drops.add(new Drop(mouseX, mouseY, random(DIM/5, DIM)));
}