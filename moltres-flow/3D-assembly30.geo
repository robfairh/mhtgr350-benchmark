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
x = F + bfg*Tan(Pi/6); y = P + bfg;
Point(26) = {x, y, 0, h};

Line(14) = {22, 2};
Line(15) = {1, 4};
Line(16) = {3, 6};
Line(17) = {5, 8};
Line(18) = {7, 10};
Line(19) = {9, 23};
Line(20) = {22, 11};
Line(21) = {12, 16};
Line(22) = {17, 20};
Line(23) = {21, 24};
Line(24) = {23, 24};
Line(25) = {2, 1};
Line(26) = {4, 3};
Line(27) = {6, 5};
Line(28) = {8, 7};
Line(29) = {10, 9};
Line(30) = {11, 12};
Line(31) = {16, 17};
Line(32) = {20, 21};
Line(33) = {23, 25};
Line(34) = {24, 26};
Line(35) = {25, 26};

// Surfaces
Curve Loop(1) = {25, 1};
Plane Surface(1) = {1};
Curve Loop(2) = {26, 2};
Plane Surface(2) = {2};
Curve Loop(3) = {27, 3};
Plane Surface(3) = {3};
Curve Loop(4) = {28, 4};
Plane Surface(4) = {4};
Curve Loop(5) = {29, 5};
Plane Surface(5) = {5};
Curve Loop(6) = {6, -30};
Plane Surface(6) = {6};
Curve Loop(7) = {7};
Plane Surface(7) = {7};
Curve Loop(8) = {8};
Plane Surface(8) = {8};
Curve Loop(9) = {9};
Plane Surface(9) = {9};
Curve Loop(10) = {10, -31};
Plane Surface(10) = {10};
Curve Loop(11) = {11};
Plane Surface(11) = {11};
Curve Loop(12) = {12};
Plane Surface(12) = {12};
Curve Loop(13) = {13, -32};
Plane Surface(13) = {13};
Curve Loop(14) = {14, -1, 15, -2, 16, -3, 17, -4, 18, -5, 19, 24, -23, -13, -22, -10, -21, -6, -20};
Curve Loop(15) = {7};
Curve Loop(16) = {8};
Curve Loop(17) = {9};
Curve Loop(18) = {11};
Curve Loop(19) = {12};
Plane Surface(14) = {14, 15, 16, 17, 18, 19};
Curve Loop(20) = {33, 35, -34, -24};
Plane Surface(15) = {20};

Extrude {0, 0, Hc} {
  Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5};
  Surface{6}; Surface{7}; Surface{8}; Surface{9}; Surface{10};
  Surface{11}; Surface{12}; Surface{13}; Surface{14}; Surface{15};
  Layers{Lc}; Recombine;
}

