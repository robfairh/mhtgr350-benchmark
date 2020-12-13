// Defines a 3D two cooling channels
SetFactory("OpenCASCADE");

Rc = 0.794;
// Rc = 1.0;

p = 1.88;
f = p/Cos(Pi/6);

// Circles
x = 0; y = -f;
Circle(1) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(1) = {1};
Plane Surface(1) = {1};

x = 0; y = f;
Circle(2) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(2) = {2};
Plane Surface(2) = {2};

Extrude {0, 0, 5} {
   Surface{1}; Surface{2};
   Layers{20};
}

Point(5) = {3/4*p, 2*f, 5, 1.0};
Point(6) = {3/4*p, -2*f, 5, 1.0};
Point(7) = {-3/4*p, 2*f, 5, 1.0};
Point(8) = {-3/4*p, -2*f, 5, 1.0};

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
Physical Surface("cool_bot") = {1, 2};
Physical Surface("cool_top") = {15, 16, 14};

Mesh.CharacteristicLengthFactor = 1;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 10;
