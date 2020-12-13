// Defines three cooling channels and square plenum
SetFactory("OpenCASCADE");

Rc = 0.794;

p = 1.88;
f = p*Cos(Pi/6);

h = 1.0;
P = 18; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;

H1 = 20;
n1 = 100;
H2 = 20;
n2 = 100;

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

Line(14) = {11, 12};
Line(15) = {16, 17};
Line(16) = {20, 21};
Line(17) = {9, 10};
Line(18) = {7, 8};
Line(19) = {5, 6};
Line(20) = {3, 4};
Line(21) = {1, 2};
Curve Loop(1) = {1, -21};
Plane Surface(1) = {1};
Curve Loop(2) = {2, -20};
Plane Surface(2) = {2};
Curve Loop(3) = {3, -19};
Plane Surface(3) = {3};
Curve Loop(4) = {4, -18};
Plane Surface(4) = {4};
Curve Loop(5) = {5, -17};
Plane Surface(5) = {5};
Curve Loop(6) = {14, -6};
Plane Surface(6) = {6};
Curve Loop(7) = {7};
Plane Surface(7) = {7};
Curve Loop(8) = {8};
Plane Surface(8) = {8};
Curve Loop(9) = {9};
Plane Surface(9) = {9};
Curve Loop(10) = {15, -10};
Plane Surface(10) = {10};
Curve Loop(11) = {11};
Plane Surface(11) = {11};
Curve Loop(12) = {12};
Plane Surface(12) = {12};
Curve Loop(13) = {16, -13};
Plane Surface(13) = {13};

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

Extrude {0, 0, H1} {
   Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5};
   Surface{6}; Surface{7}; Surface{8}; Surface{9}; Surface{10};
   Surface{11}; Surface{12}; Surface{13};
   Layers{n1};
}

p = 43;
x = 0; y = 0;
Point(p) = {x, y, H1, h}; p += 1;
x = 0; y = P;
Point(p) = {x, y, H1, h}; p += 1;
x = F; y = P;
Point(p) = {x, y, H1, h}; p += 1;

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
Physical Surface("plenum") = {48};

Physical Surface("channel_wall") = {14, 17, 20, 23, 26, 30, 32, 34, 36, 39, 41, 43, 46};
Physical Surface("channel_flat") = {15, 18, 21, 24, 27, 29, 38, 45};

Extrude {0, 0, H2} {
  Surface{16}; Surface{19}; Surface{22}; Surface{25}; Surface{28}; Surface{31}; Surface{33}; Surface{35}; Surface{37}; Surface{40}; Surface{42}; Surface{44}; Surface{47}; Surface{48}; 
  Layers{n2};
}

Physical Volume('coolant') = {
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
  11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  21, 22, 23, 24, 25, 26, 27
};

Physical Surface("plenum_wall") = {88, 62, 89, 59, 90, 56, 91, 53, 92, 50, 93, 83, 64, 84, 73, 85, 80, 86, 87};
Physical Surface("cool_top") = {51, 54, 57, 60, 63, 66, 68, 70, 72, 75, 77, 79, 82, 94};

Transfinite Line{74} = 8;
Transfinite Line{64, 65, 66} = 14;
Transfinite Line{21, 20, 19, 18, 17, 14, 15, 16} = 8;
Transfinite Line{73, 72, 71, 70} = 8;
Transfinite Line{69} = 6;
Transfinite Line{67} = 8;
Transfinite Line{68} = 20;

Mesh.CharacteristicLengthFactor = 1;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 20;
Mesh.MinimumCurvePoints = 20;