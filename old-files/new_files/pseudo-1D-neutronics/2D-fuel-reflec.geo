//
Geometry.CopyMeshingMethod = 1;

Rf = 0.635;  // 0.635 cm
h = .5;

Hb = 160;
Hc = 793;
Ht = 120;

lx = 1;
lyb = 2;
lyc = 10;
lyt = 2;

R = 0;
Point(1) = {R, 0, 0, h};
Point(2) = {R, Hb, 0, h};
Line(1) = {1, 2};

R += 2*Rf;
Point(3) = {R, 0, 0, h};
Point(4) = {R, Hb, 0, h};
Line(2) = {1, 3};
Line(3) = {4, 2};
Line(4) = {3, 4};

Curve Loop(1) = {-1, 2, 3, 4};
Plane Surface(1) = {1};

Point(5) = {0, Hb+Hc, 0, h};
Point(6) = {2*Rf, Hb+Hc, 0, h};
Line(5) = {2, 5};
Line(6) = {4, 6};
Line(7) = {5, 6};

Curve Loop(2) = {5, 7, -6, 3};
Plane Surface(2) = {2};

Point(7) = {0, Hb+Hc+Ht, 0, h};
Point(8) = {2*Rf, Hb+Hc+Ht, 0, h};
Line(8) = {5, 7};
Line(9) = {6, 8};
Line(10) = {7, 8};

Curve Loop(3) = {8, 10, -9, -7};
Plane Surface(3) = {3};

Transfinite Line{2, 3, 7, 10} = (2*Rf)/lx;
Transfinite Line{1, 4} = Hb/lyb;
Transfinite Surface{1};
Recombine Surface{1};

Transfinite Line{5, 6} = Hc/lyc;
Transfinite Surface{2};
Recombine Surface{2};

Transfinite Line{8, 9} = Ht/lyt;
Transfinite Surface{3};
Recombine Surface{3};

Physical Surface("breflector") = {1};
Physical Surface("fuel") = {2};
Physical Surface("treflector") = {3};

Physical Curve("fuel_bot") = {3};
Physical Curve("fuel_top") = {7};
Physical Curve("ref_bot") = {2};
Physical Curve("ref_top") = {10};
