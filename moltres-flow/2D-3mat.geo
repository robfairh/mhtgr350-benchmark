// No top and bottom reflector

Geometry.CopyMeshingMethod = 1;

Rf = 0.6225; // cm
Rg = 0.6350; // cm
Rm = 1.88-0.794; // cm

h = 4.;
H = 4;
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

R = Rm;
Point(7) = {R, 0, 0, h};
Point(8) = {R, H, 0, h};
Line(8) = {5, 7};
Line(9) = {8, 6};
Line(10) = {7, 8};

Curve Loop(1) = {-1, 2, 3, 4};
Plane Surface(1) = {1};
Curve Loop(2) = {-4, 5, 6, 7};
Plane Surface(2) = {2};
Curve Loop(3) = {-7, 8, 9, 10};
Plane Surface(3) = {3};

Transfinite Line{2, 3} = Lf;
Transfinite Line{5, 6} = Lg;
Transfinite Line{8, 9} = Lm;
Transfinite Line{1, 4, 7, 10} = Ly;

Transfinite Surface{1, 2, 3};
Recombine Surface{1, 2, 3};

Physical Line("left") = {1};
Physical Line("right") = {10};

Physical Surface("fuel") = {1};
Physical Surface("gap") = {2};
Physical Surface("moderator") = {3};
