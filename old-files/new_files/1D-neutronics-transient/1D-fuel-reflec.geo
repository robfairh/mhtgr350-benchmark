// No top and bottom reflector
Geometry.CopyMeshingMethod = 1;

h = 0.5;

Hb = 160;
Hc = 793;
Ht = 120;

lyb = 1;
lyc = 1;
lyt = 1;

Point(1) = {0, 0, 0, h};
Point(2) = {0, Hb, 0, h};
Point(3) = {0, Hb+Hc, 0, h};
Point(4) = {0, Hb+Hc+Ht, 0, h};
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};

Transfinite Line{1} = Hb/lyb;
Transfinite Line{2} = Hc/lyc;
Transfinite Line{3} = Ht/lyt;

Physical Curve("breflector") = {1};
Physical Curve("fuel") = {2};
Physical Curve("treflector") = {3};
Physical Point("ref_bot") = {1};
Physical Point("ref_top") = {4};
