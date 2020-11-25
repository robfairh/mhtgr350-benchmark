// 1/12th of the 3D fuel assembly geometry
// The film is not defined in the mesh
SetFactory("OpenCASCADE");

Rc = 0.794;
Rf = 0.6225;
Rg = 0.735;

p = 1.88;
f = p*Cos(Pi/6);

P = 18; // flat-to-flat distance/2
F = P/Cos(Pi/6)/2;

bfg = 0.15; // bypass gap

h = 1.0;

Lr1 = 10;
Lr2 = 4;
Lr3 = 5;
Lr4 = 6;
Lr5 = 4;

Hc = 793;
Lc = 50; // Axial layers in the core

// Circles
c = 1;
x = 0; y = 2*f;
Circle(c) = { x, y, 0, Rc, -Pi/2, Pi/2}; c += 1;
x = 0; y = 4*f;
Circle(c) = { x, y, 0, Rc, -Pi/2, Pi/2}; c += 1;
x = 0; y = 6*f;
Circle(c) = { x, y, 0, Rc, -Pi/2, Pi/2}; c += 1;
x = 0; y = 8*f;
Circle(c) = { x, y, 0, Rc, -Pi/2, Pi/2}; c += 1;
x = 0; y = 10*f;
Circle(c) = { x, y, 0, Rc, -Pi/2, Pi/2}; c += 1;

x = 1/2*p; y = 3*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = 1/2*p; y = 5*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = 1/2*p; y = 7*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = 1/2*p; y = 9*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;

x = p; y = 2*f;
Circle(c) = { x, y, 0, Rf, Pi/3, 4*Pi/3}; c += 1;
Circle(c) = { x, y, 0, Rg, Pi/3, 4*Pi/3}; c += 1;
x = p; y = 4*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = p; y = 6*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = p; y = 8*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = p; y = 10*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;

x = 3/2*p; y = 3*f;
Circle(c) = { x, y, 0, Rc, Pi/3, 4*Pi/3}; c += 1;
x = 3/2*p; y = 5*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi}; c += 1;
x = 3/2*p; y = 7*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi}; c += 1;
x = 3/2*p; y = 9*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi}; c += 1;

x = 2*p; y = 4*f;
Circle(c) = { x, y, 0, Rf, Pi/3, 4*Pi/3}; c += 1;
Circle(c) = { x, y, 0, Rg, Pi/3, 4*Pi/3}; c += 1;
x = 2*p; y = 6*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = 2*p; y = 8*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = 2*p; y = 10*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;

x = 5/2*p; y = 5*f;
Circle(c) = { x, y, 0, Rf, Pi/3, 4*Pi/3}; c += 1;
Circle(c) = { x, y, 0, Rg, Pi/3, 4*Pi/3}; c += 1;
x = 5/2*p; y = 7*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;
x = 5/2*p; y = 9*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;

x = 3*p; y = 6*f;
Circle(c) = { x, y, 0, Rc, Pi/3, 4*Pi/3}; c += 1;
x = 3*p; y = 8*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi}; c += 1;
x = 3*p; y = 10*f;
Circle(c) = { x, y, 0, Rc, 0, 2*Pi}; c += 1;

x = 7/2*p; y = 7*f;
Circle(c) = { x, y, 0, Rf, Pi/3, 4*Pi/3}; c += 1;
Circle(c) = { x, y, 0, Rg, Pi/3, 4*Pi/3}; c += 1;
x = 7/2*p; y = 9*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;

x = 4*p; y = 8*f;
Circle(c) = { x, y, 0, Rf, Pi/3, 4*Pi/3}; c += 1;
Circle(c) = { x, y, 0, Rg, Pi/3, 4*Pi/3}; c += 1;
x = 4*p; y = 10*f;
Circle(c) = { x, y, 0, Rf, 0, 2*Pi}; c += 1;
Circle(c) = { x, y, 0, Rg, 0, 2*Pi}; c += 1;

x = 9/2*p; y = 9*f;
Circle(c) = { x, y, 0, Rc, Pi/3, 4*Pi/3}; c += 1;

