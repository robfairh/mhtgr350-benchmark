// Defines three cooling channels and square plenum
SetFactory("OpenCASCADE");

Rc = 0.7;

p = 1.88;
f = p*Cos(Pi/6);

h = 1.0;
P = 18; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;
H1 = 5;

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

Line(12) = {2, 1};
Line(13) = {4, 3};
Line(14) = {6, 5};
Line(15) = {8, 7};
Line(16) = {10, 9};
Line(17) = {11, 12};
Line(18) = {16, 17};
Curve Loop(1) = {1, 12};
Plane Surface(1) = {1};
Curve Loop(2) = {2, 13};
Plane Surface(2) = {2};
Curve Loop(3) = {3, 14};
Plane Surface(3) = {3};
Curve Loop(4) = {4, 15};
Plane Surface(4) = {4};
Curve Loop(5) = {5, 16};
Plane Surface(5) = {5};
Curve Loop(6) = {6, -17};
Plane Surface(6) = {6};
Curve Loop(7) = {7};
Plane Surface(7) = {7};
Curve Loop(8) = {8};
Plane Surface(8) = {8};
Curve Loop(9) = {9};
Plane Surface(9) = {9};
Curve Loop(10) = {18, -10};
Plane Surface(10) = {10};
Curve Loop(11) = {11};
Plane Surface(11) = {11};

Extrude {0, 0, 5} {
   Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5};
   Surface{6}; Surface{7}; Surface{8}; Surface{9}; Surface{10};
   Surface{11};
   Layers{40};
}

p = 37;
x = 0; y = 0;
Point(p) = {x, y, H1, h}; p += 1;
x = 0; y = P;
Point(p) = {x, y, H1, h}; p += 1;
// x = 15/Cos(Pi/6)/2; y = 15;
x = F; y = P;
Point(p) = {x, y, H1, h}; p += 1;

Physical Surface("channel_wall") = {12, 15, 18, 21, 24, 34, 32, 30, 27, 37, 39};
Physical Surface("channel_flat") = {13, 16, 19, 22, 25, 28, 36};
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

Line(55) = {37, 29};
Line(56) = {30, 34};
Line(57) = {35, 39};
Line(58) = {39, 38};
Line(59) = {38, 27};
Line(60) = {28, 25};
Line(61) = {26, 23};
Line(62) = {24, 21};
Line(63) = {22, 19};
Line(64) = {20, 37};

Curve Loop(41) = {55, 41, 56, 52, 57, 58, 59, 37, 60, 33, 61, 29, 62, 25, 63, 21, 64};
Curve Loop(42) = {44};
Curve Loop(43) = {46};
Curve Loop(44) = {48};
Curve Loop(45) = {54};
Plane Surface(41) = {41, 42, 43, 44, 45};
Physical Surface("plenum") = {41};

Extrude {0, 0, 5} {
  Surface{14}; Surface{17}; Surface{20}; Surface{23}; Surface{26}; Surface{29}; Surface{31}; Surface{33}; Surface{35}; Surface{38}; Surface{40}; Surface{41}; 
  Layers{40};
}

Physical Volume('coolant') = {
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
  11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
  21, 22, 23
};

Physical Surface("plenum_wall") = {75, 55, 76, 52, 77, 49, 78, 46, 79, 43, 80, 71, 58, 72, 66, 73, 74};
Physical Surface("cool_top") = {44, 47, 50, 53, 56, 59, 61, 63, 65, 68, 70, 81};

Transfinite Line{64} = 8;
Transfinite Line{55, 56, 57} = 14;

Mesh.CharacteristicLengthFactor = 0.6;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCurvePoints = 10;