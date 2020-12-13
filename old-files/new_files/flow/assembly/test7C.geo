// Defines three cooling channels and square plenum
SetFactory("OpenCASCADE");

Rc = 0.794;

p = 1.88;
f = p*Cos(Pi/6);

h = 1.0;
P = 11; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;
H1 = 40;
H2 = 40;
n1 = 200;
n2 = 200;

// Circles
x = 0; y = 2*f;
Circle(1) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 4*f;
Circle(2) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 6*f;
Circle(3) = { x, y, 0, Rc, -Pi/2, Pi/2};

Line(4) = {2, 1};
Line(5) = {4, 3};
Line(6) = {6, 5};
Curve Loop(1) = {1, 4};
Plane Surface(1) = {1};
Curve Loop(2) = {2, 5};
Plane Surface(2) = {2};
Curve Loop(3) = {3, 6};
Curve Loop(4) = {3, 6};
Plane Surface(3) = {4};

x = 3/2*p; y = 3*f;
Circle(7) = { x, y, 0, Rc, Pi/3, 4*Pi/3};
x = 3/2*p; y = 5*f;
Circle(8) = { x, y, 0, Rc, 0, 2*Pi};

Line(9) = {7, 8};
Curve Loop(5) = {9, -7};
Plane Surface(4) = {5};
Curve Loop(6) = {8};
Curve Loop(7) = {8};
Plane Surface(5) = {7};

Extrude {0, 0, H1} {
   Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5};
   Layers{n1};
}

x = 0; y = 0;
Point(19) = {x, y, H1, h};
x = 0; y = P;
Point(20) = {x, y, H1, h};
x = F; y = P;
Point(21) = {x, y, H1, h};

Line(28) = {19, 16};
Line(29) = {17, 21};
Line(30) = {21, 20};
Line(31) = {20, 14};
Line(32) = {15, 12};
Line(33) = {13, 10};
Line(34) = {11, 19};
Curve Loop(22) = {28, 25, 29, 30, 31, 20, 32, 16, 33, 12, 34};
Curve Loop(23) = {27};
Plane Surface(20) = {22, 23};

Extrude {0, 0, H2} {
  Surface{8}; Surface{11}; Surface{14}; Surface{17}; Surface{19}; Surface{20}; 
  Layers{n2};
}

Physical Volume(1) = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};

Physical Surface("cool_top") = {23, 26, 29, 32, 34, 42};
Physical Surface("plenum_wall") = {38, 28, 39, 25, 40, 22, 41, 35, 30, 36, 37};
Physical Surface("plenum") = {20};
Physical Surface("channel_wall") = {6, 9, 12, 16, 18};
Physical Surface("channel123_flat") = {7, 10, 13};
Physical Surface("channel4_flat") = {15};
Physical Surface("channel1_bot") = {1};
Physical Surface("channel2_bot") = {2};
Physical Surface("channel3_bot") = {3};
Physical Surface("channel4_bot") = {4};
Physical Surface("channel5_bot") = {5};

Transfinite Line{4, 5, 6, 9} = 8;
Transfinite Line{34} = 8;
Transfinite Line{28} = 14;
Transfinite Line{29} = 20;
Transfinite Line{32, 33} = 8;
Transfinite Line{30} = 16;

Mesh.CharacteristicLengthFactor = 0.6;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 25;
// Mesh.MinimumCurvePoints = 20;