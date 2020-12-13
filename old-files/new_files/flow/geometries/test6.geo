// Defines three cooling channels and square plenum
SetFactory("OpenCASCADE");

Rc = 0.7;

// Circles
x = 0; y = 1.;
Circle(1) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(1) = {1};
Plane Surface(1) = {1};

x = 0; y = 3;
Circle(2) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(2) = {2};
Plane Surface(2) = {2};

x = 0; y = 5;
Circle(3) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(3) = {3};
Plane Surface(3) = {3};

Extrude {0, 0, 5} {
   Surface{1}; Surface{2}; Surface{3};
   Layers{40};
}

Point(7) = {1.5, 6, 5, 1.0};
Point(8) = {1.5, 0, 5, 1.0};
Point(9) = {-1.5, 6, 5, 1.0};
Point(10) = {-1.5, 0, 5, 1.0};

Line(10) = {7, 8};
Line(11) = {8, 10};
Line(12) = {10, 9};
Line(13) = {9, 7};
Curve Loop(10) = {12, 13, 10, 11};
Curve Loop(11) = {9};
Curve Loop(12) = {7};
Curve Loop(13) = {5};
Plane Surface(10) = {10, 11, 12, 13};

Extrude {0, 0, 5} {
  Surface{5}; Surface{7}; Surface{9}; Surface{10};
  Layers{40};
}

Physical Volume("coolant") = {3, 2, 1, 6, 5, 4, 7};
Physical Surface("channel_wall") = {8, 6, 4};
Physical Surface("plenum_wall") = {17, 20, 19, 18};
Physical Surface("plenum") = {10};
Physical Surface("channel1_bot") = {1};
Physical Surface("channel2_bot") = {2};
Physical Surface("channel3_bot") = {3};
Physical Surface("cool_top") = {16, 14, 12, 21};

Physical Surface("channel1_top") = {5};
Physical Surface("channel2_top") = {7};
Physical Surface("channel3_top") = {9};

Mesh.CharacteristicLengthFactor = 1;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 10;

