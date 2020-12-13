// Defines three cooling channels and square plenum
SetFactory("OpenCASCADE");

Rc = 0.7;

// Circles
x = 0; y = 1.;
Circle(1) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 3;
Circle(2) = { x, y, 0, Rc, -Pi/2, Pi/2};
x = 0; y = 5;
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

Extrude {0, 0, 5} {
   Surface{1}; Surface{2}; Surface{3};
   Layers{40};
}

Point(13) = {0, 0, 5, 1.0};
Point(14) = {0, 6, 5, 1.0};
Point(15) = {1.5, 0, 5, 1.0};
Point(16) = {1.5, 6, 5, 1.0};

Line(19) = {13, 15};
Line(20) = {15, 16};
Line(21) = {16, 14};
Line(22) = {14, 11};
Line(23) = {12, 9};
Line(24) = {10, 7};
Line(25) = {8, 13};
Curve Loop(14) = {19, 20, 21, 22, 17, 23, 13, 24, 9, 25};
Plane Surface(13) = {14};

Extrude {0, 0, 5} {
  Surface{6}; Surface{9}; Surface{12}; Surface{13};
  Layers{40};
}

Physical Volume(1) = {3, 2, 1, 6, 5, 4, 7};
Physical Surface("channel_wall") = {10, 7, 4};
Physical Surface("plenum_wall") = {21, 18, 15, 28, 27, 29, 26, 25, 24, 23};
Physical Surface("plenum") = {13};
Physical Surface("channel1_bot") = {1};
Physical Surface("channel2_bot") = {2};
Physical Surface("channel3_bot") = {3};
Physical Surface("channel_flat") = {5, 8, 11};
Physical Surface("cool_top") = {16, 19, 22, 30};

Physical Surface("channel1_top") = {6};
Physical Surface("channel2_top") = {9};
Physical Surface("channel3_top") = {12};

Mesh.CharacteristicLengthFactor = 0.6;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCurvePoints = 10;//+

