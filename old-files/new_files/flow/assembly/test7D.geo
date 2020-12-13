// Defines three cooling channels and square plenum
SetFactory("OpenCASCADE");

Rc = 0.7;

p = 1.88;
f = p*Cos(Pi/6);

h = 1.0;
P = 14.5; // flat-to-flat distance/2
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
x = 3/2*p; y = 3*f;
Circle(5) = { x, y, 0, Rc, Pi/3, 4*Pi/3};
x = 3/2*p; y = 5*f;
Circle(6) = { x, y, 0, Rc, 0, 2*Pi};
x = 3/2*p; y = 7*f;
Circle(7) = { x, y, 0, Rc, 0, 2*Pi};
x = 3*p; y = 6*f;
Circle(8) = { x, y, 0, Rc, Pi/3, 4*Pi/3};
x = 3*p; y = 8*f;
Circle(9) = { x, y, 0, Rc, 0, 2*Pi};

Line(10) = {9, 10};
Line(11) = {13, 14};
Line(12) = {2, 1};
Line(13) = {4, 3};
Line(14) = {6, 5};
Line(15) = {8, 7};
Curve Loop(1) = {1, 12};
Plane Surface(1) = {1};
Curve Loop(2) = {2, 13};
Plane Surface(2) = {2};
Curve Loop(3) = {3, 14};
Plane Surface(3) = {3};
Curve Loop(4) = {4, 15};
Plane Surface(4) = {4};
Curve Loop(5) = {10, -5};
Plane Surface(5) = {5};
Curve Loop(6) = {6};
Plane Surface(6) = {6};
Curve Loop(7) = {7};
Plane Surface(7) = {7};
Curve Loop(8) = {11, -8};
Plane Surface(8) = {8};
Curve Loop(9) = {9};
Plane Surface(9) = {9};

Extrude {0, 0, 5} {
   Surface{1}; Surface{2}; Surface{3}; Surface{4}; Surface{5};
   Surface{6}; Surface{7}; Surface{8}; Surface{9};
   Layers{40};
}

x = 0; y = 0;
Point(31) = {x, y, H1, h};
x = 0; y = P;
Point(32) = {x, y, H1, h};
x = F; y = P;
Point(33) = {x, y, H1, h};

Line(46) = {31, 24};
Line(47) = {25, 28};
Line(48) = {29, 33};
Line(49) = {33, 32};
Line(50) = {32, 22};
Line(51) = {23, 20};
Line(52) = {21, 18};
Line(53) = {19, 16};
Line(54) = {17, 31};
Curve Loop(34) = {46, 35, 47, 43, 48, 49, 50, 30, 51, 26, 52, 22, 53, 18, 54};
Curve Loop(35) = {37};
Curve Loop(36) = {39};
Curve Loop(37) = {45};
Plane Surface(34) = {34, 35, 36, 37};

Extrude {0, 0, 5} {
  Surface{12}; Surface{15}; Surface{18}; Surface{21}; Surface{24};
  Surface{26}; Surface{28}; Surface{31}; Surface{33}; Surface{34};
  Layers{40};
}

Physical Volume('coolant') = {
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
  11, 12, 13, 14, 15, 16, 17, 18, 19
};

Physical Surface("cool_top") = {37, 40, 43, 46, 49, 51, 53, 56, 58, 68};
Physical Surface("plenum_wall") = {63, 45, 64, 42, 65, 39, 66, 36, 67, 59, 47, 60, 54, 61, 62};
Physical Surface("plenum") = {34};
Physical Surface("channel_wall") = {10, 13, 16, 19, 23, 25, 27, 30, 32};
Physical Surface("channel_flat") = {11, 14, 17, 20, 22, 29};
Physical Surface("channel1_bot") = {1};
Physical Surface("channel2_bot") = {2};
Physical Surface("channel3_bot") = {3};
Physical Surface("channel4_bot") = {4};
Physical Surface("channel5_bot") = {5};
Physical Surface("channel6_bot") = {6};
Physical Surface("channel7_bot") = {7};
Physical Surface("channel8_bot") = {8};
Physical Surface("channel9_bot") = {9};

Transfinite Line{54} = 8;
Transfinite Line{46, 47, 48} = 14;

Mesh.CharacteristicLengthFactor = 0.6;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCurvePoints = 10;

