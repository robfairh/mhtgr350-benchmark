SetFactory("OpenCASCADE");

h = 0.5;
P = 7; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;

// Points & Lines
x = 0; y = 0;
Point(1) = {x, y, 0, h};
x = 0; y = P;
Point(2) = {x, y, 0, h};
x = F; y = P;
Point(3) = {x, y, 0, h};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 1};
Curve Loop(1) = {1, 2, 3};
Plane Surface(1) = {1};

Physical Surface("triangle") = {1};
Physical Point("center") = {1};
Physical Curve("left") = {1};
Physical Curve("right") = {3};
Physical Curve("out") = {2};
