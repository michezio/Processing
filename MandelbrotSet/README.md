# MandelbrotSet

Graphs and navigate a Mandelbrot set using mouse and keyboard. Again one of my earliest project with Processing so not very well written.

## How it works

Use your mouse to click on a point of the plot to center it.
Use Q to zoom in and A to zoom out.
Use W to increase details by 10 and S to decrease by 10. Use E and D to increase and decrease by 1.
Use C to change the color palette.
Use Z to reset the plot.
Use IJKL to navigate the plot.
Use V to toggle the crossair view (to mark the center where zoom will happen).
Use B to toggle antialiasing (using a simple handmade filter, 3 filters are available but you need to change the code to switch between them).

## Known bugs

Not properly a bug but max depth is around 2 x 10^-5. After that everything appears pixelated. This is probably due to rounding of floats in Processing but I haven't investigated enough yet.

### License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
