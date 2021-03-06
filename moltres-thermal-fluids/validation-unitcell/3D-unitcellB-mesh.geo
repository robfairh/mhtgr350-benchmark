// 3D unit cell with helium gap
SetFactory("OpenCASCADE");

Rc = 0.795;
Rf = 0.6225;
Rg = 0.67;
dx = 0.05;
p = 1.885;
f = p*Cos(Pi/6);

h = 2;
Hc = 793;
Lcore = 80;
// 2/3/4
// Lm1 = 7; // longer edge
// Lm2 = 6;
// Lf = 8;
// Lc = 8;

// 5
// Lm1 = 12; // longer edge
// Lm2 = 8;
// Lf = 12;
// Lc = 12;

// Mesh
Lm1 = 20; // longer edge
Lm2 = 12;
Lf = 20;
Lc = 25;

x = 0; y = 0;
Circle(1) = {x, y, 0, Rf, 0, 1/3*Pi};
Circle(2) = {x, y, 0, Rg, 0, 1/3*Pi};

x = p; y = 0;
Circle(3) = {x, y, 0, Rc, 2/3*Pi, Pi};
Circle(4) = {x, y, 0, Rc+dx, 2/3*Pi, Pi};

x = p*Cos(Pi/3); y = p*Sin(Pi/3);
Circle(5) = {x, y, 0, Rf, 4/3*Pi, 5/3*Pi};
Circle(6) = {x, y, 0, Rg, 4/3*Pi, 5/3*Pi};

x = 0; y = 0;
Point(13) = {x, y, 0, h};
x = p; y = 0;
Point(14) = {x, y, 0, h};
x = p*Cos(Pi/3); y = p*Sin(Pi/3);
Point(15) = {x, y, 0, h};

Line(7) = {13, 2};
Line(8) = {2, 4};
Line(9) = {4, 7};
Line(10) = {7, 5};
Line(11) = {5, 14};
Line(12) = {14, 6};
Line(13) = {6, 8};
Line(14) = {8, 11};
Line(15) = {11, 9};
Line(16) = {9, 15};
Line(17) = {15, 10};
Line(18) = {10, 12};
Line(19) = {12, 3};
Line(20) = {3, 1};
Line(21) = {1, 13};

Curve Loop(1) = {7, -1, 21};
Plane Surface(1) = {1};
Curve Loop(2) = {1, 8, -2, 20};
Plane Surface(2) = {2};
Curve Loop(3) = {11, 12, -3};
Plane Surface(3) = {3};
Curve Loop(4) = {3, 13, -4, 10};
Plane Surface(4) = {4};
Curve Loop(5) = {16, 17, -5};
Plane Surface(5) = {5};
Curve Loop(6) = {5, 18, -6, 15};
Plane Surface(6) = {6};
Curve Loop(7) = {2, 9, 4, 14, 6, 19};
Plane Surface(7) = {7};
Curve Loop(8) = {4, -13, -3, -10};
Plane Surface(8) = {8};

Physical Surface("fuel_bottom") = {1, 5};
Physical Surface("cool_bot") = {3};
Physical Surface("mod_bottom") = {7};
Physical Surface("gap") = {2, 6};
Physical Surface("film") = {4};

// fuel
Transfinite Line{7, 21, 16, 17} = Lf;
Transfinite Line{11, 12} = Lc;
Transfinite Line{19} = Lm1;
Transfinite Line{9, 14} = Lm2;

Mesh.CharacteristicLengthFactor = 0.1;
Mesh.CharacteristicLengthExtendFromBoundary = 2;
Mesh.CharacteristicLengthFromCurvature = 1;

Color Red{Surface{1, 5};}
Color Green{Surface{2, 6};}
Color Grey{Surface{7};}
Color Yellow{Surface{4, 8};}
Color Blue{Surface{3};}
