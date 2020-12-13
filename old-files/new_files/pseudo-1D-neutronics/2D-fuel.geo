// No top and bottom reflector

Geometry.CopyMeshingMethod = 1;

Rf = 0.635;  // 0.635 cm
h = .5;

Hb = 160;
Hc = 793;
Ht = 120;

lx = 1;
lyb = 10;
lyc = 40;
lyt = 10;

R = 0;
Point(1) = {R, 0, 0, h};
Point(2) = {R, Hc, 0, h};
Line(1) = {1, 2};

R += 2*Rf;
Point(3) = {R, 0, 0, h};
Point(4) = {R, Hc, 0, h};
Line(2) = {1, 3};
Line(3) = {4, 2};
Line(4) = {3, 4};

Curve Loop(1) = {-1, 2, 3, 4};
Plane Surface(1) = {1};

Transfinite Line{2, 3} = (2*Rf)/lx;
Transfinite Line{1, 4} = Hc/lyb;
Transfinite Surface{1};
Recombine Surface{1};

Physical Surface("fuel") = {1};
Physical Curve("fuel_bot") = {2};
Physical Curve("fuel_top") = {3};
