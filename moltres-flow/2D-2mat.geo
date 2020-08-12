// No top and bottom reflector

Geometry.CopyMeshingMethod = 1;

Rf = 1; // cm
Rg = 2; // cm

h = 4.;
H = 10;
Lf = 10;
Lg = 3;
Lm = 16;
Ly = 10;

R = 0;
Point(1) = {R, 0, 0, h};
Point(2) = {R, H, 0, h};
Line(1) = {1, 2};

R = Rf;
Point(3) = {R, 0, 0, h};
Point(4) = {R, H, 0, h};
Line(2) = {1, 3};
Line(3) = {4, 2};
Line(4) = {3, 4};

R = Rg;
Point(5) = {R, 0, 0, h};
Point(6) = {R, H, 0, h};
Line(5) = {3, 5};
Line(6) = {6, 4};
Line(7) = {5, 6};

Curve Loop(1) = {-1, 2, 3, 4};
Plane Surface(1) = {1};
Curve Loop(2) = {-4, 5, 6, 7};
Plane Surface(2) = {2};

Transfinite Line{2, 3} = 5;
Transfinite Line{5, 6} = 2;
Transfinite Line{1, 4, 7} = 100;

Transfinite Surface{1, 2};
Recombine Surface{1, 2};

Physical Line("left") = {1};
Physical Line("right") = {7};
Physical Line("cool_bottom") = {5};
Physical Line("cool_top") = {6};

Physical Surface("fuel") = {1};
Physical Surface("coolant") = {2};