x = 5*p; y = 10*f;
Circle(c) = { x, y, 0, Rf, Pi/3, 4*Pi/3}; c += 1;
Circle(c) = { x, y, 0, Rg, Pi/3, 4*Pi/3}; c += 1;

// Center channel
x = 0; y = 0;
Circle(c) = { x, y, 0, 3.75/2, Pi/3, Pi/2}; c += 1;

// Points & Lines
x = 0; y = 0;
Point(78) = {x, y, 0, h};
x = 0; y = P;
Point(79) = {x, y, 0, h};
x = F; y = P;
Point(80) = {x, y, 0, h};

Line(57) = {78, 77};
Line(58) = {77, 21};
Line(59) = {21, 19};
Line(60) = {19, 20};
Line(61) = {20, 22};
Line(62) = {22, 31};
Line(63) = {31, 32};
Line(64) = {32, 38};
Line(65) = {38, 36};
Line(66) = {36, 37};
Line(67) = {37, 39};
Line(68) = {39, 48};
Line(69) = {48, 46};
Line(70) = {46, 47};
Line(71) = {47, 49};
Line(72) = {49, 54};
Line(73) = {54, 55};
Line(74) = {55, 60};
Line(75) = {60, 58};
Line(76) = {58, 59};
Line(77) = {59, 61};
Line(78) = {61, 66};
Line(79) = {66, 64};
Line(80) = {64, 65};
Line(81) = {65, 67};
Line(82) = {67, 70};
Line(83) = {70, 71};
Line(84) = {71, 74};
Line(85) = {74, 72};
Line(86) = {72, 73};
Line(87) = {73, 75};
Line(88) = {75, 80};
Line(89) = {78, 76};
Line(90) = {76, 2};
Line(91) = {2, 1};
Line(92) = {1, 4};
Line(93) = {4, 3};
Line(94) = {3, 6};
Line(95) = {6, 5};
Line(96) = {5, 8};
Line(97) = {8, 7};
Line(98) = {7, 10};
Line(99) = {10, 9};
Line(100) = {9, 79};
Line(101) = {79, 80};
Curve Loop(1) = {15, -61, -14, -59};
Plane Surface(1) = {1};
Curve Loop(2) = {7};
Curve Loop(3) = {6};
Plane Surface(2) = {2, 3};
Curve Loop(4) = {17};
Curve Loop(5) = {16};
Plane Surface(3) = {4, 5};
Curve Loop(6) = {9};
Curve Loop(7) = {8};
Plane Surface(4) = {6, 7};
Curve Loop(8) = {37, -71, -36, -69};
Plane Surface(5) = {8};
Curve Loop(9) = {19};
Curve Loop(10) = {18};
Plane Surface(6) = {9, 10};
Curve Loop(11) = {31};
Curve Loop(12) = {30};
Plane Surface(7) = {11, 12};
Curve Loop(13) = {11};
Curve Loop(14) = {10};
Plane Surface(8) = {13, 14};
Curve Loop(15) = {39};
Curve Loop(16) = {39};
Curve Loop(17) = {38};
Plane Surface(9) = {15, 16, 17};
Curve Loop(18) = {46, -77, -45, -75};
Plane Surface(10) = {18};
Curve Loop(19) = {21};
Curve Loop(20) = {20};
Plane Surface(11) = {19, 20};
Curve Loop(21) = {33};
Curve Loop(22) = {32};
Plane Surface(12) = {21, 22};
Curve Loop(23) = {50, -81, -49, -79};
Plane Surface(13) = {23};
Curve Loop(24) = {13};
Curve Loop(25) = {12};
Plane Surface(14) = {24, 25};
Curve Loop(26) = {41};
Curve Loop(27) = {40};
Plane Surface(15) = {26, 27};
Curve Loop(28) = {48};
Curve Loop(29) = {47};
Plane Surface(16) = {28, 29};
Curve Loop(30) = {23};
Curve Loop(31) = {22};
Plane Surface(17) = {30, 31};
Curve Loop(32) = {35};
Curve Loop(33) = {34};
Plane Surface(18) = {32, 33};
Curve Loop(34) = {52};
Curve Loop(35) = {51};
Plane Surface(19) = {34, 35};
Curve Loop(36) = {55, -87, -54, -85};
Plane Surface(20) = {36};
Curve Loop(37) = {14, -60};
Plane Surface(21) = {37};
Curve Loop(38) = {6};
Plane Surface(22) = {38};
Curve Loop(39) = {16};
Plane Surface(23) = {39};
Curve Loop(40) = {28, -66};
Plane Surface(24) = {40};
Curve Loop(41) = {8};
Plane Surface(25) = {41};
Curve Loop(42) = {36, -70};
Plane Surface(26) = {42};
Curve Loop(43) = {18};
Plane Surface(27) = {43};
Curve Loop(44) = {30};
Plane Surface(28) = {44};
Curve Loop(45) = {10};
Plane Surface(29) = {45};
Curve Loop(46) = {38};
Plane Surface(30) = {46};
Curve Loop(47) = {45, -76};
Plane Surface(31) = {47};
Curve Loop(48) = {20};
Plane Surface(32) = {48};
Curve Loop(49) = {32};
Plane Surface(33) = {49};
Curve Loop(50) = {49, -80};
Plane Surface(34) = {50};
Curve Loop(51) = {12};
Plane Surface(35) = {51};
Curve Loop(52) = {40};
Plane Surface(36) = {52};
Curve Loop(53) = {47};
Plane Surface(37) = {53};
Curve Loop(54) = {22};
Plane Surface(38) = {54};
Curve Loop(55) = {34};
Plane Surface(39) = {55};
Curve Loop(56) = {51};
Plane Surface(40) = {56};
Curve Loop(57) = {54, -86};
Plane Surface(41) = {57};
Curve Loop(58) = {56, 58, 15, 62, 24, 64, 29, 68, 37, 72, 42, 74, 46, 78, 50, 82, 53, 84, 55, 88, -101, -100, 5, -98, 4, -96, 3, -94, 2, -92, 1, -90};
Curve Loop(59) = {7};
Curve Loop(60) = {17};
Curve Loop(61) = {9};
Curve Loop(62) = {25};
Curve Loop(63) = {19};
Curve Loop(64) = {31};
Curve Loop(65) = {11};
Curve Loop(66) = {26};
Curve Loop(67) = {39};
Curve Loop(68) = {21};
Curve Loop(69) = {33};
Curve Loop(70) = {43};
Curve Loop(71) = {13};
Curve Loop(72) = {27};
Curve Loop(73) = {41};
Curve Loop(74) = {48};
Curve Loop(75) = {23};
Curve Loop(76) = {35};
Curve Loop(77) = {44};
Curve Loop(78) = {52};
Plane Surface(42) = {58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78};
Curve Loop(79) = {29, -67, -28, -65};
Plane Surface(43) = {79};
Curve Loop(80) = {39};
Curve Loop(81) = {38};
Plane Surface(44) = {80, 81};

Physical Surface("moderator") = {42};
Physical Surface("fuel") = {21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41};
Physical Surface("gap") = {1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 43, 44, 45};
Physical Curve("coolant") = {56, 1, 24, 2, 25, 3, 26, 42, 4, 43, 27, 53, 44, 5};
Physical Curve("bypass") = {101};

// moderator top left corner
Transfinite Line{100} = 5;
// moderator top right corner
Transfinite Line{88} = 6;
// moderator left side
Transfinite Line{90, 92, 94, 96, 98} = 6;
// moderator right side
Transfinite Line{58, 62, 64, 68, 72, 74, 78, 82, 84} = 4;
// fuel right side
Transfinite Line{60, 66, 70, 76, 80, 86} = 6;
// Central hole
Transfinite Line{56} = 6;

Mesh.CharacteristicLengthFactor = 0.8;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 12;
Mesh.MinimumCurvePoints = 12;

// Moderator
Color Grey{Surface{42};}
// Gap
Color Grey{Surface{1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 44, 12, 13, 14, 15, 16, 17, 18, 19, 20};}
// Fuel
Color Red{Surface{21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41};}
