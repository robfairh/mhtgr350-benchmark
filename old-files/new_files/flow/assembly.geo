// 1/12th of the 3D fuel assembly geometry with top plenum
// All the coolant channels are one subdomain
SetFactory("OpenCASCADE");

Rc = 0.794;
Rsc = 0.635;   // small coolant channel

p = 1.88;
f = p*Cos(Pi/6);

P = 18; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;

h = 1.0;

// Hc = 793;
Hc = 15;
Lc = 50; // Axial layers in the core

// Circles
x = 0; y = 2*f;
Circle(1) = { x, y, 0, Rsc, -Pi/2, Pi/2};
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

// Points & Lines
x = 0; y = 0;
Point(22) = {x, y, 0, h};
x = 0; y = P;
Point(23) = {x, y, 0, h};
x = F; y = P;
Point(24) = {x, y, 0, h};

Line(14) = {22, 11};
Line(15) = {11, 12};
Line(16) = {12, 16};
Line(17) = {16, 17};
Line(18) = {17, 20};
Line(19) = {20, 21};
Line(20) = {21, 24};
Line(21) = {24, 23};
Line(22) = {23, 9};
Line(23) = {9, 10};
Line(24) = {10, 7};
Line(25) = {7, 8};
Line(26) = {8, 5};
Line(27) = {5, 6};
Line(28) = {6, 3};
Line(29) = {3, 4};
Line(30) = {4, 1};
Line(31) = {1, 2};
Line(32) = {2, 22};

Curve Loop(1) = {31, -1};
Plane Surface(1) = {1};
Curve Loop(2) = {29, -2};
Plane Surface(2) = {2};
Curve Loop(3) = {27, -3};
Plane Surface(3) = {3};
Curve Loop(4) = {25, -4};
Plane Surface(4) = {4};
Curve Loop(5) = {23, -5};
Plane Surface(5) = {5};
Curve Loop(6) = {6, -15};
Plane Surface(6) = {6};
Curve Loop(7) = {7};
Plane Surface(7) = {7};
Curve Loop(8) = {8};
Plane Surface(8) = {8};
Curve Loop(9) = {9};
Plane Surface(9) = {9};
Curve Loop(10) = {10, -17};
Plane Surface(10) = {10};
Curve Loop(11) = {11};
Plane Surface(11) = {11};
Curve Loop(12) = {12};
Plane Surface(12) = {12};
Curve Loop(13) = {13, -19};
Plane Surface(13) = {13};
Curve Loop(14) = {14, 6, 16, 10, 18, 13, 20, 21, 22, 5, 24, 4, 26, 3, 28, 2, 30, 1, 32};
Curve Loop(15) = {7};
Curve Loop(16) = {8};
Curve Loop(17) = {9};
Curve Loop(18) = {11};
Curve Loop(19) = {12};
Plane Surface(14) = {14, 15, 16, 17, 18, 19};

Extrude {0, 0, Hc} {
  Surface{1};  Surface{2};  Surface{3};  Surface{4};  Surface{5};
  Surface{6};  Surface{7};  Surface{8};  Surface{9};  Surface{10};
  Surface{11}; Surface{12}; Surface{13}; Surface{14};
  Layers{10};
}

Extrude {0, 0, 5} {
  Surface{17}; Surface{20}; Surface{23}; Surface{26}; Surface{29};
  Surface{32}; Surface{34}; Surface{36}; Surface{38}; Surface{41};
  Surface{43}; Surface{45}; Surface{48}; Surface{60};
  Layers{5};
}

// Physical Surface('cool_bot') = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};

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

Physical Surface("channel1_top") = {17};
Physical Surface("channel2_top") = {20};
Physical Surface("channel3_top") = {23};
Physical Surface("channel4_top") = {26};
Physical Surface("channel5_top") = {29};
Physical Surface("channel6_top") = {32};
Physical Surface("channel7_top") = {34};
Physical Surface("channel8_top") = {36};
Physical Surface("channel9_top") = {38};
Physical Surface("channel10_top") = {41};
Physical Surface("channel11_top") = {43};
Physical Surface("channel12_top") = {45};
Physical Surface("channel13_top") = {48};

Physical Surface("channel_wall") = {16, 19, 22, 25, 28, 30, 33, 35, 37, 39, 42, 44, 46};

// Physical Surface("channel1_wall") = {16};
// Physical Surface("channel2_wall") = {19};
// Physical Surface("channel3_wall") = {22};
// Physical Surface("channel4_wall") = {25};
// Physical Surface("channel5_wall") = {28};
// Physical Surface("channel6_wall") = {30};
// Physical Surface("channel7_wall") = {33};
// Physical Surface("channel8_wall") = {35};
// Physical Surface("channel9_wall") = {37};
// Physical Surface("channel10_wall") = {39};
// Physical Surface("channel11_wall") = {42};
// Physical Surface("channel12_wall") = {44};
// Physical Surface("channel13_wall") = {46};

Physical Surface("plenum") = {60};

Physical Volume('coolant') = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
Physical Volume('coolant') += {15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28};

Physical Surface('cool_top') = {63, 66, 69, 72, 75, 78, 80, 82, 84, 87, 89, 91, 94, 106};

// Mesh.CharacteristicLengthFactor = 0.3;
// Mesh.CharacteristicLengthExtendFromBoundary = 1;
// Mesh.CharacteristicLengthFromCurvature = 1;

// // Mesh.MinimumCurvePoints = 10;
// Mesh.MinimumCirclePoints = 10;


