// 1/6 of the 3D fuel assembly geometry
SetFactory("OpenCASCADE");

Rc = 0.794;
Rsc = 0.635;   // small coolant channel
dx = 0.2;      // coolant gap thickness
Rcg = Rc + dx; // coolant gap radius
Rf = 0.6225;
Rg = 0.635+0.2;

bfg = 1; // bypassflow gap

p = 1.88;
f = p*Cos(Pi/6);

P = 18; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;

h = 1.0;

Hc = 10;
Lr = 2.0;
Lc = 200; // Axial layers in the core

// Circles
x = 0; y = 2*f;
Circle(1) = { x, y, 0, Rsc, -Pi/2, Pi/2};
x = 0; y = 4*f;
Circle(2) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 6*f;
Circle(3) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 8*f;
Circle(4) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 10*f;
Circle(5) = { x, y, 0, Rc, -Pi/2, Pi/2};

x = 3/2*p; y = 3*f;
Circle(6) = { x, y, 0, Rc, Pi/3, 4*Pi/3};
x = 3/2*p; y = 5*f;
Circle(7) = { x, y, 0, Rc, 0, 2*Pi};
x = 3/2*p; y = 7*f;
Circle(8) = { x, y, 0, Rc, 0, 2*Pi};
x = 3/2*p; y = 9*f;
Circle(9) = { x, y, 0, Rc, 0, 2*Pi};

x = 3*p; y = 6*f;
Circle(10) = { x, y, 0, Rc, Pi/3, 4*Pi/3};
x = 3*p; y = 8*f;
Circle(11) = { x, y, 0, Rc, 0, 2*Pi};
x = 3*p; y = 10*f;
Circle(12) = { x, y, 0, Rc, 0, 2*Pi};

x = 9/2*p; y = 9*f;
Circle(13) = { x, y, 0, Rc, Pi/3, 4*Pi/3};

// Points & Lines
x = 0; y = 0;
Point(22) = {x, y, 0, h};
x = 0; y = P;
Point(23) = {x, y, 0, h};
x = F; y = P;
Point(24) = {x, y, 0, h};
x = 0; y = P + bfg;
Point(25) = {x, y, 0, h};
x = F + bfg*Cos(Pi/3); y = P + bfg*Sin(Pi/3);
Point(26) = {x, y, 0, h};