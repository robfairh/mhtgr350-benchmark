// Defines a 3D two cooling channels
SetFactory("OpenCASCADE");

Rc = 1.0;

// Circles
x = 0; y = -1.5;
Circle(1) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(1) = {1};
Plane Surface(1) = {1};

x = 0; y = 1.5;
Circle(2) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(2) = {2};
Plane Surface(2) = {2};

Extrude {0, 0, 5} {
   Surface{1}; Surface{2};
   Layers{20};
}

Point(5) = {1.5, 3, 5, 1.0};
Point(6) = {1.5, -3, 5, 1.0};
Point(7) = {-1.5, 3, 5, 1.0};
Point(8) = {-1.5, -3, 5, 1.0};

Line(7) = {8, 6};
Line(8) = {6, 5};
Line(9) = {5, 7};
Line(10) = {7, 8};
Curve Loop(7) = {10, 7, 8, 9};
Curve Loop(8) = {6};
Curve Loop(9) = {4};
Plane Surface(7) = {7, 8, 9};

Extrude {0, 0, 5} {
  Surface{7}; Surface{6}; Surface{4};
  Layers{20};
}

Physical Volume("coolant") = {2, 1, 4, 3, 5};
Physical Surface("channel_wall") = {5, 3};
Physical Surface("plenum_wall") = {8, 9, 10, 11};
Physical Surface("plenum") = {7};
Physical Surface("channel1_bot") = {1};
Physical Surface("channel2_bot") = {2};
Physical Surface("channel1_top") = {4};
Physical Surface("channel2_top") = {6};
Physical Surface("cool_top") = {15, 16, 14};

Mesh.CharacteristicLengthFactor = 1;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 10;
