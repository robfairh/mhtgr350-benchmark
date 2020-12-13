// Defines a 3D single cooling channel
SetFactory("OpenCASCADE");

Rc = 1.0;

// Circles
x = 0; y = 0;
Circle(1) = { x, y, 0, Rc, 0, 2*Pi};
Curve Loop(1) = {1};
Plane Surface(1) = {1};

Extrude {0, 0, 100} {
   Surface{1};
   Layers{200};
}

Physical Volume('coolant') = {1};
Physical Surface('bottom') = {1};
Physical Surface('top') = {3};
Physical Surface('wall') = {2};

Mesh.CharacteristicLengthFactor = 0.4;
Mesh.CharacteristicLengthExtendFromBoundary = 1;
Mesh.CharacteristicLengthFromCurvature = 1;
Mesh.MinimumCirclePoints = 25;
