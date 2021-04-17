final int PANEL = 100;

class Panel
{
    int size;

    VSlider reds, greens, blues, grids;
    SButton redButton, greenButton, blueButton,
            yellowButton, cyanButton, magentaButton,
            whiteButton, greyButton, blackButton,
            customButton, pickedButton;
    PButton gridButton;

    Panel ()
    {
        size = PANEL;
        reds = new VSlider( "R", width-PANEL+20, 30, 100, 10, color(255,0,0) );
        greens = new VSlider( "G", width-PANEL+50, 30, 100, 10, color(0,255,0) );
        blues = new VSlider( "B", width-PANEL+80, 30, 100, 10, color(0,0,255) ); 
        grids = new VSlider( "Grid", width-PANEL+20, 320, 100, 10, color(255,255,255) );
    
        gridButton = new PButton( "Grid", width-PANEL+40, 320, 50, 100, color(120,120,120) );
        redButton = new SButton( width-PANEL+10, 180, 20, 20, color(255,0,0) );
        greenButton = new SButton( width-PANEL+40, 180, 20, 20, color(0,255,0) );
        blueButton = new SButton( width-PANEL+70, 180, 20, 20, color(0,0,255) );
        yellowButton = new SButton( width-PANEL+10, 210, 20, 20, color(255,255,0) );
        cyanButton = new SButton( width-PANEL+40, 210, 20, 20, color(0,255,255) );
        magentaButton = new SButton( width-PANEL+70, 210, 20, 20, color(255,0,255) );
        whiteButton = new SButton( width-PANEL+10, 240, 20, 20, color(255,255,255) );
        greyButton = new SButton( width-PANEL+40, 240, 20, 20, color(127,127,127) );
        blackButton = new SButton( width-PANEL+70, 240, 20, 20, color(0,0,0) );
        customButton = new SButton( width-PANEL+10, 270, 35, 20, color(0,0,0) );
        pickedButton = new SButton( width-PANEL+55, 270, 35, 20, color(0,0,0) );
    }

    void show()
    {
        noStroke();
        fill(color(60,60,60));
        rect(width-PANEL+1,0,PANEL-1, height);

        reds.show();
        greens.show();
        blues.show();  
        grids.show();
        
        gridButton.setText(str(1+ceil(127*grids.getValue())));
        gridButton.show();
    
        redButton.show();
        greenButton.show();
        blueButton.show();
        yellowButton.show();
        cyanButton.show();
        magentaButton.show();
        whiteButton.show();
        blackButton.show();
        greyButton.show();

        customButton.setColor(color(255*reds.getValue(),255*greens.getValue(),255*blues.getValue()));
        customButton.show();
        pickedButton.show();
    }

    void checkStart()
    {
        reds.mouseOver(true);
        greens.mouseOver(true);
        blues.mouseOver(true);
        grids.mouseOver(true);
        
        gridButton.mouseOver();
        redButton.mouseOver();
        greenButton.mouseOver();
        blueButton.mouseOver();
        yellowButton.mouseOver();
        cyanButton.mouseOver();
        magentaButton.mouseOver();
        whiteButton.mouseOver();
        greyButton.mouseOver();
        blackButton.mouseOver();
        customButton.mouseOver();
        pickedButton.mouseOver();
    }

    void checkStop()
    {
        reds.mouseOver(false);
        greens.mouseOver(false);
        blues.mouseOver(false);
        grids.mouseOver(false);
    }
}