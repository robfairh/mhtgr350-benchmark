// defines a 2D geometry os a single cooling channel
SetFactory("OpenCASCADE");

Rc = 1.0;

h = 5/40;
L = 5;

Point(1) = {0, 0, 0, h};
Point(2) = {0, L, 0, h};
Point(3) = {Rc, 0, 0, h};
Point(4) = {Rc, L, 0, h};

Line(1) = {1, 2};
Line(2) = {3, 4};
Line(3) = {2, 4};
Line(4) = {1, 3};

Curve Loop(1) = {4, 2, -3, -1};
Plane Surface(1) = {1};

Physical Surface("coolant") = {1};
Physical Curve("cool_bot") = {4};
Physical Curve("cool_top") = {3};
Physical Curve("chan_wall") = {2};
