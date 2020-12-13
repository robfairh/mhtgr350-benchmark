// Defines twelve cooling channels and square plenum
SetFactory("OpenCASCADE");

Rc = 0.7;

p = 1.88;
f = p*Cos(Pi/6);

P = 18; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;

h = 1.0;
H1 = 10;
H2 = 5;

L1 = 80;
L2 = 40;
// Circles
x = 0; y = 2*f;
Circle(1) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 4*f;
Circle(2) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 6*f;
Circle(3) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 8*f;
Circle(4) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 10*f;
Circle(5) = { x, y, 0, Rc, -Pi/2, Pi/2};

x = 3/2*p; y = 3*f;
Circle(6) = { x, y, 0, Rc, Pi/3, 4*Pi/3};
x = 3/2*p; y = 5*f;
Circle(7) = { x, y, 0, Rc, 0, 2*Pi};
x = 3/2*p; y = 7*f;
Circle(8) = { x, y, 0, Rc, 0, 2*Pi};
x = 3/2*p; y = 9*f;
Circle(9) = { x, y, 0, Rc, 0, 2*Pi};

x = 3*p; y = 6*f;
Circle(10) = { x, y, 0, Rc, Pi/3, 4*Pi/3};
x = 3*p; y = 8*f;
Circle(11) = { x, y, 0, Rc, 0, 2*Pi};
x = 3*p; y = 10*f;
Circle(12) = { x, y, 0, Rc, 0, 2*Pi};

x = 9/2*p; y = 9*f;
Circle(13) = { x, y, 0, Rc, Pi/3, 4*Pi/3};

Line(14) = {2, 1};
Line(15) = {4, 3};
Line(16) = {6, 5};
Line(17) = {8, 7};
Line(18) = {10, 9};
Line(19) = {11, 12};
Line(20) = {16, 17};
Line(21) = {20, 21};
Curve Loop(1) = {1, 14};
Plane Surface(1) = {1};
Curve Loop(2) = {2, 15};
Plane Surface(2) = {2};
Curve Loop(3) = {3, 16};
Plane Surface(3) = {3};
Curve Loop(4) = {4, 17};
Plane Surface(4) = {4};
Curve Loop(5) = {5, 18};
Plane Surface(5) = {5};
Curve Loop(6) = {19, -6};
Plane Surface(6) = {6};
Curve Loop(7) = {7};
Plane Surface(7) = {7};
Curve Loop(8) = {8};
Plane Surface(8) = {8};
Curve Loop(9) = {9};
Plane Surface(9) = {9};
Curve Loop(10) = {20, -10};
Plane Surface(10) = {10};
Curve Loop(11) = {11};
Plane Surface(11) = {11};
Curve Loop(12) = {12};
Plane Surface(12) = {12};
Curve Loop(13) = {21, -13};
Plane Surface(13) = {13};

Extrude {0, 0, H1} {
   Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5};
   Surface{6}; Surface{7}; Surface{8}; Surface{9}; Surface{10};
   Surface{11}; Surface{12}; Surface{13};
   Layers{L1};
}

x = 0; y = 0;
Point(43) = {x, y, H1, h};
x = 0; y = P;
Point(44) = {x, y, H1, h};
x = F; y = P;
Point(45) = {x, y, H1, h};

Line(64) = {43, 32};
Line(65) = {33, 37};
Line(66) = {38, 41};
Line(67) = {42, 45};
Line(68) = {45, 44};
Line(69) = {44, 30};
Line(70) = {31, 28};
Line(71) = {29, 26};
Line(72) = {27, 24};
Line(73) = {25, 22};
Line(74) = {23, 43};
Curve Loop(48) = {64, 45, 65, 55, 66, 63, 67, 68, 69, 40, 70, 36, 71, 32, 72, 28, 73, 24, 74};
Curve Loop(49) = {47};
Curve Loop(50) = {49};
Curve Loop(51) = {51};
Curve Loop(52) = {57};
Curve Loop(53) = {59};
Plane Surface(48) = {48, 49, 50, 51, 52, 53};

Extrude {0, 0, H2} {
  Surface{16}; Surface{19}; Surface{22}; Surface{25}; Surface{28};
  Surface{31}; Surface{33}; Surface{35}; Surface{37}; Surface{40};
  Surface{42}; Surface{44}; Surface{47}; Surface{48};
  Layers{L2};
}

Physical Volume("coolant") = {
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27
};
Physical Surface("channel_wall") = {
  14, 17, 20, 23, 26, 30, 32, 34, 36, 39, 41, 43, 46
};
Physical Surface("plenum_wall") = {
  93, 50, 92, 53, 91, 56, 90, 59, 89, 62, 88, 83, 64, 84, 73, 85, 80, 86, 87
};
Physical Surface("plenum") = {48};

Physical Surface("channel1_bot") = {1};
Physical Surface("channel2_bot") = {2};
Physical Surface("channel3_bot") = {3};
Physical Surface("channel4_bot") = {4};
Physical Surface("channel5_bot") = {5};
Physical Surface("channel6_bot") = {6};
Physical Surface("channel7_bot") = {7};
Physical Surface("channel8_bot") = {8};
Physical Surface("channel9_bot") = {9};
Physical Surface("channel10_bot") = {10};
Physical Surface("channel11_bot") = {11};
Physical Surface("channel12_bot") = {12};
Physical Surface("channel13_bot") = {13};

Physical Surface('channel1_top') = {16};
Physical Surface('channel2_top') = {19};
Physical Surface('channel3_top') = {22};
Physical Surface('channel4_top') = {25};
Physical Surface('channel5_top') = {28};
Physical Surface('channel6_top') = {31};
Physical Surface('channel7_top') = {33};
Physical Surface('channel8_top') = {35};
Physical Surface('channel9_top') = {37};
Physical Surface('channel10_top') = {40};
Physical Surface('channel11_top') = {42};
Physical Surface('channel12_top') = {44};
Physical Surface('channel13_top') = {47};

Physical Surface("cool_top") = {51, 54, 57, 60, 63, 66, 68, 70, 72, 75, 77, 79, 82, 94};

Physical Surface("channel1_flat") = {15};
Physical Surface("channel2_flat") = {18};
Physical Surface("channel3_flat") = {21};
Physical Surface("channel4_flat") = {24};
Physical Surface("channel5_flat") = {27};
Physical Surface("channel6_flat") = {29};
Physical Surface("channel10_flat") = {38};
Physical Surface("channel13_flat") = {45};

// cooling channels
Transfinite Line{14, 15, 16, 17, 18, 19, 20, 21} = 7;
// moderator right side
Transfinite Line{64, 65, 66, 67} = 9;
// moderator left side
Transfinite Line{74, 73, 72, 71, 70, 69} = 6;

Mesh.CharacteristicLengthFactor = 1;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 10;
Mesh.MinimumCurvePoints = 10;

