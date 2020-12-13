// No top and bottom reflector
Geometry.CopyMeshingMethod = 1;

h = 10;

Hb = 160;
Hc = 793;
Ht = 120;

lyb = 20;
lyc = 20;
lyt = 20;

Point(1) = {0, 0, 0, h};
Point(2) = {0, Hc, 0, h};
Line(1) = {1, 2};

Transfinite Line{1} = Hc/lyc;

Physical Curve("fuel") = {1};
Physical Point("fuel_bot") = {1};
Physical Point("fuel_top") = {2};
